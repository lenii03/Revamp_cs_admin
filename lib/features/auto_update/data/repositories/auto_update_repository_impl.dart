import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:el_csadmin/data/remote/dio_client.dart';
import 'package:el_csadmin/data/remote/dio_exception.dart';
import 'package:el_csadmin/features/auto_update/data/models/file_hash_model.dart';
import 'package:el_csadmin/features/auto_update/data/repositories/isolatewrite_args.dart';
import 'package:el_csadmin/features/auto_update/domain/repositories/auto_update_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AutoUpdateRepositoryImpl implements AutoUpdateRepository {
  final DioClient dioClient;

  AutoUpdateRepositoryImpl({required this.dioClient});

  @override
  Future<Either<String, List<FileHashModel>>> getListHashBinaryFile() async {
    try {
      final dioClientLocal = DioClient();
      dioClientLocal.dio.options = BaseOptions(
        baseUrl: 'http://localhost:9008',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
      );
      dioClientLocal.dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          request: true,
          responseBody: true,
          responseHeader: false,
          logPrint: (object) => debugPrint(object.toString()),
        ),
      );
      final response = await dioClientLocal.dio.get(
        '/csAdmin/auto-update/get-list-hash-binary-file',
      );
      final List<dynamic> data = response.data['data'] ?? [];
      final listHash = data
          .map((json) => FileHashModel.fromJson(json))
          .toList();

      return Right(listHash);
    } on DioException catch (e) {
      return Left(DioExceptions.fromDioError(e).toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> downloadBinaryFile({
    required String fileName,
    required String savePath,
    bool isCompressPackage = true,
    Function(int received, int total)? onReceiveProgress,
  }) async {
    try {
      final dioClientLocal = DioClient();
      final response = await dioClientLocal.dio.get(
        'http://localhost:9008/csAdmin/auto-update/get-binary-file',
        // savePath,
        queryParameters: {
          'fileName': fileName,
          'isCompressPackage': isCompressPackage,
        },
        onReceiveProgress: onReceiveProgress,
        options: Options(
          responseType:
              ResponseType.bytes, // Wajib bytes agar tidak terbaca String
          headers: {'Content-Type': 'application/octet-stream'},
        ),
      );
      if (response.statusCode == 200) {
        await processResponseAppFile(
          response,
          savePath: savePath,
          () {
            debugPrint("Selesai mengunduh $fileName");
          },
          (received, total) {
            if (total != -1) {
              debugPrint("Mengunduh $fileName: $received/$total bytes");
            }
          },
        );
      } else {
        return Left('Gagal mengunduh file: ${response.statusCode}');
      }
      return Right(savePath);
    } on DioException catch (e) {
      return Left(DioExceptions.fromDioError(e).toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<void> processResponseAppFile(
    Response<dynamic> response,
    void Function() onFinishDownload,
    void Function(int, int) onWriteProgress, {
    required String savePath,
  }) async {
    final Uint8List buf = response.data;

    if (buf.isEmpty) {
      return;
    }

    // ====================================================
    // MEMULAI ISOLATE
    // ====================================================

    // Siapkan 'penerima pesan' di Main Thread
    final receivePort = ReceivePort();

    // Luncurkan pekerja latar belakang (Isolate)
    await Isolate.spawn(
      processAndWriteFileInIsolate,
      IsolateWriteArgs(
        // Server dummy mengirim payload file secara langsung tanpa byte flag.
        rawData: buf,
        filePath: savePath,
        flagCompress: 0,
        sendPort: receivePort.sendPort,
      ),
    );

    // Dengarkan pesan yang dikirim dari Isolate
    await for (var message in receivePort) {
      if (message is Map) {
        if (message["status"] == "progress") {
          // Update UI Progress Bar
          onWriteProgress(message["write"], message["total"]);
        } else if (message["status"] == "done") {
          // Tutup port komunikasi dan panggil onFinish
          receivePort.close();
          onFinishDownload();
          break; // Keluar dari perulangan await for
        } else if (message["status"] == "error") {
          receivePort.close();
          throw Exception(message["message"]);
        }
      }
    }
  }
}

class EncryptControl {
  int readPos = 0;

  int encrypt1(Uint8List buf) {
    int value = buf[readPos];
    readPos += 1;
    return value;
  }

  int encrypt2(Uint8List buf) {
    int value = (buf[readPos] << 8) | buf[readPos + 1];
    readPos += 2;
    return value;
  }

  int encrypt4(Uint8List buf) {
    int value =
        (buf[readPos] << 24) |
        (buf[readPos + 1] << 16) |
        (buf[readPos + 2] << 8) |
        buf[readPos + 3];
    readPos += 4;
    return value;
  }

  int getLong(Uint8List bb) {
    ByteData data = bb.buffer.asByteData();
    int result = data.getInt64(readPos, Endian.big);
    readPos += 8;
    return result;
  }

  Future<bool> writeBinaryToFile({
    required Uint8List binaryData,
    required String filePath,
    void Function(int write, int total)? onWriteProgress,
  }) async {
    final file = File(filePath);
    await file.parent.create(recursive: true);
    final IOSink sink = file.openWrite(mode: FileMode.writeOnly);

    int fileSize = binaryData.length;
    int nWrites = 0;
    const int constantChunk = 1024;

    try {
      while (fileSize > 0) {
        final chunkSize = fileSize > constantChunk ? constantChunk : fileSize;
        // Perbaikan indexing sublist agar tidak out of range
        final chunk = binaryData.sublist(nWrites, nWrites + chunkSize);

        if (onWriteProgress != null) {
          onWriteProgress(nWrites, binaryData.length);
        }

        sink.add(chunk);
        fileSize -= chunkSize;
        nWrites += chunkSize;
      }
      return true;
    } catch (e) {
      debugPrint('error writing file: $e');
      return false;
    } finally {
      await sink.flush();
      await sink.close();
    }
  }

  int encrypt8(Uint8List buf) {
    int value =
        (buf[readPos] << 56) |
        (buf[readPos + 1] << 48) |
        (buf[readPos + 2] << 40) |
        (buf[readPos + 3] << 32) |
        (buf[readPos + 4] << 24) |
        (buf[readPos + 5] << 16) |
        (buf[readPos + 6] << 8) |
        buf[readPos + 7];
    readPos += 8;
    return value;
  }

  String getAsciiString(Uint8List buf, int len) {
    Uint8List asciiBytes = buf.sublist(readPos, readPos + len);
    String asciiString = String.fromCharCodes(asciiBytes);
    readPos += len;
    return asciiString;
  }

  int getDouble(Uint8List buf) {
    int value = ByteData.sublistView(buf).getInt32(readPos, Endian.big);
    readPos += 4;
    return value;
  }

  double getDoubleTemp(Uint8List buf) {
    Uint8List asciiBytes = buf.sublist(readPos, readPos + 4);
    Float32List restoredFloat32List = Float32List.view(asciiBytes.buffer);
    double restoredValue = restoredFloat32List[0];
    readPos += 4;
    return restoredValue;
  }

  int getDouble8(Uint8List buf) {
    int value = ByteData.sublistView(buf).getInt64(readPos, Endian.big);
    readPos += 8;
    return value;
  }

  static int sendCurrentdatetime() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}

class SnappyDart {
  SnappyDart(_);
  static Uint8List decompress(Object compressed) {
    bool isUint8List = compressed is Uint8List;
    bool isArrayBuffer = compressed is ByteBuffer;
    if (!isUint8List && !isArrayBuffer) {
      throw ArgumentError(SnappyHelper.typeErrorMessage);
    }

    bool uint8Mode = false;
    bool arrayBufferMode = false;

    Uint8List compressedList;

    if (isUint8List) {
      uint8Mode = true;
      compressedList = compressed;
    } else if (isArrayBuffer) {
      arrayBufferMode = true;
      compressedList = Uint8List.view(compressed);
    } else {
      throw ArgumentError(SnappyHelper.typeErrorMessage);
    }

    SnappyDecompressor decompressor = SnappyDecompressor(compressedList);
    int length = decompressor.readUncompressedLength();

    if (length == -1) {
      throw Exception('Invalid Snappy bitstream');
    }

    Uint8List uncompressed;

    if (uint8Mode || arrayBufferMode) {
      uncompressed = Uint8List(length);
      if (!decompressor.uncompressToBuffer(uncompressed)) {
        throw Exception('Invalid Snappy bitstream');
      }
    } else {
      throw Exception('Unsupported type');
    }

    return uncompressed;
  }

  static Uint8List compress(Object uncompressed) {
    bool isUint8List = uncompressed is Uint8List;
    bool isArrayBuffer = uncompressed is ByteBuffer;

    if (!isUint8List && !isArrayBuffer) {
      throw ArgumentError(SnappyHelper.typeErrorMessage);
    }

    Uint8List uncompressedList;

    if (isUint8List) {
      uncompressedList = uncompressed;
    } else if (isArrayBuffer) {
      uncompressedList = Uint8List.view(uncompressed);
    } else {
      throw ArgumentError(SnappyHelper.typeErrorMessage);
    }

    SnappyCompressor compressor = SnappyCompressor(uncompressedList);
    int maxLength = compressor.maxCompressedLength();
    Uint8List compressed = Uint8List(maxLength);
    int length = compressor.compressToBuffer(compressed);

    return compressed.sublist(0, length);
  }
}

class SnappyHelper {
  SnappyHelper(_);

  static const List<int> wordMask = [0, 255, 65535, 16777215, 4294967295];
  static const int blockLog = 16;
  static const int blockSize = 1 << blockLog;
  static const int maxHashTableBits = 14;
  static const String typeErrorMessage =
      'Argument compressed must be type of ByteBuffer or Uint8List';

  static int hashFunc(int key, int hashFuncShift) {
    return (key * 1994589493) >>> hashFuncShift;
  }

  static int load32(Uint8List array, int pos) {
    return array[pos] +
        (array[pos + 1] << 8) +
        (array[pos + 2] << 16) +
        (array[pos + 3] << 24);
  }

  static bool equals32(Uint8List array, int pos1, int pos2) {
    return array[pos1] == array[pos2] &&
        array[pos1 + 1] == array[pos2 + 1] &&
        array[pos1 + 2] == array[pos2 + 2] &&
        array[pos1 + 3] == array[pos2 + 3];
  }

  static void copyBytes(
    Uint8List fromArray,
    int fromPos,
    Uint8List toArray,
    int toPos,
    int length,
  ) {
    for (int i = 0; i < length; i++) {
      toArray[toPos + i] = fromArray[fromPos + i];
    }
  }

  static void selfCopyBytes(Uint8List array, int pos, int offset, int length) {
    for (int i = 0; i < length; i++) {
      array[pos + i] = array[pos - offset + i];
    }
  }

  static int putVarint(int value, Uint8List output, int op) {
    do {
      output[op] = value & 127;
      value = value >>> 7;
      if (value > 0) {
        output[op] += 128;
      }
      op += 1;
    } while (value > 0);
    return op;
  }

  static int emitLiteral(
    Uint8List input,
    int ip,
    int len,
    Uint8List output,
    int op,
  ) {
    if (len <= 60) {
      output[op] = (len - 1) << 2;
      op += 1;
    } else if (len < 256) {
      output[op] = 240;
      output[op + 1] = len - 1;
      op += 2;
    } else {
      output[op] = 244;
      output[op + 1] = (len - 1) & 255;
      output[op + 2] = (len - 1) >>> 8;
      op += 3;
    }
    copyBytes(input, ip, output, op, len);
    return op + len;
  }

  static int emitCopyLessThan64(Uint8List output, int op, int offset, int len) {
    if (len < 12 && offset < 2048) {
      output[op] = 1 + ((len - 4) << 2) + ((offset >>> 8) << 5);
      output[op + 1] = offset & 255;
      return op + 2;
    } else {
      output[op] = 2 + ((len - 1) << 2);
      output[op + 1] = offset & 255;
      output[op + 2] = offset >>> 8;
      return op + 3;
    }
  }

  static int emitCopy(Uint8List output, int op, int offset, int len) {
    while (len >= 68) {
      op = emitCopyLessThan64(output, op, offset, 64);
      len -= 64;
    }
    if (len > 64) {
      op = emitCopyLessThan64(output, op, offset, 60);
      len -= 60;
    }
    return emitCopyLessThan64(output, op, offset, len);
  }

  static int compressFragment(
    Uint8List input,
    int ip,
    int inputSize,
    Uint8List output,
    int op,
  ) {
    int hashTableBits = 1;
    while ((1 << hashTableBits) <= inputSize &&
        hashTableBits <= maxHashTableBits) {
      hashTableBits += 1;
    }
    hashTableBits -= 1;
    int hashFuncShift = 32 - hashTableBits;
    Uint16List hashTable = Uint16List(1 << hashTableBits);
    for (int i = 0; i < hashTable.length; i++) {
      hashTable[i] = 0;
    }
    int baseIp = ip;
    int ipEnd = ip + inputSize;
    int ipLimit = ipEnd - 15;
    int nextEmit = ip;
    int nextHash = hashFunc(load32(input, ++ip), hashFuncShift);
    while (ip < ipLimit) {
      int skip = 32;
      int nextIp = ip;
      int candidate = 0;
      do {
        ip = nextIp;
        int hash = nextHash;
        int bytesBetweenHashLookups = skip >>> 5;
        skip += 1;
        nextIp = ip + bytesBetweenHashLookups;
        if (ip > ipLimit) break;
        nextHash = hashFunc(load32(input, nextIp), hashFuncShift);
        candidate = hashTable[hash] + baseIp;
        hashTable[hash] = ip - baseIp;
      } while (!equals32(input, ip, candidate));
      if (ip > ipLimit) break;
      op = emitLiteral(input, nextEmit, ip - nextEmit, output, op);
      while (true) {
        int base = ip;
        int matched = 4;
        while (ip + matched < ipEnd &&
            input[ip + matched] == input[candidate + matched]) {
          matched += 1;
        }
        ip += matched;
        int offset = base - candidate;
        op = emitCopy(output, op, offset, matched);
        nextEmit = ip;
        if (ip >= ipLimit) break;
        int prevHash = hashFunc(load32(input, ip - 1), hashFuncShift);
        hashTable[prevHash] = ip - 1 - baseIp;
        int curHash = hashFunc(load32(input, ip), hashFuncShift);
        candidate = hashTable[curHash] + baseIp;
        hashTable[curHash] = ip - baseIp;
        if (!equals32(input, ip, candidate)) break;
        ip += 1;
        nextHash = hashFunc(load32(input, ip), hashFuncShift);
      }
    }
    if (nextEmit < ipEnd) {
      op = emitLiteral(input, nextEmit, ipEnd - nextEmit, output, op);
    }
    return op;
  }
}

class SnappyDecompressor {
  final Uint8List array;
  int pos = 0;

  SnappyDecompressor(this.array);

  int readUncompressedLength() {
    int result = 0;
    int shift = 0;
    while (shift < 32 && pos < array.length) {
      int c = array[pos++];
      int val = c & 127;
      if ((val << shift) >> shift != val) {
        return -1;
      }
      result |= val << shift;
      if (c < 128) {
        return result;
      }
      shift += 7;
    }
    return -1;
  }

  bool uncompressToBuffer(Uint8List outBuffer) {
    int arrayLength = array.length;
    int outPos = 0;

    while (pos < array.length) {
      int c = array[pos++];
      if ((c & 3) == 0) {
        int len = (c >> 2) + 1;
        if (len > 60) {
          if (pos + 3 >= arrayLength) return false;
          int smallLen = len - 60;
          len =
              array[pos] +
              (array[pos + 1] << 8) +
              (array[pos + 2] << 16) +
              (array[pos + 3] << 24);
          len = (len & SnappyHelper.wordMask[smallLen]) + 1;
          pos += smallLen;
        }
        if (pos + len > arrayLength) return false;
        SnappyHelper.copyBytes(array, pos, outBuffer, outPos, len);
        pos += len;
        outPos += len;
      } else {
        int len, offset;
        switch (c & 3) {
          case 1:
            len = ((c >> 2) & 7) + 4;
            offset = array[pos] + ((c >> 5) << 8);
            pos += 1;
            break;
          case 2:
            if (pos + 1 >= arrayLength) return false;
            len = (c >> 2) + 1;
            offset = array[pos] + (array[pos + 1] << 8);
            pos += 2;
            break;
          case 3:
            if (pos + 3 >= arrayLength) return false;
            len = (c >> 2) + 1;
            offset =
                array[pos] +
                (array[pos + 1] << 8) +
                (array[pos + 2] << 16) +
                (array[pos + 3] << 24);
            pos += 4;
            break;
          default:
            return false;
        }
        if (offset == 0 || offset > outPos) return false;
        SnappyHelper.selfCopyBytes(outBuffer, outPos, offset, len);
        outPos += len;
      }
    }
    return true;
  }
}

class SnappyCompressor {
  final Uint8List array;

  SnappyCompressor(this.array);

  int maxCompressedLength() {
    int sourceLen = array.length;
    return 32 + sourceLen + (sourceLen ~/ 6);
  }

  int compressToBuffer(Uint8List outBuffer) {
    int length = array.length;
    int pos = 0;
    int outPos = 0;

    outPos = SnappyHelper.putVarint(length, outBuffer, outPos);
    while (pos < length) {
      int fragmentSize = (length - pos).clamp(0, SnappyHelper.blockSize);
      outPos = SnappyHelper.compressFragment(
        array,
        pos,
        fragmentSize,
        outBuffer,
        outPos,
      );
      pos += fragmentSize;
    }
    return outPos;
  }
}

import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
// Pastikan import SnappyDart-nya disesuaikan dengan file kamu
import 'package:el_csadmin/features/auto_update/data/repositories/auto_update_repository_impl.dart';
// 1. Buat class untuk membungkus data yang akan dikirim ke Isolate
class IsolateWriteArgs {
  final Uint8List rawData;
  final String filePath;
  final int flagCompress;
  final SendPort sendPort;

  IsolateWriteArgs({
    required this.rawData,
    required this.filePath,
    required this.flagCompress,
    required this.sendPort,
  });
}

// 2. Fungsi Background (Harus top-level / di luar class)
void processAndWriteFileInIsolate(IsolateWriteArgs args) async {
  try {
    // Lakukan Dekompresi di Background (Anti-Lag UI)
    Uint8List resEnd = args.flagCompress == 1
        ? SnappyDart.decompress(args.rawData)
        : args.rawData;

    // Persiapkan File
    final file = File(args.filePath);
    await file.parent.create(recursive: true);
    final IOSink sink = file.openWrite(mode: FileMode.writeOnly);

    int fileSize = resEnd.length;
    int nWrites = 0;
    const int constantChunk = 65536; // 64 KB

    // Tulis ke disk
    while (fileSize > 0) {
      final chunkSize = fileSize > constantChunk ? constantChunk : fileSize;
      final chunk = resEnd.sublist(nWrites, nWrites + chunkSize);

      sink.add(chunk);
      fileSize -= chunkSize;
      nWrites += chunkSize;

      // Kirim pesan progress ke Main Thread!
      args.sendPort.send({
        "status": "progress",
        "write": nWrites,
        "total": resEnd.length
      });
    }

    await sink.flush();
    await sink.close();

    // Beri tahu Main Thread kalau sudah selesai
    args.sendPort.send({"status": "done"});
    
  } catch (e) {
    // Beri tahu jika error
    args.sendPort.send({"status": "error", "message": e.toString()});
  }
}
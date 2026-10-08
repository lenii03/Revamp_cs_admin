import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:el_csadmin/core/constants/api_config.dart';
import 'package:el_csadmin/core/constants/endpoint.dart';
import 'package:el_csadmin/data/remote/dio_client.dart';
import 'package:el_csadmin/data/remote/dio_exception.dart';
import 'package:el_csadmin/features/auto_update/data/models/file_hash_model.dart';
import 'package:el_csadmin/features/auto_update/data/repositories/isolatewrite_args.dart';
import 'package:el_csadmin/features/auto_update/domain/repositories/auto_update_repository.dart';
import 'package:flutter/foundation.dart';

class AutoUpdateRepositoryImpl implements AutoUpdateRepository {
  const AutoUpdateRepositoryImpl();

  @override
  Future<Either<String, List<FileHashModel>>> getListHashBinaryFile() async {
    try {
      final client = DioClient.local(
        baseUrl: ApiConfig.autoUpdateBaseUrl,
        responseType: ResponseType.json,
      );
      final response = await client.get(Endpoint.getAppFileHash);
      final List<dynamic> data = response.data['data'] ?? [];
      final listHash = data
          .map((json) => FileHashModel.fromJson(json))
          .toList();

      return Right(listHash);
    } on DioExceptions catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> downloadBinaryFile({
    required String fileName,
    required String savePath,
    Function(int received, int total)? onReceiveProgress,
  }) async {
    try {
      final client = DioClient.local(baseUrl: ApiConfig.autoUpdateBaseUrl);
      final response = await client.get(
        Endpoint.getAppFile,
        queryParameters: {
          'fileName': fileName,
        },
        onReceiveProgress: onReceiveProgress,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Content-Type': 'application/octet-stream'},
        ),
      );
      if (response.statusCode == 200) {
        await processResponseAppFile(
          response,
          savePath: savePath,
          () {
            debugPrint("Finished downloading $fileName");
          },
          (received, total) {
            if (total != -1) {
              debugPrint("Downloading $fileName: $received/$total bytes");
            }
          },
        );
      } else {
        return Left('Failed to download file: ${response.statusCode}');
      }
      return Right(savePath);
    } on DioExceptions catch (e) {
      return Left(e.message);
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

    final receivePort = ReceivePort();

    await Isolate.spawn(
      processAndWriteFileInIsolate,
      IsolateWriteArgs(
        rawData: buf,
        filePath: savePath,
        sendPort: receivePort.sendPort,
      ),
    );
    await for (var message in receivePort) {
      if (message is Map) {
        if (message["status"] == "progress") {
          onWriteProgress(message["write"], message["total"]);
        } else if (message["status"] == "done") {
          receivePort.close();
          onFinishDownload();
          break;
        } else if (message["status"] == "error") {
          receivePort.close();
          throw Exception(message["message"]);
        }
      }
    }
  }
}

import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:el_csadmin/features/auto_update/data/repositories/auto_update_repository_impl.dart';
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


void processAndWriteFileInIsolate(IsolateWriteArgs args) async {
  try {
    Uint8List resEnd = args.flagCompress == 1
        ? SnappyDart.decompress(args.rawData)
        : args.rawData;

    final file = File(args.filePath);
    await file.parent.create(recursive: true);
    final IOSink sink = file.openWrite(mode: FileMode.writeOnly);

    int fileSize = resEnd.length;
    int nWrites = 0;
    const int constantChunk = 65536; 

    while (fileSize > 0) {
      final chunkSize = fileSize > constantChunk ? constantChunk : fileSize;
      final chunk = resEnd.sublist(nWrites, nWrites + chunkSize);

      sink.add(chunk);
      fileSize -= chunkSize;
      nWrites += chunkSize;
      args.sendPort.send({
        "status": "progress",
        "write": nWrites,
        "total": resEnd.length
      });
    }

    await sink.flush();
    await sink.close();
    args.sendPort.send({"status": "done"});
    
  } catch (e) {
    args.sendPort.send({"status": "error", "message": e.toString()});
  }
}
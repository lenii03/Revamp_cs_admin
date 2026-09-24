import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

class IsolateWriteArgs {
  final Uint8List rawData;
  final String filePath;
  final SendPort sendPort;

  IsolateWriteArgs({
    required this.rawData,
    required this.filePath,
    required this.sendPort,
  });
}

void processAndWriteFileInIsolate(IsolateWriteArgs args) async {
  try {
    final file = File(args.filePath);
    await file.parent.create(recursive: true);
    final IOSink sink = file.openWrite(mode: FileMode.writeOnly);

    int fileSize = args.rawData.length;
    int nWrites = 0;
    const int constantChunk = 65536;

    while (fileSize > 0) {
      final chunkSize = fileSize > constantChunk ? constantChunk : fileSize;
      final chunk = args.rawData.sublist(nWrites, nWrites + chunkSize);

      sink.add(chunk);
      fileSize -= chunkSize;
      nWrites += chunkSize;
      args.sendPort.send({
        "status": "progress",
        "write": nWrites,
        "total": args.rawData.length,
      });
    }

    await sink.flush();
    await sink.close();
    args.sendPort.send({"status": "done"});
  } catch (e) {
    args.sendPort.send({"status": "error", "message": e.toString()});
  }
}

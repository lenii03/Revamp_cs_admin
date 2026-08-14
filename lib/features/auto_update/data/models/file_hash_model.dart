class FileHashModel {
  final String fileName;
  final String fileHash;

  FileHashModel({
    required this.fileName,
    required this.fileHash,
  });

  factory FileHashModel.fromJson(Map<String, dynamic> json) {
    return FileHashModel(
      fileName: json['fileName'] ?? '',
      fileHash: json['fileHash'] ?? '',
    );
  }
}
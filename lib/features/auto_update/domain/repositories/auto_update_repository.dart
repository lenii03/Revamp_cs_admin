import 'package:dartz/dartz.dart';
import 'package:el_csadmin/features/auto_update/data/models/file_hash_model.dart';

abstract class AutoUpdateRepository {
  Future<Either<String, List<FileHashModel>>> getListHashBinaryFile();
  Future<Either<String, String>> downloadBinaryFile({
    required String fileName,
    required String savePath,
    bool isCompressPackage = true,
    Function(int received, int total)? onReceiveProgress,
  });
}
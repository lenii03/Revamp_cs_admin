import 'package:el_csadmin/features/auto_update/data/models/file_hash_model.dart';

abstract class AutoUpdateState {}

class AutoUpdateInitial extends AutoUpdateState {}

class AutoUpdateLoading extends AutoUpdateState {
  final String message;
  AutoUpdateLoading(this.message);
}

class AutoUpdateAvailable extends AutoUpdateState {
  final List<FileHashModel> filesToUpdate;
  final List<FileHashModel> filesToDownload;
  AutoUpdateAvailable(this.filesToUpdate, this.filesToDownload);
}

class AutoUpdateUpToDate extends AutoUpdateState {}

class AutoUpdateReadyToInstall extends AutoUpdateState {}

class AutoUpdateDownloading extends AutoUpdateState {
  final int currentFileIndex;
  final int totalFiles;
  final double progress;
  AutoUpdateDownloading(this.currentFileIndex, this.totalFiles, this.progress);
}

class AutoUpdateSuccess extends AutoUpdateState {}

class AutoUpdateFailure extends AutoUpdateState {
  final String message;
  AutoUpdateFailure(this.message);
}

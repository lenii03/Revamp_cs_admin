import 'package:el_csadmin/features/auto_update/data/models/file_hash_model.dart';

abstract class AutoUpdateEvent {}

class CheckForUpdateStarted extends AutoUpdateEvent {}

class DownloadUpdateStarted extends AutoUpdateEvent {
  final List<FileHashModel> filesToUpdate;
  DownloadUpdateStarted({required this.filesToUpdate});
}

class InstallUpdateStarted extends AutoUpdateEvent {}

class AutoUpdateUpdateProgress extends AutoUpdateEvent {
  final int currentFileIndex;
  final int totalFiles;
  final double progress;

  AutoUpdateUpdateProgress(
    this.currentFileIndex,
    this.totalFiles,
    this.progress,
  );
}

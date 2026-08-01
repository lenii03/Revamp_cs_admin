class NotificationModel {
  final int scheduleId;
  final String title;
  final String subtitle;
  final String executeTime;
  final String executedTime;
  final String expiry;
  final bool isExpired;
  final String createdBy;
  final String topic;

  NotificationModel({
    required this.scheduleId,
    required this.title,
    required this.subtitle,
    required this.executeTime,
    required this.executedTime,
    required this.expiry,
    required this.isExpired,
    required this.createdBy,
    required this.topic,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      scheduleId: json['ScheduleId'] ?? 0,
      title: json['Title']?.toString() ?? '-',
      subtitle: json['Subtitle']?.toString() ?? '-',
      executeTime: json['ExecuteTime']?.toString() ?? '-',
      executedTime: json['ExecutedTime']?.toString() ?? '-',
      expiry: json['Expiry']?.toString() ?? '-',
      isExpired: json['IsExpired'] ?? false,
      createdBy: json['CreatedBy']?.toString() ?? '-',
      topic: json['Topic']?.toString() ?? '-',
    );
  }
}
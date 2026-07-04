class LinkAccountInfoModel {
  final String accountId;
  final String accountName;
  final String createdDate;
  final String createdBy;

  LinkAccountInfoModel({
    required this.accountId,
    required this.accountName,
    required this.createdDate,
    required this.createdBy,
  });

  factory LinkAccountInfoModel.fromMap(Map<String, dynamic> map) {
    return LinkAccountInfoModel(
      accountId: map['AccountId']?.toString() ?? '-',
      accountName: map['AccountName']?.toString() ?? '-',
      createdDate: map['Created']?.toString() ?? '-',
      createdBy: map['CreatedBy']?.toString() ?? '-',
    );
  }
}

class NewLinkAccountInfoModel {
  final String actionType;
  final String accountId;
  final String accountName;
  final String createdDate;

  NewLinkAccountInfoModel({
    required this.actionType,
    required this.accountId,
    required this.accountName,
    required this.createdDate,
  });

  factory NewLinkAccountInfoModel.fromMap(Map<String, dynamic> map) {
    String getActionName(String type) {
      if (type == '1') return 'New Link';
      if (type == '2') return 'Unlink';
      return type;
    }

    return NewLinkAccountInfoModel(
      actionType: getActionName(map['ActionType']?.toString() ?? '-'),
      accountId: map['AccountId']?.toString() ?? '-',
      accountName: map['AccountName']?.toString() ?? '-',
      createdDate: map['Created']?.toString() ?? '-',
    );
  }
}

class AccountLinkModel {
  const AccountLinkModel({
    required this.custId,
    required this.name,
    required this.staffId,
    required this.branch,
  });

  final String custId;
  final String name;
  final String staffId;
  final String branch;

  factory AccountLinkModel.fromMap(Map<String, dynamic> map) {
    return AccountLinkModel(
      custId:
          map['CustId']?.toString() ?? map['AccountId']?.toString() ?? '',
      name: map['Name']?.toString() ?? map['AccountName']?.toString() ?? '',
      staffId: map['StaffId']?.toString() ?? '',
      branch: map['Branch']?.toString() ?? '',
    );
  }
}

class ApproveOpeningAccountModel {
  final String loginId;
  final String custId;
  final String investorNo;
  final String kseiId;
  final String name;
  final String rdnAccount;
  final String rdnBank;
  final String email;

  ApproveOpeningAccountModel({
    required this.loginId,
    required this.custId,
    required this.investorNo,
    required this.kseiId,
    required this.name,
    required this.rdnAccount,
    required this.rdnBank,
    required this.email,
  });

  factory ApproveOpeningAccountModel.fromMap(Map<String, dynamic> map) {
    return ApproveOpeningAccountModel(
      loginId: map['LoginId']?.toString() ?? '-',
      custId: map['CustId']?.toString() ?? '-',
      investorNo: map['InvestorNo']?.toString() ?? '-',
      kseiId: map['KSEIID']?.toString() ?? '-',
      name: map['Name']?.toString() ?? '-',
      rdnAccount: map['RDNAccount']?.toString() ?? '-',
      rdnBank: map['RDNBank']?.toString() ?? '-',
      email: map['Email']?.toString() ?? '-',
    );
  }
}

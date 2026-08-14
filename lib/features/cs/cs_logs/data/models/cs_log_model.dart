class CsLogModel {
  final String csLoginId;
  final String onlineLoginId;
  final String logTime;
  final String approvalId;
  final String logType;
  final String descriptions;

  CsLogModel({
    required this.csLoginId,
    required this.onlineLoginId,
    required this.logTime,
    required this.approvalId,
    required this.logType,
    required this.descriptions,
  });

  static const Map<String, String> logTypeDesc = {
    '0': 'CS Login Failed',
    '1': 'CS Succeeded Login',
    '2': 'CS Logout',
    '3': 'Create New CS Id',
    '4': 'Edit CS Id',
    '5': 'Delete CS Id',
    '6': 'Create New Online Id',
    '7': 'Edit Online Id',
    '8': 'Delete Online Id',
    '9': 'Approve Online Id',
    '10': 'Reject Online Id',
    '11': 'Reset PIN',
    '12': 'Reset Password',
    '13': 'Reset PIN and Password',
    '14': 'Sent Opening Account Approval Email',
    '15': 'Link Account',
    '16': 'Approve Link Account',
    '17': 'Send Online User Disclaimer',
    '18': 'Send Email Customer Ratio',
    '19': 'Approve Unlink Account',
    '20': 'Unlink Account',
    '21': 'Send Email Opening Account',
    '22': 'Send Email Forget PIN and Password',
  };

  factory CsLogModel.fromMap(Map<String, dynamic> map) {
    final lowerCaseMap = map.map(
      (key, value) => MapEntry(key.toLowerCase(), value),
    );

    String logTypeVal = (lowerCaseMap['logtype'])?.toString() ?? '-';
    String descVal =
        (lowerCaseMap['descriptions'] ?? lowerCaseMap['description'])
            ?.toString() ??
        '';
    if (descVal.isEmpty || descVal == '-' || descVal == 'null') {
      descVal = logTypeDesc[logTypeVal] ?? '-';
    }

    return CsLogModel(
      csLoginId: (lowerCaseMap['csloginid'])?.toString() ?? '-',
      onlineLoginId:
          (lowerCaseMap['onlineloginid'] ??
                  lowerCaseMap['loginid'] ??
                  lowerCaseMap['targetid'])
              ?.toString() ??
          '-',
      logTime: (lowerCaseMap['logtime'])?.toString() ?? '-',
      approvalId: (lowerCaseMap['approvalid'])?.toString() ?? '-',
      logType: logTypeVal,
      descriptions: descVal,
    );
  }
}

class Endpoint {
  Endpoint._();

  static const String resetPasswordCs = "cs/reset-password";
  static const String getAppFileHash = "auto-update/get-list-hash-binary-file";
  static const String getAppFile = "auto-update/get-binary-file";
  static const String signIn = "cs/login";
  static const String signOut = "cs/logout";
  // static const String getEmployee = "cs/get-sales"; //Get salees
  static const String getCsLogs = "cs/get-customer-service-logs";
  static const String getCsLogsSuggestion =
      "cs/get-customer-service-logs-suggestion";
  static const String getCSList = "cs/get-list-customer-service";
  static const String getCSListSuggestion =
      "cs/get-list-customer-service-suggestion";
  static const String postAddCs = "cs/create-customer-service-account";
  static const String putEditCs = "cs/update-customer-service-account";
  static const String putResetPw =
      "cs/change-password-customer-service-account";
  static const String deleteCs = "cs/delete-customer-service-account";
  static const String pushNotification = "cs/push-notification";
  static const String createSchedulerNotification =
      "cs/create-scheduler-notification";
  static const String getListScheulerNotification =
      "cs/get-list-scheduler-notification";
  static const String postEditScheulerNotification =
      "cs/update-scheduler-notification";
  static const String putDeleteScheulerNotification =
      "cs/delete-scheduler-notification";

  //Online
  static const String getOnlineUser = "online/get-list-online-user";
  static const String getOnlineUserSuggest =
      "online/get-list-online-user-suggestion";
  static const String postAddOnUser = "online/create-approval-login";
  static const String getApprovalList = "online/get-list-approval-online-user";
  static const String getApprovalListSuggestion =
      "online/get-list-approval-online-user-suggestion";
  static const String updateStatusApprovalUser =
      "/online/approve-approval-login";
  static const String getLinkedInfoAccount =
      "/online/get-linked-account-online-user";
  static const String getLinkedInfoAccountApproval =
      "/online/get-approval-linked-account-online-user";
  static const String getListOpeningAccount =
      "online/get-list-opening-rekening-online-user";
  static const String getListOpeningAccountSuggestion =
      "online/get-list-opening-rekening-online-user-suggestion";
  static const String sendEmail = "ONLINE/sendEmail";
  static const String sendEmailOpeningAccountWithRekening =
      "online/send-email-opening-account-with-rekening";
  static const String resetPWDOrPIN =
      "online/change-password-and-pin-online-user";
  static const String resetPW = "online/change-password-and-pin-online-user";
  static const String resetPIN = "ONLINE/resetPIN";
  static const String resetPWnPIN =
      "online/change-password-and-pin-online-user";
  static const String updateStatusUser = "online/update-status-online-user";
  static const String sendEmailPINAndPasswordOnlineUser =
      "online/send-email-forget-password-and-pin-online-user";
  static const String sendEmailOpeningAccount =
      "online/send-email-opening-account";
  static const String registerAccountOnlineUser =
      'online/register-account-online-user';

  //Account Link
  static const String getAccountLink = 'online/get-list-link-account';
}

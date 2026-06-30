class AppString {
  AppString._();

  //Api call error
  static const cancelRequest = "Request to API server was cancelled";
  static const connectionTimeOut = "Connection timeout with API server";
  static const receiveTimeOut = "Receive timeout in connection with API server";
  static const sendTimeOut = "Send timeout in connection with API server";
  static const socketException = "Check your internet connection";
  static const unexpectedError = "Unexpected error occurred";
  static const unknownError = "Something went wrong";
  static const duplicateEmail = "Email has already been taken";
  static const connectionError = "The server refused the network connection";

  //status code
  static const badRequest = "Error 400 : Bad request";
  static const unauthorized = "Error 401 : Unauthorized";
  static const forbidden = "Error 403 : Forbidden";
  static const notFound = "Error 404 : Address not found";
  static const conflict = "Error 404 : Conflict";
  static const internalServerError = "Error 500 : Internal server error";
  static const badGateway = "Error 502 : Bad gateway";


  //Pagenation Message Error
  static const pagenationNoData = "No data available";
}

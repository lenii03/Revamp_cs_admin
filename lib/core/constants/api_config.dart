class ApiConfig{
  ApiConfig._();

  static String defaultBaseUrl = "192.168.10.10:8080"; //default
  static String localBaseUrl = "192.168.10.10:8080"; //local
  static const Duration receiveTimeout = Duration(milliseconds: 15000);
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  static Map<String,String> mapIP(String baseUrl){
    List<String> ip  = baseUrl.split(':').map((part) => part.trim()).toList();
    Map<String,String> result= {};
    if(ip.length ==2){
      result["HOST"] = ip[0];
      result["PORT"] = ip[1];
    }
    return result;
  }
}
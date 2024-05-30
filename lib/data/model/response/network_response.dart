class NetworkResponse {
  String errorText;
  String errorCode;
  dynamic data;
  String token;

  NetworkResponse({
    this.errorText = "",
    this.errorCode = "",
    this.data,
    this.token='',
  });
}

class HttpStatus {
  static const success = 200;
  static const created = 201;
  static const serverError = 500;
  static const notFound = 404;
  static const badRequest = 400;
  static const accessDenied = 401;
  static const forbidden = 403;
}

class HttpResponse<T> {
  int statusCode;
  bool isSuccess;
  String? message;
  List<String>? errorList;
  T? data;

  HttpResponse({
    this.statusCode = HttpStatus.serverError,
    this.isSuccess = false,
    this.message = "",
    this.errorList,
    this.data,
  });
}
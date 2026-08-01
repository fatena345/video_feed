import 'dart:developer';

class AppException implements Exception {
  final String message;
  final String? lang;

  AppException(this.message, [this.lang]) {
    log("AppException: $message");
  }

  @override
  String toString() => 'AppException: $message';
}

class UnKnownException extends AppException {
  UnKnownException(String message) : super('Unknown error: $message');
}

class ApiException extends AppException {
  ApiException(super.message, [super.lang]);

  @override
  String toString() => message;
}

class BadRequestException extends ApiException {
  BadRequestException(super.message, super.lang);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message, super.lang);
}

class ForbiddenException extends ApiException {
  ForbiddenException(super.message, super.lang);
}

class NotFoundException extends ApiException {
  NotFoundException(super.message, super.lang);
}

class GeneralException extends ApiException {
  GeneralException(super.message, super.lang);
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException(super.message, super.lang);
}

class NoInternetConnectionException extends ApiException {
  NoInternetConnectionException({required String lang})
      : super((lang == "ar" ? "خطأ: في الأتصال في الانترنت" : "Error: No internet connection"), lang);
}
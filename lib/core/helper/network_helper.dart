import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import '../exceptions/app_exception.dart';
import '../utils/network_utils.dart';

@lazySingleton
class NetworkHelper {
  late final Dio _dio;

  NetworkHelper() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.pexels.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final String apiKey = dotenv.get('PEXELS_API_KEY', fallback: '');
        if (apiKey.isNotEmpty) {
          options.headers['Authorization'] = apiKey;
        }
        if (kDebugMode) {
          log("Dio Request URL: [${options.method}] ${options.uri}");
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          log("Dio Response Code: [${response.statusCode}]");
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if (kDebugMode) {
          log("Dio Error Occurred: ${e.message}");
        }
        return handler.next(e);
      },
    ));
  }

  Future<Either<ApiException, Response<Map<String, dynamic>>>> get(
    String url, {
    Map<String, dynamic>? queryParams,
  }) async {
    if (await NetworkUtils.checkInternet()) {
      try {
        final response = await _dio.get<Map<String, dynamic>>(
          url,
          queryParameters: queryParams,
        );
        return Right(response);
      } on DioException catch (e) {
        final responseData = e.response?.data;
        return Left(_handleError(e.response?.statusCode, responseData?['message']));
      } catch (e) {
        return Left(ApiException('Unexpected error: ${e.toString()}', 'en'));
      }
    } else {
      return Left(NoInternetConnectionException(lang: 'en'));
    }
  }

  ApiException _handleError(int? statusCode, String? message) {
    switch (statusCode) {
      case 400:
        return BadRequestException(message ?? 'Bad request', 'en');
      case 401:
        return UnauthorizedException(message ?? 'Unauthorized API Key. Verify your .env file', 'en');
      case 403:
        return ForbiddenException(message ?? 'Access forbidden', 'en');
      case 404:
        return NotFoundException(message ?? 'Resource not found', 'en');
      case 500:
        return InternalServerErrorException(message ?? 'Internal server error', 'en');
      default:
        return ApiException(message ?? 'Network connection error', 'en');
    }
  }
}
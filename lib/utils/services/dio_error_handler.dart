import 'package:dio/dio.dart';

String dioErrorHandler(Response response) {
  final statusCode = response.statusCode;
  final reasonPhrase = response.statusMessage;

  final errorMessage = 'Request failed\n Status Code: $statusCode\n Reason: $reasonPhrase';
  return errorMessage;
}
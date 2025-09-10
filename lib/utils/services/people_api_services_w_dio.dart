import 'dart:async';
import 'dart:developer' as developer;

import 'package:people_app/utils/services/dio_error_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import '../../constants/constants.dart';
import '../../data/models/json_response.dart';
import '../../data/models/custom_error.dart';

class PeopleApiServicesWDio {
  const PeopleApiServicesWDio({required this.dio});

  final Dio dio;

  Future<JsonResponse> getPeople() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/api/users',
    );

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['x-api-key'] = '${dotenv.env['APIKEY']}';

    try {
      const timeoutDuration = Duration(seconds: 10);
      developer.log("[PeopleApiServices] Requesting URI: $uri");
      final response = await dio
          .get(uri.toString())
          .timeout(timeoutDuration);
      developer.log(response.statusCode as String);
      developer.log(response.data);
      if (response.statusCode == 200) {
        // final peopleJson = json.decode(response.data);
        // final jsonResponse = JsonResponse.fromJson(peopleJson);
        final JsonResponse jsonResponse = JsonResponse.fromJson(response.data as Map<String, dynamic>);
        return jsonResponse;
      } else {
        throw dioErrorHandler(response);
      }
    } on TimeoutException catch (_) {
      developer.log('The request to $uri timed out.');
      throw CustomError(errorMessage: 'The request timed out. Please check your connection and try again.');
    } catch (e) {
      developer.log('An error occurred in PeopleApiServicesWDio: $e');
      rethrow;
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:people_app/utils/services/http_error_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../constants/constants.dart';
import '../../data/models/json_response.dart';
import '../../data/models/custom_error.dart';

class PeopleApiServices {
  const PeopleApiServices({required this.httpClient});

  final http.Client httpClient;

  Future<JsonResponse> getPeople() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/api/users',
    );

    http.Request request = http.Request('GET', uri);

    request.headers.addAll({
      'Content-Type': 'application/json',
      'x-api-key': '${dotenv.env['APIKEY']}',
    });

    print(request.headers);

    try {
      const timeoutDuration = Duration(seconds: 10);
      print("[PeopleApiServices] Requesting URI: $uri");
      final http.Response response = await httpClient
          .get(uri, headers: request.headers)
          .timeout(timeoutDuration);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final peopleJson = json.decode(response.body);
        final jsonResponse = JsonResponse.fromJson(peopleJson);
        return jsonResponse;
      } else {
        throw httpErrorHandler(response);
      }
    } on TimeoutException catch (_) {
      print('The request to $uri timed out.');
      throw CustomError(errorMessage: 'The request timed out. Please check your connection and try again.');
    } catch (e) {
      print('An error occurred in PeopleApiServices: $e');
      rethrow;
    }
  }
}

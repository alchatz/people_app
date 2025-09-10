import 'package:people_app/data/models/json_response.dart';
import 'package:people_app/utils/services/people_api_services_w_dio.dart';

import '../models/custom_error.dart';

class PeopleRepository {
  const PeopleRepository({required this.peopleApiServices});

  //final PeopleApiServices peopleApiServices;
  final PeopleApiServicesWDio peopleApiServices;

  Future<JsonResponse> fetchPeople() async {
    try {
      final JsonResponse jsonResponse = await peopleApiServices.getPeople();
      print('response: $jsonResponse');

      return jsonResponse;
    } catch (e) {
      print('Error in PeopleRepository: $e');
      throw CustomError(errorMessage: e.toString());
    }
  }
}
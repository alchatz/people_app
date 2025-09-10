import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/custom_error.dart';
import '../../domain/entities/people_entity.dart';
import '../../data/repositories/people_repository.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit({required this.peopleRepository}) : super(PeopleState.initial());

  final PeopleRepository peopleRepository;

  Future<void> fetchPeople() async {
    emit(state.copyWith(status: PeopleStatus.loading));
    try {
      developer.log("Cubit: Calling API service getPeople");
      final people = await peopleRepository.fetchPeople();
      developer.log("Cubit: API call successful, emitting loaded state");
      emit(state.copyWith(status: PeopleStatus.loaded, people: people.data));
    } on CustomError catch (e) {
      emit(state.copyWith(status: PeopleStatus.error, customError: e));
    } catch (e, stackTrace) {
      developer.log("Cubit: API call failed, emitting error state: $e");
      developer.log(stackTrace as String);
      emit(state.copyWith(status: PeopleStatus.error, customError: CustomError(errorMessage: e.toString())));
    }
  }
}
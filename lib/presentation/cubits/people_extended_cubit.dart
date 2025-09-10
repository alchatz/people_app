
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/people_repository.dart';
import '../../domain/entities/person_entity.dart';

part 'people_extended_state.dart';

// Cubit for managing the state of the people list
class PeopleExtendedCubit extends Cubit<PeopleExtendedState> {
  final PeopleRepository personRepository;
  List<Person> masterPeopleList = [];

  PeopleExtendedCubit({required this.personRepository}) : super(PeopleInitial());

  // Fetches the list of people
  Future<void> fetchPeople() async {
    try {
      emit(PeopleLoading());
      final people = await personRepository.fetchPeople();
      masterPeopleList = people.data.people;
      emit(PeopleLoaded(people.data.people));
    } catch (e) {
      emit(PeopleError('Failed to fetch people: ${e.toString()}'));
    }
  }

  // Selects a person by their ID
  void selectPerson(int personId) {
    if (state is PeopleLoaded) {
      final loadedState = state as PeopleLoaded;
      final person = loadedState.people.firstWhere(
            (p) => p.id == personId,
        orElse: () => masterPeopleList.firstWhere((p) => p.id == personId),
      );
      emit(PersonSelected(person, loadedState.people));
    }
  }

  // Searches for people by a query
  void searchPeople(String query) {
    if (state is PeopleLoaded || state is PersonSelected) {
      final currentPeople = masterPeopleList;

      if (query.isEmpty) {
        emit(PeopleLoaded(currentPeople));
        return;
      }

      final filteredList = currentPeople.where((person) {
        final fullName = '${person.first_name} ${person.last_name}'.toLowerCase();
        return fullName.contains(query.toLowerCase());
      }).toList();

      if (state is PersonSelected) {
        final selectedState = state as PersonSelected;
        emit(PersonSelected(selectedState.selectedPerson, filteredList));
      } else {
        emit(PeopleLoaded(filteredList));
      }
    }
  }
}

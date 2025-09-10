part of 'people_extended_cubit.dart';

// I changed the state of the cubit so that it works just with states instead of having an explicit enum to handle the statuses
// I don't know if this was a good approach or not

// Base class for people states
abstract class PeopleExtendedState extends Equatable {
  const PeopleExtendedState();

  @override
  List<Object> get props => [];
}

// Initial state
class PeopleInitial extends PeopleExtendedState {}

// Loading state
class PeopleLoading extends PeopleExtendedState {}

// State when people are loaded successfully
class PeopleLoaded extends PeopleExtendedState {
  final List<Person> people;

  const PeopleLoaded(this.people);

  @override
  List<Object> get props => [people];
}

// State when a person is selected
class PersonSelected extends PeopleLoaded {
  final Person selectedPerson;

  const PersonSelected(this.selectedPerson, List<Person> people) : super(people);

  @override
  List<Object> get props => [selectedPerson, people];
}


// Error state
class PeopleError extends PeopleExtendedState {
  final String message;

  const PeopleError(this.message);

  @override
  List<Object> get props => [message];
}


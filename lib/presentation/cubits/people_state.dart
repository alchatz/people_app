part of 'people_cubit.dart';

enum PeopleStatus {
  initial,
  loading,
  loaded,
  error,
}

class PeopleState extends Equatable {
  const PeopleState({required this.status, required this.people, required this.customError});

  final People people;
  final PeopleStatus status;
  final CustomError customError;

  factory PeopleState.initial() {
    return PeopleState(
      status: PeopleStatus.initial,
      people: People.initial(),
      customError: const CustomError(),
    );
  }

  @override
  List<Object?> get props => [people];

  PeopleState copyWith({
    People? people,
    PeopleStatus? status,
    CustomError? customError,
  }) {
    return PeopleState(
      people: people ?? this.people,
      status: status ?? this.status,
      customError: customError ?? this.customError,
    );
  }
}

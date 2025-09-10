import 'package:equatable/equatable.dart';

import '../../domain/entities/person_entity.dart';

class People extends Equatable {
  final List<Person> people;

  const People({required this.people});

  factory People.initial() => People(
    people: []
  );

  factory People.fromJson(List<dynamic> json) {
    List<Person> people = [];
    for (var personJson in json) {
      people.add(Person.fromJson(personJson));
    }
    return People(people: people);
  }

  @override
  List<Object?> get props => [people];

  bool get isEmpty => (people.isEmpty);

  int? get length => (people.length);

  People copyWith({List<Person>? people}) {
    return People(people: people ?? this.people);
  }

  void operator [](int other) {}
}
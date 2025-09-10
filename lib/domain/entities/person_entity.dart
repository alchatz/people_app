import 'package:equatable/equatable.dart';

class Person extends Equatable{
  final int id;
  final String first_name;
  final String last_name;
  final String avatar;
  final String email;

  const Person({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.avatar,
    required this.email,
  });

  @override
  List<Object?> get props => [id, email, first_name, last_name, avatar];

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      email: json['email'],
      first_name: json['first_name'].isNotEmpty ? json['first_name'] : '',
      last_name: json['last_name'].isNotEmpty ? json['last_name'] : '',
      avatar: json['avatar'].isNotEmpty ? json['avatar'] : '',
    );
  }

}
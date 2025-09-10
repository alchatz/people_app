import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  const CustomError({this.errorMessage = ''});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];

  @override
  String toString() => 'CustomError(errorMessage: $errorMessage)';
}
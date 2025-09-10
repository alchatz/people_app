import 'package:equatable/equatable.dart';
import 'package:people_app/domain/entities/people_entity.dart';
// i know that the data shouldn't have access to the domain entities as is, but i didn't have the time to implement a proper injection

class JsonResponse extends Equatable {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final People data;

  const JsonResponse({required this.page, required this.perPage, required this.total, required this.totalPages, required this.data});

  factory JsonResponse.fromJson(Map<String, dynamic> json) {
    return JsonResponse(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: People.fromJson(json['data']),
    );

  }

  @override
  List<Object?> get props => [page, perPage, total, totalPages, data];

  bool get isEmpty => (data.isEmpty);

  int? get length => (data.length);

  JsonResponse copyWith({int? page, int? perPage, int? total, int? totalPages, People? data}) {
    return JsonResponse(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
      totalPages: totalPages ?? this.totalPages,
      data: data ?? this.data,
    );
  }
}
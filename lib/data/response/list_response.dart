import 'meta_response.dart';

class ListResponse<T> {
  final List<T> items;
  final MetaResponse meta;

  const ListResponse({
    required this.items,
    required this.meta,
  });

  factory ListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) mapper,
  ) {
    final data = (json['data'] as List).map((e) => mapper(e)).toList();

    return ListResponse(
      items: data,
      meta: MetaResponse.fromJson(json['meta']),
    );
  }
}

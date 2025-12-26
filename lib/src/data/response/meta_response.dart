class MetaResponse {
  final int page;
  final int totalPages;
  final int totalItems;

  const MetaResponse({
    required this.page,
    required this.totalPages,
    required this.totalItems,
  });

  factory MetaResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return MetaResponse(
      page: json['page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
      totalItems: json['total_items'] ?? 0,
    );
  }
}

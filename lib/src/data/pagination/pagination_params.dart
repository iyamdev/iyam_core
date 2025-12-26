class PaginationParams {
  final int page;
  final int limit;

  const PaginationParams({
    required this.page,
    required this.limit,
  });

  PaginationParams next() {
    return PaginationParams(
      page: page + 1,
      limit: limit,
    );
  }
}

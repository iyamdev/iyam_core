class PaginationResult<T> {
  final List<T> items;
  final int page;
  final bool hasMore;

  const PaginationResult({
    required this.items,
    required this.page,
    required this.hasMore,
  });
}

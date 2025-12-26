class TtlCache {
  final int ttlMillis;

  const TtlCache({
    required this.ttlMillis,
  });

  bool isExpired(int savedAt) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return now - savedAt > ttlMillis;
  }
}

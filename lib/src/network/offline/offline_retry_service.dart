import 'package:dio/dio.dart';
import '../../utils/network_checker.dart';
import 'offline_queue.dart';

class OfflineRetryService {
  final Dio dio;
  final OfflineQueue queue;

  OfflineRetryService(this.dio, this.queue);

  Future<void> retryIfOnline() async {
    final isOnline = await NetworkChecker.isConnected;
    if (!isOnline) return;

    final requests = await queue.getAll();
    for (final r in requests) {
      try {
        await dio.request(
          r.path,
          data: r.body,
          options: Options(method: r.method),
        );
      } catch (_) {
        return; // stop kalau gagal
      }
    }

    await queue.clear();
  }
}

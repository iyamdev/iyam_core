import '../../storage/local_storage.dart';
import 'offline_request.dart';

class OfflineQueue {
  static const _key = 'offline_queue';

  final LocalStorage storage;

  OfflineQueue(this.storage);

  Future<List<OfflineRequest>> getAll() async {
    final list = await storage.readList(_key);
    return list.map((e) => OfflineRequest.fromJson(e)).toList();
  }

  Future<void> add(OfflineRequest request) async {
    final list = await getAll();
    list.add(request);
    await storage.writeList(
      _key,
      list.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> clear() async {
    await storage.remove(_key);
  }
}

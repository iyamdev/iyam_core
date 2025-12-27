import '../repository/repository_result.dart';
import '../../database/base/ttl_cache.dart';

/// Base class for Offline-First data strategy
///
/// Flow:
/// 1. Try local cache
/// 2. Check TTL
/// 3. Fetch remote if expired or empty
/// 4. Save to local
/// 5. Return result
abstract class OfflineFirstRepository<T> {
  /// TTL strategy (must be provided by implementation)
  TtlCache get ttl;

  /// Return cached data
  Future<T?> getLocal();

  /// Save data to local storage
  Future<void> saveLocal(T data);

  /// Fetch data from remote source
  Future<RepositoryResult<T>> fetchRemote();

  /// Get last updated timestamp (millisecondsSinceEpoch)
  ///
  /// Required for TTL checking
  Future<int?> getLastUpdatedAt();

  /// Main entry point
  Future<RepositoryResult<T>> getData() async {
    final local = await getLocal();
    final savedAt = await getLastUpdatedAt();

    // 1️⃣ Return cache if valid
    if (local != null && savedAt != null && !ttl.isExpired(savedAt)) {
      return RepoSuccess(local);
    }

    // 2️⃣ Fetch from remote
    final remoteResult = await fetchRemote();

    // 3️⃣ Save & return
    if (remoteResult is RepoSuccess<T>) {
      await saveLocal(remoteResult.data);
    }

    return remoteResult;
  }

  /// Force refresh (ignore cache)
  Future<RepositoryResult<T>> refresh() async {
    final remoteResult = await fetchRemote();

    if (remoteResult is RepoSuccess<T>) {
      await saveLocal(remoteResult.data);
    }

    return remoteResult;
  }
}

import '../storage/secure_keys.dart';
import '../storage/secure_storage.dart';

class AuthTokenManager {
  final SecureStorage storage;

  AuthTokenManager(this.storage);

  Future<String?> get accessToken => storage.read(SecureKeys.token);

  Future<String?> get refreshToken => storage.read(SecureKeys.refreshToken);

  Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async {
    await storage.write(SecureKeys.token, accessToken);
    await storage.write(SecureKeys.refreshToken, refreshToken);
  }

  Future<void> clear() => storage.clear();
}

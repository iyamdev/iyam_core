abstract class DbEncryption {
  Future<String> getKey();
}

class SimpleDbEncryption implements DbEncryption {
  final String key;

  SimpleDbEncryption(this.key);

  @override
  Future<String> getKey() async => key;
}

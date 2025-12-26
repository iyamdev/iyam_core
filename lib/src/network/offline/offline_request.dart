class OfflineRequest {
  final String method;
  final String path;
  final Map<String, dynamic>? body;

  OfflineRequest({
    required this.method,
    required this.path,
    this.body,
  });

  Map<String, dynamic> toJson() => {
        'method': method,
        'path': path,
        'body': body,
      };

  factory OfflineRequest.fromJson(Map<String, dynamic> json) {
    return OfflineRequest(
      method: json['method'],
      path: json['path'],
      body: json['body'],
    );
  }
}

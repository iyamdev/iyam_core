/// Base class for all API request models
///
/// Implementations must override [toJson]
abstract class BaseRequestModel {
  /// Convert request to JSON map
  Map<String, dynamic> toJson();
}

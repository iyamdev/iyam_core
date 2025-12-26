import '../../iyam_core.dart';

abstract class ApiClient {
  Future<NetworkResult<T>> get<T>(String path);
  Future<NetworkResult<T>> post<T>(String path, {dynamic body});
  Future<NetworkResult<T>> put<T>(String path, {dynamic body});
  Future<NetworkResult<T>> delete<T>(String path);
}

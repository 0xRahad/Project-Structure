abstract class BaseApiService {
  Future<dynamic> callGetApi(String endpoint);
  Future<dynamic> callPostApi(String endpoint, var requestBody);
}
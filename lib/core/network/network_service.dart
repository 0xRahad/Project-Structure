import 'package:dio/dio.dart';
import 'package:project_structure/core/exception/app_exception.dart';
import 'package:project_structure/core/storage/session_manager.dart';
import 'package:project_structure/core/utils/logging.dart';
import 'api_service.dart';

class NetworkService extends ApiService {
  final String _baseUrl = "";
  final Dio _dio = Dio();

  NetworkService() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
    _dio.options.headers = {"Accept": "application/json"};
  }

  @override
  Future get(String url) async {
    final token = await SessionManager().getToken();
    try {
      final response = await _dio.get(
        url,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return handleResponse(response);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (error) {
      Logging.logError("Error Message: $error");
      throw Exception("Something went wrong");
    }
  }

  @override
  Future post(String url, body) async {
    final token = await SessionManager().getToken();
    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return handleResponse(response);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (error) {
      Logging.logError("Error Message: $error");
      throw Exception("Something went wrong");
    }
  }

  @override
  Future put(String url, body) async {
    final token = await SessionManager().getToken();
    try {
      final response = await _dio.put(
        url,
        data: body,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return handleResponse(response);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (error) {
      Logging.logError("Error Message: $error");
      throw Exception("Something went wrong");
    }
  }

  @override
  Future delete(String url) {
    throw UnimplementedError();
  }

  dynamic handleResponse(Response response) {
    Logging.logInfo("${response.statusCode}\n${response.data}");
    return response.data;
  }

  dynamic handleDioError(DioException e) {
    if (e.response != null) {
      Logging.logError(
        "Status Code: ${e.response?.statusCode}\nResponse Data: ${e.response?.data}",
      );
      final errorMessage =
          e.response?.data?['msg'] ?? 'Unknown server error occurred';
      throw FetchDataException(errorMessage);
    } else {
      // Capture possible Dio error types
      String errorMsg = 'Unknown Dio error';

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          errorMsg = 'Connection timeout';
          break;
        case DioExceptionType.sendTimeout:
          errorMsg = 'Send timeout';
          break;
        case DioExceptionType.receiveTimeout:
          errorMsg = 'Receive timeout';
          break;
        case DioExceptionType.badCertificate:
          errorMsg = 'Bad SSL certificate';
          break;
        case DioExceptionType.badResponse:
          errorMsg = 'Bad response: ${e.response?.statusCode}';
          break;
        case DioExceptionType.cancel:
          errorMsg = 'Request was cancelled';
          break;
        case DioExceptionType.connectionError:
          errorMsg = 'No internet connection';
          break;
        case DioExceptionType.unknown:
          errorMsg = 'Unexpected error: ${e.toString()}';
          break;
      }

      Logging.logError("Error Type: ${e.type}\nError Message: $errorMsg");
      throw NoInternetException(errorMsg);
    }
  }
}

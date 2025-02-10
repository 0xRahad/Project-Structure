import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../exception/app_exception.dart';
import '../storage/session_manager.dart';
import 'base_api_service.dart';

class NetworkService extends BaseApiService {
  final Logger _logger = Logger();
  final String _baseUrl = "https://sim.asiangroupdistributor.org/";
  final Dio _dio = Dio();

  NetworkService() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
    _dio.options.headers = {
      "Accept": "application/json",
    };
  }

  @override
  Future callGetApi(String endpoint, {Map<String, dynamic>? queryParams}) async {
    final token = await SessionManager().getToken() ?? "";
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (error) {
      _logger.e(error.toString());
      throw Exception("Something went wrong");
    }
  }

  @override
  Future callPostApi(String endpoint, dynamic requestBody) async {
    final token = await SessionManager().getToken() ?? "";
    try {
      final response = await _dio.post(
        endpoint,
        data: requestBody,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (error) {
      _logger.e(error.toString());
      throw Exception("Something went wrong");
    }
  }

  dynamic _handleResponse(Response response) {
    _logger.i("${response.statusCode}\n${response.data}");
    return response.data;
  }

  dynamic _handleDioError(DioException e) {
    if (e.response != null) {
      _logger.e("Status Code: ${e.response?.statusCode}\nResponse Data: ${e.response?.data}");
      final errorMessage = e.response?.data['message'] ?? 'Unknown error occurred';
      throw FetchDataException(errorMessage);
    } else {
      _logger.e("Error Message: ${e.message}");
      throw NoInternetException('No Internet connection');
    }
  }

}

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;


class ApiServices{

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(String path, {Map<String, dynamic>? params}) async {
    try {
      Uri uri = Uri.parse(path);
      if (params != null) {
        uri = uri.replace(queryParameters: params);
      }

      final response = await http.get(uri, headers: _headers);
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(String path, {dynamic body}) async {
    try {
      final uri = Uri.parse(path);
      final response = await http.post(
        uri,
          headers: _headers,
        body: json.encode(body),
      );
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleResponse(http.Response response) {

    final responseData = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseData;
      case 400:
        throw Exception(responseData['message'] ?? 'Bad request');
      case 401:
        throw Exception(responseData['message'] ?? 'Unauthorized');
      case 403:
        throw Exception(responseData['message'] ?? 'Forbidden');
      case 404:
        throw Exception(responseData['message'] ?? 'Not found');
      case 500:
        throw Exception(responseData['message'] ?? 'Internal server error');
      default:
        throw Exception(responseData['message'] ?? 'Something went wrong');
    }
  }

  Exception _handleError(error) {
    if (error is Exception) {
      if (error.toString().contains('SocketException')) {
        return Exception('No internet connection');
      }
      if (error.toString().contains('TimeoutException')) {
        return Exception('Connection timed out');
      }
    }
    return Exception('Something went wrong');
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static const String baseUrl = 'YOUR_BASE_URL';
  static String? _authToken;

  // Setter untuk token
  static void setToken(String token) {
    _authToken = token;
  }

  // Getter untuk headers dengan authentication
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_authToken != null) 'Authorization': 'Bearer $_authToken',
  };

  // GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  static Future<Map<String, dynamic>> post(String endpoint, {dynamic body}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: jsonEncode(body),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request
  static Future<Map<String, dynamic>> put(String endpoint, {dynamic body}) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: jsonEncode(body),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Upload file
  static Future<Map<String, dynamic>> uploadFile(String endpoint, List<int> fileBytes, String fileName) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl$endpoint'));
      
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          fileBytes,
          filename: fileName,
        ),
      );

      request.headers.addAll(_headers);
      
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Handle API response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException('Unauthorized access');
    } else {
      throw ApiException(
        'API Error: ${response.statusCode}',
        response.statusCode,
      );
    }
  }

  // Handle errors
  static Exception _handleError(dynamic e) {
    if (e is ApiException) return e;
    return ApiException('Network error: ${e.toString()}', 0);
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);

  @override
  String toString() => message;
}
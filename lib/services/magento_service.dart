import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eCommSuit/config/env.dart';

class MagentoService {
  final String _baseUrl = MagentoConfig.websiteUrl;
  final String _accessToken = MagentoConfig.accessToken;

  Future<String> getAccessToken() async {
    final String tokenUrl = '$_baseUrl/rest/V1/integration/admin/token';
    final Map<String, dynamic> requestBody = {
      'username': MagentoConfig.username,
      'password': MagentoConfig.password,
    };

    try {
      final response = await http.post(
        Uri.parse(tokenUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_accessToken'
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to obtain access token');
      }
    } catch (e) {
      throw Exception('Failed to obtain access token: $e');
    }
  }

  Future<Map<String, dynamic>> getCategories(String accessToken) async {
    final String url = '$_baseUrl/rest/default/V1/categories';
    final token = accessToken.replaceAll('"', '');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        return data;
      } else {
        throw Exception('Response code different from 200');
      }
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }


// Implement other API calls as needed
}
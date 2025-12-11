import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;
  final String baseUrl;

  ApiClient({required this.client, required this.baseUrl});

  Future<Map<String, dynamic>> post(String path,
    {Object? body, bool json = false}) async {
  final url = Uri.parse('$baseUrl$path');

  final headers = {
    'Content-Type': 'application/json',
  };

  final res = await client.post(
    url,
    headers: headers,
    body: json ? body : jsonEncode(body),
  );
  return jsonDecode(res.body);
}

  Future<Map<String, dynamic>> getFull(String url, {Map<String,String>? headers}) async {
    final res = await client.get(Uri.parse(url), headers: headers);
    final text = res.body.isNotEmpty ? res.body : '{}';
    final decoded = _tryDecode(text);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return decoded;
    } else {
      throw Exception('HTTP ${res.statusCode}: ${decoded}');
    }
  }

  Map<String, dynamic> _tryDecode(String text) {
    try {
      final json = jsonDecode(text);
      if (json is Map<String, dynamic>) return json;
      return {'data': json};
    } catch (e) {
      return {'raw': text};
    }
  }
}

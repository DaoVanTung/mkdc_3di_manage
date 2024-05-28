import 'dart:async';
import 'package:http/http.dart' as http;

class ThreeDiService {
  ThreeDiService._();
  static final _instance = ThreeDiService._();
  factory ThreeDiService() {
    return _instance;
  }

  Future<String> getSimulations({
    required int limit,
    required int offset,
  }) async {
    const orgId = 'd4b61876a9f6440f982a39f173fd73e0';
    const host = 'https://api.3di.tecotec.vn/v3';
    final url =
        '$host/usage/?simulation__organisation__unique_id=$orgId&limit=$limit&offset=$offset';
    const token =
        'X19rZXlfXzpuRjdra0hPOC5BUERCMWF2cDR4eFJRQ0dBczJnU0FrZVFsVnZXdXUyWA==';

    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $token',
      },
    );

    return res.body;
  }
}

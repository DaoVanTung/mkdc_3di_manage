import 'dart:async';
import 'package:http/http.dart' as http;

class ThreeDiService {
  ThreeDiService._();
  static final _instance = ThreeDiService._();
  factory ThreeDiService() {
    return _instance;
  }
  final host = 'https://api.3di.tecotec.vn/v3';
  final orgId = 'd4b61876a9f6440f982a39f173fd73e0';
  final token =
      'X19rZXlfXzpuRjdra0hPOC5BUERCMWF2cDR4eFJRQ0dBczJnU0FrZVFsVnZXdXUyWA==';

  Future<String> getSimulations({
    required int limit,
    required int offset,
  }) async {
    final url = StringBuffer('$host/usage/?');
    url.write('simulation__organisation__unique_id=$orgId');
    url.write('&limit=$limit&offset=$offset');

    final res = await http.get(
      Uri.parse(url.toString()),
      headers: {
        'Authorization': 'Basic $token',
      },
    );

    return res.body;
  }

  Future<String> getModelById({required String id}) async {
    final url = '$host/threedimodels/$id/';

    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $token',
      },
    );

    return res.body;
  }

  Future<String> getGridAdmin({required String modelId}) async {
    final url = '$host/threedimodels/$modelId/gridadmin/download/';

    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $token',
      },
    );

    return res.body;
  }

  Future<String> getSimulationById({required String id}) async {
    final url = '$host/simulations/$id/';

    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $token',
      },
    );

    return res.body;
  }

  Future<String> getSimulationFiles({required String id}) async {
    final url = '$host/simulations/$id/results/files/';

    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $token',
      },
    );

    return res.body;
  }

  Future<String> getDownloadFile({required String fileId}) async {
    final url = '$host/files/$fileId/download/';

    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $token',
      },
    );

    return res.body;
  }
}

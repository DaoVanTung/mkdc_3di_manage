import 'dart:async';
import 'package:http/http.dart' as http;

class ThreeDiService {
  ThreeDiService._();
  static final _instance = ThreeDiService._();
  factory ThreeDiService() {
    return _instance;
  }
  final host = 'https://api.3di.tecotec.vn/v3';
  final orgId = '0d41c6f8e6184a0b9f763814f67b8497';
  final token =
      'X19rZXlfXzpTSW5iUWxNYS5Pc3k3dlR6VUM2UFhsV21ld2VFMDZ1ZVFZdHkwdUE0eA==';

  Future<String> getSimulations({
    required int limit,
    required int offset,
    String? keyword,
  }) async {
    final url = StringBuffer('$host/usage/?');
    url.write('simulation__organisation__unique_id=$orgId');
    url.write('&limit=$limit&offset=$offset');
    if (keyword != null) {
      url.write('&simulation__name__icontains=$keyword');
    }

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

  Future<String> getUsers() async {
    final url = '$host/auth/users/';

    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $token',
      },
    );

    return res.body;
  }

  Future<String> getApiKeys() async {
    const url = 'https://api.3di.tecotec.vn/v3-beta/personalapikeys/';

    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $token',
      },
    );

    return res.body;
  }
}

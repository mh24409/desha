import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiHelper {
   Future<dynamic> get(
      {required String url,
      Map<String, String>? headers}) async {
    final response =
        await http.get(Uri.parse(url), headers: headers);
    return json.decode(response.body);
  }

  Future<dynamic> post(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    final response =
        await http.post(Uri.parse(url), body: json.encode(body), headers: headers);
    return json.decode(response.body);
  }
}

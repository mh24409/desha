import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> performLogin(String email, String password) async {
  final url = Uri.parse('https://cosmocareprod-training.technotown.technology/login');
  final headers = {
    "Content-Type": "text/html",
  };
  final body = {
    "identity": email,
    "password": password,
  };

  final response = await http.post(url, headers: headers, body: json.encode(body));

  if (response.statusCode == 200) {
    // Successful login
    return true;
  } else {
    // Failed login
    return false;
  }
}

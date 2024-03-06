import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Breeds {
  final String apiURL = dotenv.env['API_URL'] ?? "";
  final String apiKey = dotenv.env['API_KEY'] ?? "";

  Future<List?> get() async {
    print("API_URL");
    print(apiURL);
    print("API_KEY");
    print(apiKey);
    try {
      final response =
          await http.get(Uri.parse(apiURL), headers: {'x-api-key': apiKey});
      if (response != null && response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        if (result != null) {
          return result;
        }
      }
      return [];
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }
}

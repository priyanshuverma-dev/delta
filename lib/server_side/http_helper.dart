import 'package:answer_it/models/message.dart';
import 'package:answer_it/utlts/global_vars.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class HttpHelper {
  static Uri url = Uri.https(Globals.backendURL);

  static var client = http.Client();

  static Future fetchhttp() async {
    var response = await client.get(url);

    // Error handling
    if (response.statusCode == 200) {
      var jsonResponse = response.body;

      var output = messageFromJson(jsonResponse);

      log('Number of books about http: $output. ');
      log('Request with status: ${response.statusCode}.');

      return output.message;
    } else {
      log('Request failed with status: ${response.statusCode}.');
    }
  }
}

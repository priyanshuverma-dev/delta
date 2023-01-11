import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:answer_it/core/snackbar.dart';
import 'package:answer_it/core/toaster.dart';
import 'package:answer_it/features/Chat/models/message.dart';
import 'package:answer_it/utils/global_vars.dart';

class HttpHelper {
  static Uri url = Uri.https(Globals.backendURL);

  static var client = http.Client();

  static Future fetchhttp() async {
    var response = await client.get(url);

    // Error handling
    if (response.statusCode == 200) {
      var jsonResponse = response.body;

      var output = messageFromJson(jsonResponse);

      log('Output http: ${output.message}. ');
      log('Request with status: ${response.statusCode}.');
      toast('Connected', Colors.green.shade300, 20);
      if (output.message == 'Hello World') {
        return 'Bot Online';
      }
    } else {
      log('Request failed with status: ${response.statusCode}.');
      Get.showSnackbar(customSnakeBar(
        'Connection Code',
        response.statusCode.toString(),
        Icons.wifi_1_bar_outlined,
        2,
      ));
      return 'Bot offline';
    }
  }
}

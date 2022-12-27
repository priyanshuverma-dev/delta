// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:answer_it/models/bot.dart';
import 'package:answer_it/server_side/http_helper.dart';
import 'package:answer_it/utlts/global_vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller extends GetxController {
  var message = 'Getx'.obs;
  var isloading = true.obs;

  TextEditingController userInput = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    var message = await HttpHelper.fetchhttp();

    try {
      isloading.value = true;
      if (message != null) {
        this.message.value = message;
      } else {
        this.message.value = 'Error';
      }
    } finally {
      isloading.value = false;
    }
  }

  Future<void> askQuestion() async {
    try {
      isloading.value = true;
      var header = {'Content-Type': 'application/json'};
      var url = Uri.parse(Globals.withHTTPbackendURL);

      Map body = {
        'prompt': userInput.text,
      };

      var response =
          await http.post(url, headers: header, body: jsonEncode(body));

      if (response.statusCode == 200) {
        var jsonResponse = response.body;

        var output = botFromJson(jsonResponse);

        message.value = output.bot;
      } else {
        message.value = 'Error';
      }
      userInput.clear();
    } catch (e) {
      log(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}

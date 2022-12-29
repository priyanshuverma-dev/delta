import 'dart:convert';
import 'dart:developer';

import 'package:answer_it/core/snackbar.dart';
import 'package:answer_it/localStorage/database.dart';
import 'package:answer_it/models/bot.dart';
import 'package:answer_it/server/http_helper.dart';
import 'package:answer_it/utlts/global_vars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller extends GetxController {
  var message = ''.obs;
  var question = ''.obs;

  var isloading = false.obs;

  TextEditingController userInput = TextEditingController();

  final userBox = DataBase.getUserData();
  final botBox = DataBase.getBotData();

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
      if (e == 'Connection reset by peer') {
        Get.showSnackbar(customSnakeBar(
          'Connection reset',
          e.toString(),
          Icons.wifi_1_bar_outlined,
        ));

        log(e.toString());
      } else {
        log(e.toString());
        Get.showSnackbar(customSnakeBar(
          'Connection reset',
          e.toString(),
          Icons.wifi_1_bar_outlined,
        ));
      }
    } finally {
      isloading.value = false;
    }
  }
}

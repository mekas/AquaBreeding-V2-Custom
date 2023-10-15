import 'dart:async';

import 'package:fish/models/statistic_model.dart';
import 'package:fish/service/statistic_service.dart';
import 'package:fish/service/statistic_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/authentication/login_page.dart';
import '../../service/logging_service.dart';


class HomeController extends GetxController {
  var isLoading = false.obs;
  var username = "";
  DateTime initializeDate = DateTime.now();
  final statistic = StatisticModel().obs;

  @override

  // @override
  // void onReady() async {
  //   await getStatisticData();
  //   super.onReady();
  // }
  Future<void> deleteToken() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.off(LoginPage());
  }

  Future<void> getUserData() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, dynamic> jwtdecoderToken = JwtDecoder.decode(token!);
    username = jwtdecoderToken["sub"]["username"].toString();
    // print(username);
  }

  Future<void> getStatisticData() async {
    isLoading.value = true;
    StatisticModel statisticData = await StatisticService().getStatistic();
    statistic.value = statisticData;
    Timer(const Duration(seconds: 1), () {
      isLoading.value = false;
    });
  }

  late DateTime startTime;
  late DateTime endTime;
  final fitur = 'Dashboard';

  void onClose() {
    endTime = DateTime.now();
    super.onClose();
  }

  Future<void> postDataLog(String fitur) async {
    // print(buildJsonFish());
    bool value =
    await LoggingService().postLogging(startAt: startTime, fitur: fitur);
  }

  @override
  void onInit() async {
    await getStatisticData();
    startTime = DateTime.now();
    getUserData();
    postDataLog(fitur);
    super.onInit();
  }

  @override
  void dispose() {
    postDataLog(fitur);
    super.dispose();
  }
}

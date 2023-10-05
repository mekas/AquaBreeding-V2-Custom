import 'dart:async';

import 'package:fish/pages/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/login_page.dart';
import '../../service/logging_service.dart';


class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    loading();
  }

  Future<void> loading() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    Timer(const Duration(seconds: 2), () {
      if (token != 'null') {
        bool hasExpired = JwtDecoder.isExpired(token);
        print(hasExpired);
        if (hasExpired != true) {
          Get.off(DashboardPage());
        } else {
          prefs.clear();
          Get.off(LoginPage());
        }
      } else {
        Get.off(LoginPage());
      }
    });
  }

  final DateTime startTime = DateTime.now();
  final fitur = 'Grading';

  Future<void> postDataLog(String fitur) async {
    bool value =
    await LoggingService().postLogging(startAt: startTime, fitur: fitur);
  }

  @override
  void onInit() async {
    postDataLog(fitur);
    super.onInit();
  }

  @override
  void dispose() {
    postDataLog(fitur);
    super.dispose();
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:fish/models/statistic_model.dart';
import 'package:fish/service/url_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StatisticService {
  Future getStatistic() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var url = Uri.parse(Urls.statistic);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(url, headers: headers);

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        StatisticModel statistic = StatisticModel.fromJson(data);

        return statistic;
      }
    } catch (e) {
      inspect(e);
    }
  }
}

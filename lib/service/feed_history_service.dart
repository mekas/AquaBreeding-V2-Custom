// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:fish/models/feed_history_detail.dart';
import 'package:fish/models/feed_history_hourly.dart';
import 'package:fish/models/feed_history_monthly.dart';
import 'package:fish/models/feed_history_weekly.dart';
import 'package:fish/models/feed_chart_model.dart';
import 'package:fish/service/url_api.dart';
import 'package:http/http.dart' as http;

class FeedHistoryService {
  // Future<List<FeedChartData>> getChart({required String activation_id}) async {
  //   var url = Uri.parse(Urls.feedChartApi(activation_id));
  //   var headers = {'Content-Type': 'application/json'};

  //   var response = await http.get(url, headers: headers);

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     // inspect(data);
  //     List<FeedChartData> feedChartData = FeedChartData.fromJsonList(data);
  //     return feedChartData;
  //   } else {
  //     throw Exception('Gagal Get Activation!');
  //   }
  // }

  Future<List<FeedHistoryMonthly>> getMonthlyRecap(
      {required String activation_id}) async {
    var url = Uri.parse(Urls.feedHistoryMonthly(activation_id));
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<FeedHistoryMonthly> feedHistoryMonthly =
          FeedHistoryMonthly.fromJsonList(data);
      return feedHistoryMonthly;
    } else {
      throw Exception('Gagal Get Activation!');
    }
  }

  Future<List<FeedHistoryWeekly>> getWeeklyRecap(
      {required String activation_id, required String month}) async {
    var url = Uri.parse(Urls.feedHistoryWeekly(activation_id, month));
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<FeedHistoryWeekly> feedHistoryWeekly =
          FeedHistoryWeekly.fromJsonList(data);
      return feedHistoryWeekly;
    } else {
      throw Exception('Gagal Get Activation!');
    }
  }

  Future<List<FeedHistoryDaily>> getDailyRecap(
      {required String activation_id, required String week}) async {
    var url = Uri.parse(Urls.feedHistoryDaily(activation_id, week));
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<FeedHistoryDaily> feedHistoryDaily =
          FeedHistoryDaily.fromJsonList(data);
      return feedHistoryDaily;
    } else {
      throw Exception('Gagal Get Activation!');
    }
  }

  Future<List<FeedHistoryHourly>> getHourlyRecap(
      {required String activation_id, required String date}) async {
    var url = Uri.parse(Urls.feedHistory(activation_id, date));
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      inspect(data);
      List<FeedHistoryHourly> feedHistoryHourly =
          FeedHistoryHourly.fromJsonList(data);
      return feedHistoryHourly;
    } else {
      throw Exception('Gagal Get Activation!');
    }
  }

  Future<bool> postFeedHistory({
    required String? pondId,
    required String? fishFeedId,
    required String? feedDose,
  }) async {
    final response = await http.post(
      Uri.parse(Urls.feedhistorys),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "pond_id": pondId,
        "fish_feed_id": fishFeedId,
        "feed_dose": feedDose,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

// ignore_for_file: non_constant_identifier_names

import 'package:fish/models/feed_history_detail.dart';
import 'package:fish/models/feed_history_monthly.dart';
import 'package:fish/models/feed_history_weekly.dart';
import 'package:fish/models/activation_model.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/service/feed_history_service.dart';
import 'package:get/get.dart';
import '../../service/logging_service.dart';

class FeedWeeklyController extends GetxController {
  var isLoading = false.obs;
  Activation activation = Get.arguments["activation"];
  Pond pond = Get.arguments["pond"];
  FeedHistoryMonthly feedHistoryMonthly = Get.arguments['feedHistoryMonthly'];
  FeedHistoryWeekly feedHistoryWeekly = Get.arguments['feedHistoryWeekly'];
  final list_feedHistoryDaily = <FeedHistoryDaily>[].obs;

  @override
  void onInit() async {
    getDailyRecapFeedHistory(
        activation_id: activation.id!, week: feedHistoryWeekly.week.toString());
    postDataLog(fitur);
    super.onInit();
  }

  Future<void> getDailyRecapFeedHistory(
      {required String activation_id, required String week}) async {
    isLoading.value = true;
    list_feedHistoryDaily.clear();
    List<FeedHistoryDaily> feedHistoryMonthly = await FeedHistoryService()
        .getDailyRecap(activation_id: activation_id, week: week);
    list_feedHistoryDaily.addAll(feedHistoryMonthly);
    isLoading.value = false;
  }

  final DateTime startTime = DateTime.now();
  final fitur = 'Feeding Weekly';

  Future<void> postDataLog(String fitur) async {
    // print(buildJsonFish());
    bool value =
    await LoggingService().postLogging(startAt: startTime, fitur: fitur);
  }

  @override
  void dispose() {
    postDataLog(fitur);
    super.dispose();
  }
}

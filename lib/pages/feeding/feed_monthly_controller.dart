// ignore_for_file: non_constant_identifier_names

import 'package:fish/models/feed_history_monthly.dart';
import 'package:fish/models/feed_history_weekly.dart';
import 'package:fish/models/activation_model.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/service/feed_history_service.dart';
import 'package:get/get.dart';

class FeedMonthlyController extends GetxController {
  var isLoading = false.obs;
  Activation activation = Get.arguments["activation"];
  Pond pond = Get.arguments["pond"];
  FeedHistoryMonthly feedHistoryMonthly = Get.arguments['feedHistoryMonthly'];
  final list_feedHistoryWeekly = <FeedHistoryWeekly>[].obs;

  @override
  void onInit() async {
    getWeeklyRecapFeedHistory(
        activation_id: activation.id!, month: feedHistoryMonthly.getMonth());
    super.onInit();
  }

  Future<void> getWeeklyRecapFeedHistory(
      {required String activation_id, required String month}) async {
    isLoading.value = true;
    list_feedHistoryWeekly.clear();
    List<FeedHistoryWeekly> feedHistoryMonthly = await FeedHistoryService()
        .getWeeklyRecap(activation_id: activation_id, month: month);
    list_feedHistoryWeekly.addAll(feedHistoryMonthly);
    isLoading.value = false;
  }
}

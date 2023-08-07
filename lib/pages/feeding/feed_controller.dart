// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:fish/models/feed_history_monthly.dart';
import 'package:fish/models/activation_model.dart';
import 'package:fish/models/feed_chart_model.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/service/feed_history_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../service/logging_service.dart';

class FeedController extends GetxController {
  final InventarisPakanState pakanState = Get.put(InventarisPakanState());

  final charData = <FeedChartData>[].obs;
  var isLoading = false.obs;
  Activation activation = Get.arguments["activation"];
  Pond pond = Get.arguments["pond"];
  final list_feedHistoryMonthly = <FeedHistoryMonthly>[].obs;

  @override
  void onInit() async {
    getWeeklyRecapFeedHistory(activation_id: activation.id!);
    getChartFeed('Alami');

    super.onInit();
  }

  Future<void> getWeeklyRecapFeedHistory(
      {required String activation_id}) async {
    isLoading.value = true;
    list_feedHistoryMonthly.clear();
    List<FeedHistoryMonthly> feedHistoryMonthly = await FeedHistoryService()
        .getMonthlyRecap(activation_id: activation_id);
    list_feedHistoryMonthly.addAll(feedHistoryMonthly);
    isLoading.value = false;
  }

  Future<void> getChartFeed(String type) async {
    isLoading.value = true;
    charData.clear();
    await pakanState.getHistoryFeedChartData(type, () {
      for (var i in pakanState.feedChartHistoryList.value.data!) {
        var date = DateTime.parse(i.iId!.createdAt.toString());
        // DateFormat format = DateFormat("dd-MM-yyyy");
        var dateformat = DateFormat('yyyy-MM-dd').format(date);
        DateTime? formatdate = DateTime.parse(dateformat);
        // var datetime = format.parse(i.getDate());
        var data = FeedChartData(amount: i.totalUsage, date: formatdate);
        charData.add(data);
        // print(formatdate);
      }
    });
    // list_feedHistoryMonthly.addAll(feedHistoryMonthly);

    inspect(charData);
    isLoading.value = false;
  }

  final DateTime startTime = DateTime.now();
  late DateTime endTime;
  final fitur = 'Feeding';

  Future<void> postDataLog(String fitur) async {
    // print(buildJsonFish());
    bool value =
        await LoggingService().postLogging(startAt: startTime, fitur: fitur);
    print(value);
  }

  @override
  void dispose() {
    postDataLog(fitur);
    super.dispose();
  }
}

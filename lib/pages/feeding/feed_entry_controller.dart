// ignore_for_file: unused_local_variable


import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/feeding/feed_controller.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/service/feed_history_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/activation_model.dart';
import '../../service/logging_service.dart';

class FeedEntryController extends GetxController {
  TextEditingController feedDosisController = TextEditingController();
  FeedController feedController = Get.put(FeedController());
  final InventarisPakanState pakanState = Get.put(InventarisPakanState());
  RxDouble calculatedStock = 0.0.obs;

  var isLoading = false.obs;
  Pond pond = Get.arguments['pond'];
  Activation activation = Get.arguments["activation"];
  final dose = ''.obs;
  final validatedose = false.obs;

  RxBool checkBoxState = false.obs;

  void doseChanged(String val) {
    dose.value = val;
  }

  void valdose() {
    validatedose.value = true;
  }

  Future<void> postFeedHistory() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(now);
    bool value = await FeedHistoryService().postFeedHistory(
        pondId: pond.id,
        fishFeedId: pakanState.selectedFeedName.value['feed_id'],
        feedDose: pakanState.amountChecker(feedDosisController.text),
        date: pakanState.selectedUsedDate.value != "" && pakanState.selectedUsedDate.value != null ? pakanState.selectedUsedDate.value : '$formattedDate +0000',
        doAfter: () async {
          await feedController.getWeeklyRecapFeedHistory(
              activation_id: activation.id.toString());
        });

    await pakanState.postHistoryFeedData(
      pakanState.pondName.value,
      pakanState.selectedFeedName.value['feed_id'],
      pakanState.amount.text,
      pakanState.amountChecker(feedDosisController.text),
      pakanState.selectedUsedDate.value != "" && pakanState.selectedUsedDate.value != null ? pakanState.selectedUsedDate.value : '$formattedDate +0000',
      () => null,
    );

    // inspect({
    //   pakanState.pondName.value,
    //   fishFeedID.value,
    //   pakanState.amount.text,
    //   pakanState.amountChecker(feedDosisController.text),
    // });

    // print(value);
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
  void onInit() async {
    postDataLog(fitur);
    super.onInit();
  }

  @override
  void dispose() {
    feedDosisController.clear();
    postDataLog(fitur);
    super.dispose();
  }
}

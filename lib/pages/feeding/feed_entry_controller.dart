// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/feeding/feedtype_form_controller.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/service/feed_history_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/activation_model.dart';

class FeedEntryController extends GetxController {
  TextEditingController feedDosisController = TextEditingController(text: '');
  RxString fishFeedID = ''.obs;
  final InventarisPakanState pakanState = Get.put(InventarisPakanState());

  var isLoading = false.obs;
  Pond pond = Get.arguments['pond'];
  Activation activation = Get.arguments["activation"];
  final dose = ''.obs;
  final validatedose = false.obs;

  void doseChanged(String val) {
    dose.value = val;
  }

  void valdose() {
    validatedose.value = true;
  }

  // @override
  // void onInit() async {
  //   isLoading = false.obs;
  //   await feedTypeFormController.getData();
  //   isLoading = true.obs;
  //   super.onInit();
  // }

  Future<void> postFeedHistory() async {
    bool value = await FeedHistoryService().postFeedHistory(
      // feedTypeId: feedTypeFormController.getIdByName(),
      pondId: pond.id,
      fishFeedId: fishFeedID.value,
      feedDose: pakanState.amountChecker(feedDosisController.text),
    );

    // inspect({
    //   "pondId": pond.id,
    //   "fishFeedId": fishFeedID.value,
    //   "feedDose": pakanState.amountChecker(feedDosisController.text),
    // });

    await pakanState.postHistoryFeedData(
      pakanState.pondName.value,
      fishFeedID.value,
      pakanState.amount.text,
      pakanState.amountChecker(feedDosisController.text),
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
}

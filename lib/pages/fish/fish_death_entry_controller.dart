import 'dart:convert';

import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/fish/fish_recap_controller.dart';
import 'package:fish/service/activation_service.dart';
import 'package:fish/service/fish_death_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/activation_model.dart';
import '../../service/logging_service.dart';

class FishDeathEntryController extends GetxController {
  final ActivationService service = ActivationService();

  TextEditingController formDeathController = TextEditingController(text: '');
  TextEditingController diagnosa =
      TextEditingController(text: 'mati karena sakit');
  // FishTypeController fishTypeController = FishTypeController();
  Activation activation = Get.arguments["activation"];
  Pond pond = Get.arguments["pond"];
  var listFishAlive = [];

  final FishRecapController fishRecapController =
      Get.put(FishRecapController());

  RxMap<String, dynamic> selectedFish = <String, dynamic>{}.obs;

  final fishamount = ''.obs;
  final validatefishamount = false.obs;
  var isLoading = false.obs;

  Future getPondActivation() async {
    isLoading.value = true;

    try {
      var result = await service.getActivations(pondId: pond.id.toString());

      activation = result[0];
    } catch (e) {
      //
    }
    isLoading.value = false;
  }

  Future<void> getFish(Function() doAfter) async {
    isLoading.value = true;
    for (var i in activation.fishLive!) {
      listFishAlive.add({
        'id': i.fishId,
        'type': i.type!,
        'category': i.fishCategory,
      });
    }

    doAfter();
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getFish(() {});
    postDataLog(fitur);
    selectedFish.value = listFishAlive[0];
  }

  void fishamountChanged(String val) {
    fishamount.value = val;
  }

  void valfishamount() {
    validatefishamount.value = true;
  }

  List buildJson() {
    var list = [];
    var data = {
      "fish_seed_id": selectedFish.value['id'],
      "fish_category": selectedFish.value['category'],
      "type": selectedFish.value['type'],
      "amount": formDeathController.value.text,
    };
    list.add(jsonEncode(data));
    return list;
  }

  Future<void> postFishDeath(BuildContext context, Function doInPost) async {
    bool value = await FishDeathService().postFishDeath(
      pondId: pond.id,
      fish: buildJson(),
      diagnosis: diagnosa.text,
    );

    await getPondActivation();

    doInPost();

    print(value);
  }

  final DateTime startTime = DateTime.now();
  late DateTime endTime;
  final fitur = 'Fish Death';

  Future<void> postDataLog(String fitur) async {
    // print(buildJsonFish());
    bool value =
        await LoggingService().postLogging(startAt: startTime, fitur: fitur);
    print(value);
  }

  @override
  void dispose() {
    formDeathController.clear();
    postDataLog(fitur);
    super.dispose();
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_state.dart';
import 'package:fish/pages/treatment/carbon_type_controller.dart';
import 'package:fish/service/treatment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/logging_service.dart';
import 'treatment_type_controller.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/models/activation_model.dart';

class TreatmentEntryController extends GetxController {
  var isLoading = false.obs;
  // final ponds = <Pond>[].obs;
  var isNilaMerah = false.obs;
  var isNilaHitam = false.obs;
  var isLele = false.obs;
  var isPatin = false.obs;
  var isMas = false.obs;
  var nilamerahAmount = 0.obs;
  var nilahitamAmount = 0.obs;
  var leleAmount = 0.obs;
  var patinAmount = 0.obs;
  var masAmount = 0.obs;
  var nilamerahWeight = 0.obs;
  var nilahitamWeight = 0.obs;
  var leleWeight = 0.obs;
  var patinWeight = 0.obs;
  var masWeight = 0.obs;
  TextEditingController descController = TextEditingController(text: '');
  // MaterialController materialController = MaterialController();
  // ShapeController shapeController = ShapeController();
  TypeController typeController = TypeController();
  CarbonTypeController carbonTypeController = CarbonTypeController();
  TextEditingController carbonTypeNullController =
      TextEditingController(text: '');
  TextEditingController waterController = TextEditingController(text: '0');
  TextEditingController saltController = TextEditingController(text: '0');
  TextEditingController probioticController = TextEditingController(text: '0');
  TextEditingController carbonController = TextEditingController(text: '0');
  TextEditingController nilaMerahWeightController =
      TextEditingController(text: '');

  TextEditingController nilaHitamWeightController =
      TextEditingController(text: '');
  TextEditingController leleWeightController = TextEditingController(text: '');

  TextEditingController patinWeightController = TextEditingController(text: '');
  TextEditingController masWeightController = TextEditingController(text: '');
  Activation activation = Get.arguments["activation"];
  Pond pond = Get.arguments["pond"];

  RxBool checkUsedDate = false.obs;

  final InventarisBahanBudidayaState supState =
      Get.put(InventarisBahanBudidayaState());

  List buildJsonTreatment() {
    var data = [];
    data.clear();

    data.add({
      'suplemen_id': supState.probID.value,
      'amount': probioticController.value.text,
      'original_value': supState.probStock.value.toString(),
    });

    if (supState.carbCheck.value) {
      // Carbon
      data.add({
        'suplemen_id': supState.selectedCarbon.value['suplemen_id'],
        'amount': probioticController.value.text,
        'original_value': supState.probStock.value.toString(),
      });
    }
    if (supState.saltDetail.value.data!.isNotEmpty) {
      data.add({
        'suplemen_id': supState.saltDetail.value.data![0].sId,
        'amount': saltController.value.text,
        'original_value': supState.saltStock.value.toString(),
      });
    }
    if (supState.carbCheck.value &&
        supState.saltDetail.value.data!.isNotEmpty) {
      data.add({
        'suplemen_id': supState.selectedCarbon.value['suplemen_id'],
        'amount': probioticController.value.text,
        'original_value': supState.probStock.value.toString(),
      });
      data.add({
        'suplemen_id': supState.saltDetail.value.data![0].sId,
        'amount': saltController.value.text,
        'original_value': supState.saltStock.value.toString(),
      });
    }

    return data;
  }

  Future<void> postFishGrading(BuildContext context, Function doInPost) async {
    bool value = await TreatmentService().postPondTreatment(
      pondId: pond.id,
      prob_id: supState.probID.value,
      carb_id: supState.carbID.value,
      salt_id: supState.saltID.value,
      type: typeController.selected.value,
      probiotic_name: supState.selectedCultureProbiotik.value['suplemen_name'],
      probiotic: probioticController.value.text,
      desc: descController.value.text,
      water: waterController.value.text,
      carbohydrate:
          supState.carbCheck.value ? carbonController.value.text : '0',
      carbohydrate_type: supState.carbCheck.value
          ? supState.selectedCarbon.value['suplemen_name']
          : 'Tidak ada',
      salt: saltController.value.text,
    );

    await supState.postHistorySuplemenData(
      supState.pondName.value,
      buildJsonTreatment(),
      supState.selectedUsedDate.value,
      () => null,
    );
    print(value);
    doInPost();
  }

  Future<void> getHarvestedBool(Activation activation) async {
    for (var i in activation.fishLive!) {
      if (i.type == 'lele') {
        isLele.value = true;
        leleAmount.value = i.amount!;
      }
      if (i.type == 'patin') {
        isPatin.value = true;
        patinAmount.value = i.amount!;
      }
      if (i.type == 'mas') {
        isMas.value = true;
        masAmount.value = i.amount!;
      }
      if (i.type == 'nila hitam') {
        isNilaHitam.value = true;
        nilahitamAmount.value = i.amount!;
      }
      if (i.type == 'nila merah') {
        isNilaMerah.value = true;
        nilamerahAmount.value = i.amount!;
      }
    }
  }

  List buildJsonFish() {
    var data = [];
    if (isNilaMerah.value == true) {
      var fishData = {
        "type": "nila merah",
        "amount": nilamerahAmount.toString(),
        "weight": nilaMerahWeightController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isNilaHitam.value == true) {
      var fishData = {
        "type": "nila hitam",
        "amount": nilahitamAmount.toString(),
        "weight": nilaHitamWeightController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isLele.value == true) {
      var fishData = {
        "type": "lele",
        "amount": leleAmount.toString(),
        "weight": leleWeightController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isPatin.value == true) {
      var fishData = {
        "type": "patin",
        "amount": patinAmount.toString(),
        "weight": patinWeightController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isMas.value == true) {
      var fishData = {
        "type": "mas",
        "amount": masAmount.toString(),
        "weight": masWeightController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    return data;
  }

  int getWeight() {
    int weightTotal = 0;
    if (isNilaMerah.value == true) {
      weightTotal += int.parse(nilaMerahWeightController.value.text);
    }
    if (isNilaHitam.value == true) {
      weightTotal += int.parse(nilaHitamWeightController.value.text);
    }
    if (isLele.value == true) {
      weightTotal += int.parse(leleWeightController.value.text);
    }
    if (isPatin.value == true) {
      weightTotal += int.parse(patinWeightController.value.text);
    }
    if (isMas.value == true) {
      weightTotal += int.parse(masWeightController.value.text);
    }
    return weightTotal;
  }

  Future<void> postTreatmentBerat(
      BuildContext context, Function doInPost) async {
    bool value = await TreatmentService().postPondTreatmentBerat(
        pondId: pond.id,
        type: typeController.selected.value,
        desc: descController.value.text,
        total_fish_harvested: leleAmount.toInt() +
            patinAmount.toInt() +
            masAmount.toInt() +
            nilahitamAmount.toInt() +
            nilamerahAmount.toInt(),
        total_weight_harvested: getWeight(),
        isFinish: true,
        fish_harvested: buildJsonFish());
    print(value);
    doInPost();
  }

  final DateTime startTime = DateTime.now();
  late DateTime endTime;
  final fitur = 'Pond Treatment';

  Future<void> postDataLog(String fitur) async {
    // print(buildJsonFish());
    bool value =
        await LoggingService().postLogging(startAt: startTime, fitur: fitur);
  }
}

import 'dart:developer';

import 'package:fish/models/activation_model.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/pond/pond_controller.dart';
import 'package:fish/service/activation_service.dart';
import 'package:fish/service/logging_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DetailPondController extends GetxController {
  final PondController pondController = Get.put(PondController());
  final ActivationService service = ActivationService();
  final RxList activations = List<Activation>.empty().obs;
  late Rx<Activation> selectedActivation;

  var isLoading = false.obs;
  late Activation activationData;
  var isPondActive = false.obs;

  @override
  void onInit() async {
    // getPondActivation();
    postDataLog(fitur);
    super.onInit();
  }

  void updateSelectedActivation(activationid) {
    try {
      selectedActivation.value =
          activations.firstWhere((activation) => activation.id == activationid);
    } catch (e) {
      selectedActivation = Rx<Activation>(activations
          .firstWhere((activation) => activation.id == activationid));
    }
  }

  Future<void> getPondActivation() async {
    isLoading.value = true;
    activations.clear();

    List<Activation> result = await service.getActivations(
        pondId: pondController.selectedPond.value.id.toString());
    inspect(result);
    activations.addAll(result);
    print('masuk ke actvation');
    // activationData = result[0];
    for (var i in result) {
      // activations.add(i);
      if (i.isFinish == false) {
        isPondActive.value = true;
        print("masuk ini ");
      }
    }
    // inspect(isPondActive.value);

    isLoading.value = false;
  }

  final DateTime startTime = DateTime.now();
  late DateTime endTime;
  final fitur = 'Detail Pond';

  Future<void> postDataLog(String fitur) async {
    // print(buildJsonFish());
    bool value =
        await LoggingService().postLogging(startAt: startTime, fitur: fitur);
    // print(value);
  }

  @override
  void dispose() {
    postDataLog(fitur);
    super.dispose();
  }
}

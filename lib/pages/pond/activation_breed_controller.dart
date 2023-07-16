import 'dart:convert';
import 'dart:developer';

import 'package:fish/models/activation_model.dart';
import 'package:fish/pages/pond/detail_pond_controller.dart';
import 'package:fish/pages/pond/detail_pond_page.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/activation_service.dart';
import '../../service/logging_service.dart';
import '../../theme.dart';
import 'benih_option_controller.dart';
import 'breed_option_controller.dart';

class ActivationBreedController extends GetxController {
  Pond pond = Get.arguments['pond'];
  ActivationService service = ActivationService();
  BenihOptionController benihOptionController = BenihOptionController();
  BreedOptionController breedOptionController = BreedOptionController();
  TextEditingController waterHeightController = TextEditingController(text: '');
  TextEditingController kelasPembesaranController =
      TextEditingController(text: '');
  TextEditingController nilaMerahAmountController =
      TextEditingController(text: '');
  TextEditingController nilaMerahWeightController =
      TextEditingController(text: '');
  TextEditingController nilaHitamAmountController =
      TextEditingController(text: '');
  TextEditingController nilaHitamWeightController =
      TextEditingController(text: '');
  TextEditingController leleAmountController = TextEditingController(text: '');
  TextEditingController leleWeightController = TextEditingController(text: '');
  TextEditingController patinAmountController = TextEditingController(text: '');
  TextEditingController patinWeightController = TextEditingController(text: '');
  TextEditingController masAmountController = TextEditingController(text: '');
  TextEditingController masWeightController = TextEditingController(text: '');

  RxString nilaHitamSeedIDController = ''.obs;
  RxString nilaMerahSeedIDController = ''.obs;
  RxString leleSeedIDController = ''.obs;
  RxString masSeedIDController = ''.obs;
  RxString patinSeedIDController = ''.obs;

  RxString pondName = ''.obs;
  List fishTmp = [];

  final InventarisBenihState benihState = Get.put(InventarisBenihState());

  var isNilaMerah = false.obs;
  var isNilaHitam = false.obs;
  var isLele = false.obs;
  var isPatin = false.obs;
  var isMas = false.obs;
  var isActivationProgress = false.obs;
  var isPondActive = false.obs;
  var isZeroInput = true.obs;
  var isNoFist = true.obs;

  List activations = [];

  void setLele(bool value) {
    isLele.value = value;
  }

  void setNilaMerah(bool value) {
    isNilaMerah.value = value;
  }

  void setNilaHitam(bool value) {
    isNilaHitam.value = value;
  }

  void setPatin(bool value) {
    isPatin.value = value;
  }

  void setMas(bool value) {
    isMas.value = value;
  }

  List buildJsonFish() {
    isNoFist.value = true;
    var data = [];

    if (isNilaMerah.value == true) {
       if (nilaMerahAmountController.text == "0" ||
          nilaMerahWeightController.text == "0" ||
          nilaMerahAmountController.text == "" ||
          nilaMerahWeightController.text == "") {
        isNoFist.value = false;
      } else {
       var fishData = {
        "type": "nila merah",
        "seed_id": nilaMerahSeedIDController.value,
        "category": benihState.seedCategory.value,
        "original_value": benihState.nilaMerahFishStock.value,
        "amount": nilaMerahAmountController.value.text,
        "weight": benihState.nilaMerahFishWeigth.value == '-'
            ? '0'
            : benihState.nilaMerahFishWeigth.value,
        "size": benihState.nilaMerahFishSize.value == '-'
            ? '-'
            : benihState.nilaMerahFishSize.value,
      };
      fishTmp.add(fishData);
        isNoFist.value = false;
        isZeroInput.value = false;

      data.add(jsonEncode(fishData));


      }
      
    }
    if (isNilaHitam.value == true) {
       if (nilaHitamAmountController.text == "0" ||
          nilaHitamWeightController.text == "0" ||
          nilaHitamAmountController.text == "" ||
          nilaHitamWeightController.text == "") {
        isNoFist.value = false;
      } else {
        

        var fishData = {
        "type": "nila hitam",
        "seed_id": nilaHitamSeedIDController.value,
        "category": benihState.seedCategory.value,
        "original_value": benihState.nilaHitamFishStock.value,
        "amount": nilaHitamAmountController.value.text,
        "weight": benihState.nilaHitamFishWeigth.value == '-'
            ? '0'
            : benihState.nilaHitamFishWeigth.value,
        "size": benihState.nilaHitamFishSize.value == '-'
            ? '-'
            : benihState.nilaHitamFishSize.value,
      };
      fishTmp.add(fishData);
        isNoFist.value = false;
        isZeroInput.value = false;

        data.add(jsonEncode(fishData));

      }
     
    }
    if (isLele.value == true) {
      if (leleAmountController.text == "0" ||
          leleWeightController.text == "0" ||
          leleAmountController.text == "" ||
          leleWeightController.text == "") {
        isNoFist.value = false;
      } else {
        isNoFist.value = false;
        isZeroInput.value = false;

       var fishData = {
        "type": "lele",
        "seed_id": leleSeedIDController.value,
        "category": benihState.seedCategory.value,
        "original_value": benihState.leleFishStock.value,
        "amount": leleAmountController.value.text,
        "weight": benihState.leleFishWeigth.value == '-'
            ? '0'
            : benihState.leleFishWeigth.value,
        "size": benihState.leleFishSize.value == '-'
            ? '-'
            : benihState.leleFishSize.value,
      };
          fishTmp.add(fishData);
      data.add(jsonEncode(fishData));
      }
     
    
    }
    if (isPatin.value == true) {
       if (patinAmountController.text == "0" ||
          patinWeightController.text == "0" ||
          patinAmountController.text == "" ||
          patinWeightController.text == "") {
        isNoFist.value = false;
      } else {
        isNoFist.value = false;
        isZeroInput.value = false;

       var fishData = {
        "type": "patin",
        "seed_id": patinSeedIDController.value,
        "category": benihState.seedCategory.value,
        "original_value": benihState.patinFishStock.value,
        "amount": patinAmountController.value.text,
        "weight": benihState.patinFishWeigth.value == '-'
            ? '0'
            : benihState.patinFishWeigth.value,
        "size": benihState.patinFishSize.value == '-'
            ? '-'
            : benihState.patinFishSize.value,
      };
      fishTmp.add(fishData);
      data.add(jsonEncode(fishData));
      }
     
    }
    if (isMas.value == true) {
       if (masAmountController.text == "0" ||
          masWeightController.text == "0" ||
          masAmountController.text == "" ||
          masWeightController.text == "") {
        isNoFist.value = false;
      } else {
        isZeroInput.value = false;

        var fishData = {
        "type": "mas",
        "seed_id": masSeedIDController.value,
        "category": benihState.seedCategory.value,
        "original_value": benihState.masFishStock.value,
        "amount": masAmountController.value.text,
        "weight": benihState.masFishWeigth.value == '-'
            ? '0'
            : benihState.masFishWeigth.value,
        "size": benihState.masFishSize.value == '-'
            ? '-'
            : benihState.masFishSize.value,
      };
      fishTmp.add(fishData);
      data.add(jsonEncode(fishData));
 
      }
    }
     

    return data;
  }

  Future<void> pondActivation(Function() doInPost) async {
    // print(buildJsonFish());
    isActivationProgress.value = true;

    var buildFish = buildJsonFish();

    try {
      await service.postActivation(
        pondId: pond.id,
        fish: buildFish,
        isWaterPreparation: false,
        waterLevel: waterHeightController.value.text,
      );
      await benihState.postHistorySeedData(
        pondName.value,
        fishTmp,
        () => null,
      );
      doInPost();
    } catch (e) {
      //
    }
    isActivationProgress.value = false;
  Future<void> pondActivation(BuildContext context, Function doInPost) async {
    // print(buildJsonFish());

    List<dynamic> fish = buildJsonFish();
    if (isNoFist.value == true) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Input Error',
                    style: TextStyle(color: Colors.red)),
                content: const Text(
                  'Wajib Pilih Salah 1 Ikan',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: backgroundColor1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ));
    } else {
      if (isZeroInput.value == true ||
          waterHeightController.value.text == '' ||
          waterHeightController.value.text == '0') {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Input Error',
                      style: TextStyle(color: Colors.red)),
                  content: const Text(
                    'Input Tidak boleh 0/Kosong',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: backgroundColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      } else {
        print("masuk ini");
        isActivationProgress.value = true;

        try {
          await service.postActivation(
              pondId: pond.id,
              fish: fish,
              isWaterPreparation: false,
              waterLevel: waterHeightController.value.text,
              doInPost: doInPost);
          postDataLog(fitur);
        } catch (e) {
          //
        }
        isActivationProgress.value = false;
      }
    }
    // // Get.to(() => DetailPondPage(),
    // //     arguments: Pond(
    // //         id: pond.id,
    // //         idInt: pond.idInt,
    // //         alias: pond.alias,
    // //         location: pond.location,
    // //         shape: pond.shape,
    // //         material: pond.material,
    // //         isActive: true,
    // //         pondStatus: PondStatus.active));
  }
<<<<<<< HEAD
=======

  Future<void> postDataLog(String fitur) async {
    // print(buildJsonFish());
    bool value =
        await LoggingService().postLogging(startAt: startTime, fitur: fitur);
    print(value);
  }

  final DateTime startTime = DateTime.now();
  late DateTime endTime;
  final fitur = 'Activation';
>>>>>>> 376a24ff1f24bc5f91e6d48a775e2e6525edf55b
}

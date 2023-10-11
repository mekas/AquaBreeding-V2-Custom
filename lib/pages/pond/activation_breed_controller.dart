import 'dart:convert';
import 'dart:developer';

import 'package:fish/models/activation_model.dart';
import 'package:fish/pages/pond/detail_pond_controller.dart';
import 'package:fish/pages/pond/detail_pond_page.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  RxInt calculatedNilaHitamStock = 0.obs;
  RxInt calculatedNilaMerahStock = 0.obs;
  RxInt calculatedLeleStock = 0.obs;
  RxInt calculatedMasStock = 0.obs;
  RxInt calculatedPatinStock = 0.obs;

  RxString pondName = ''.obs;
  List fishTmp = [];
  RxBool checkUsedDate = false.obs;

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
    var data = [];

    if (isNilaMerah.value == true) {
      var fishData = {
        "type": "nila merah",
        "seed_id": benihState.selectedNilaMerah.value['seed_id'],
        "category": breedOptionController.selected.value,
        "original_value": benihState.nilaMerahFishStock.value,
        "amount": int.parse(nilaMerahAmountController.value.text),
        "weight": benihState.nilaMerahFishWeigth.value == '-'
            ? '0'
            : benihState.nilaMerahFishWeigth.value,
        "size": benihState.nilaMerahFishSize.value == '-'
            ? '-'
            : benihState.nilaMerahFishSize.value,
      };
      fishTmp.add(fishData);
      data.add(jsonEncode(fishData));
    }
    if (isNilaHitam.value == true) {
      var fishData = {
        "type": "nila hitam",
        "seed_id": benihState.selectedNilaHitam.value['seed_id'],
        "category": breedOptionController.selected.value,
        "original_value": benihState.nilaHitamFishStock.value,
        "amount": int.parse(nilaHitamAmountController.value.text),
        "weight": benihState.nilaHitamFishWeigth.value == '-'
            ? '0'
            : benihState.nilaHitamFishWeigth.value,
        "size": benihState.nilaHitamFishSize.value == '-'
            ? '-'
            : benihState.nilaHitamFishSize.value,
      };
      fishTmp.add(fishData);
      data.add(jsonEncode(fishData));
    }
    if (isLele.value == true) {
      var fishData = {
        "type": "lele",
        "seed_id": benihState.selectedLele.value['seed_id'],
        "category": breedOptionController.selected.value,
        "original_value": benihState.leleFishStock.value,
        "amount": int.parse(leleAmountController.value.text),
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
    if (isPatin.value == true) {
      var fishData = {
        "type": "patin",
        "seed_id": benihState.selectedPatin.value['seed_id'],
        "category": breedOptionController.selected.value,
        "original_value": benihState.patinFishStock.value,
        "amount": int.parse(patinAmountController.value.text),
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
    if (isMas.value == true) {
      var fishData = {
        "type": "mas",
        "seed_id": benihState.selectedMas.value['seed_id'],
        "category": breedOptionController.selected.value,
        "original_value": benihState.masFishStock.value,
        "amount": int.parse(masAmountController.value.text),
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

    return data;
  }

  Future<void> pondActivation(BuildContext context, Function() doInPost) async {
    // print(buildJsonFish());

    var buildFish = buildJsonFish();

    // List<dynamic> fish = buildJsonFish();

    isActivationProgress.value = true;

    inspect({
      "pondId": pond.id,
      "fish": buildFish,
      "isWaterPreparation": false,
      "waterLevel": waterHeightController.value.text,
    });
    print({
      "pondId": pond.id,
      "fish": buildFish,
      "isWaterPreparation": false,
      "waterLevel": waterHeightController.value.text,
      "activeDate" : benihState.selectedUsedDate.value != "" && benihState.selectedUsedDate.value != null ? benihState.selectedUsedDate.value : DateTime.now(),
    });

    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(now);
      await service.postActivation(
        pondId: pond.id,
        fish: buildFish,
        isWaterPreparation: false,
        waterLevel: waterHeightController.value.text,
        activeDate: benihState.selectedUsedDate.value != "" && benihState.selectedUsedDate.value != null ? benihState.selectedUsedDate.value : '$formattedDate +0000',
        doInPost: doInPost,
        doAfter: () async {
          await service.postHistorySeedData(
            pondName.value,
            fishTmp,
            benihState.selectedUsedDate.value != "" && benihState.selectedUsedDate.value != null ? benihState.selectedUsedDate.value : '$formattedDate +0000',
                () => null,
          );
        }
      );

      postDataLog(fitur);
    } catch (e) {
      //
    }
    // doInPost();
    isActivationProgress.value = false;
    // if (isNoFist.value == true) {
    //   showDialog<String>(
    //       context: context,
    //       builder: (BuildContext context) => AlertDialog(
    //             title: const Text('Input Error',
    //                 style: TextStyle(color: Colors.red)),
    //             content: const Text(
    //               'Wajib Pilih Salah 1 Ikan',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             backgroundColor: backgroundColor1,
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.all(Radius.circular(16.0))),
    //             actions: <Widget>[
    //               TextButton(
    //                 onPressed: () => Navigator.pop(context, 'OK'),
    //                 child: const Text('OK'),
    //               ),
    //             ],
    //           ));
    // } else {
    //   if (isZeroInput.value == true ||
    //       waterHeightController.value.text == '' ||
    //       waterHeightController.value.text == '0') {
    //     showDialog<String>(
    //         context: context,
    //         builder: (BuildContext context) => AlertDialog(
    //               title: const Text('Input Error',
    //                   style: TextStyle(color: Colors.red)),
    //               content: const Text(
    //                 'Input Tidak boleh 0/Kosong',
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               backgroundColor: backgroundColor1,
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.all(Radius.circular(16.0))),
    //               actions: <Widget>[
    //                 TextButton(
    //                   onPressed: () => Navigator.pop(context, 'OK'),
    //                   child: const Text('OK'),
    //                 ),
    //               ],
    //             ));
    //   } else {
    //     print("masuk ini");

    //   }
    // }
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

  final DateTime startTime = DateTime.now();
  late DateTime endTime;
  final fitur = 'Activation';

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

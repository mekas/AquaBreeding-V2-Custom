import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:fish/models/activation_model.dart';
import 'package:fish/models/fish_model.dart';
import 'package:fish/models/history/history_feed_model.dart';
import 'package:fish/models/history/history_seed_model.dart';
import 'package:fish/models/history/history_suplemen_model.dart';
import 'package:fish/models/inventaris/aset/inventaris_asset_model.dart';
import 'package:fish/models/inventaris/listrik/inventaris_listrik_model.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/dashboard.dart';
import 'package:fish/pages/deactivation_recap/deactivation_recap_state.dart';
import 'package:fish/pages/pond/detail_pond_controller.dart';
import 'package:fish/pages/pond/pond_controller.dart';
import 'package:fish/service/activation_service.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/convert_to_rupiah_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:fish/service/url_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeactivationBreedController extends GetxController {
  Pond pond = Get.arguments['pond'];
  Activation activation = Get.arguments["activation"];
  ActivationService service = ActivationService();
  final PondController pondController = Get.put(PondController());
  final DeactivationRecapState deactivationRecapState =
      Get.put(DeactivationRecapState());

  // Activation activation = Get.arguments["activation"];
  // Future<List<Activation>> activationsData =
  //       ActivationService().getActivations(pondId: pond.id!);
  // TextEditingController waterHeightController = TextEditingController(text: '');
  TextEditingController fishWeightController = TextEditingController(text: '');
  TextEditingController undersizeController = TextEditingController(text: '');
  TextEditingController oversizeController = TextEditingController(text: '');
  TextEditingController normalsizeController = TextEditingController(text: '');
  TextEditingController fishLengthAvgController =
      TextEditingController(text: '');
  TextEditingController sampleAmountController =
      TextEditingController(text: '');
  TextEditingController nilaMerahWeightController =
      TextEditingController(text: '');

  TextEditingController nilaHitamWeightController =
      TextEditingController(text: '');
  TextEditingController leleWeightController = TextEditingController(text: '');

  TextEditingController patinWeightController = TextEditingController(text: '');
  TextEditingController masWeightController = TextEditingController(text: '');

  RxInt lelePrice = 0.obs;
  RxInt masPrice = 0.obs;
  RxInt patinPrice = 0.obs;
  RxInt nilaHitamPrice = 0.obs;
  RxInt nilaMerahPrice = 0.obs;

  TextEditingController lelePriceController = TextEditingController();
  TextEditingController masPriceController = TextEditingController();
  TextEditingController patinPriceController = TextEditingController();
  TextEditingController nilaHitamPriceController = TextEditingController();
  TextEditingController nilaMerahPriceController = TextEditingController();

  RxString pondName = ''.obs;

  var isLoading = false.obs;
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
  var isDeactivationProgress = false.obs;

  var leleId = ''.obs;
  var masId = ''.obs;
  var patinId = ''.obs;
  var nilaMerahId = ''.obs;
  var nilaHitamId = ''.obs;

  var leleType = ''.obs;
  var masType = ''.obs;
  var patinType = ''.obs;
  var nilaMerahType = ''.obs;
  var nilaHitamType = ''.obs;

  RxBool isLoadingInventory = false.obs;
  var assetList = InventarisAssetModel(data: []).obs;
  var electricList = InventarisListrikModel(data: []).obs;
  var suplemenHistoryList = HistorySuplemenModel(data: []).obs;
  var feedHistoryList = HistoryFeedModel(data: []).obs;
  var seedHistoryList = HistorySeedModel(data: []).obs;

  RxBool checkUsedDate = false.obs;
  RxString selectedUsedDate = ''.obs;
  TextEditingController showedUsedDate = TextEditingController(text: '');

  Future getAllAssetData(
    String first,
    String last,
    Function() doAfter,
  ) async {
    assetList.value.data!.clear();
    var assetPrice = 0;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
      // Uri.parse('${Urls.invAsset}?start_date=$first&end_date=$last'),
      Uri.parse(Urls.invAsset),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        InventarisAssetModel res =
            InventarisAssetModel.fromJson(jsonDecode(response.body));

        assetList.value = res;

        if (assetList.value.data!.isNotEmpty) {
          for (var i in assetList.value.data!) {
            assetPrice += i.price!;
          }
        }

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }

    return (assetPrice / (60 * pondController.ponds.length)).round();
  }

  Future getAllElectricData(
      String first, String last, Function() doAfter) async {
    var filteredPond = [];
    var electricPrice = 0;

    electricList.value.data!.clear();
    filteredPond.clear();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
        Uri.parse('${Urls.invElect}?start_date=$first&end_date=$last'),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        InventarisListrikModel res =
            InventarisListrikModel.fromJson(jsonDecode(response.body));

        electricList.value = res;

        if (electricList.value.data!.isNotEmpty) {
          for (var i in electricList.value.data!) {
            electricPrice += i.price!;
          }
        }
        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }

    for (var i in pondController.ponds) {
      if (i.isActive!) {
        filteredPond.add(i);
      }
    }

    return (electricPrice / filteredPond.length).round();
  }

  Future getHistorySuplemenData(
    String firstDate,
    String lastDate,
    String pondName,
    Function() doAfter,
  ) async {
    suplemenHistoryList.value.data!.clear();
    var suplemenPrice = 0;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
      Uri.parse(
          '${Urls.suplemenSch}?start_date=$firstDate&end_date=$lastDate&pond_name=$pondName'),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        HistorySuplemenModel res =
            HistorySuplemenModel.fromJson(jsonDecode(response.body));

        suplemenHistoryList.value = res;

        if (suplemenHistoryList.value.data!.isNotEmpty) {
          for (var i in suplemenHistoryList.value.data!) {
            suplemenPrice +=
                ((i.usage! / i.originalAmount!) * i.suplemen!.price!).round();
          }
        }

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }

    return suplemenPrice;
  }

  Future getHistoryFeedData(String firstDate, String lastDate, String pondName,
      Function() doAfter) async {
    feedHistoryList.value.data!.clear();
    var feedPrice = 0;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
        Uri.parse(
            '${Urls.feedSch}?start_date=$firstDate&end_date=$lastDate&pond_name=$pondName'),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        HistoryFeedModel res =
            HistoryFeedModel.fromJson(jsonDecode(response.body));

        feedHistoryList.value = res;

        if (feedHistoryList.value.data!.isNotEmpty) {
          for (var i in feedHistoryList.value.data!) {
            feedPrice +=
                ((i.usage! / i.originalAmount!) * i.feed!.price!).round();
          }
        }

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }
    return feedPrice;
  }

  Future getHistorySeedData(String firstDate, String lastDate, String pondName,
      Function() doAfter) async {
    seedHistoryList.value.data!.clear();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
      Uri.parse(
          '${Urls.seedSch}?start_date=$firstDate&end_date=$lastDate&pond_name=$pondName'),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        HistorySeedModel res =
            HistorySeedModel.fromJson(jsonDecode(response.body));

        seedHistoryList.value = res;

        if (seedHistoryList.value.data!.isNotEmpty) {
          for (var i in activation.fishLive!) {
            // for (var j in seedHistoryList.value.data!) {
            //   if (i.fishId == j.fishSeedId) {
            //     if (i.type == "patin") {
            //       patinUsed += j.usage!;
            //     }
            //     if (i.type == "lele") {
            //       leleUsed += j.usage!;
            //     }
            //     if (i.type == "mas") {
            //       masUsed += j.usage!;
            //     }
            //     if (i.type == "nila hitam") {
            //       nilaHitamUsed += j.usage!;
            //     }
            //     if (i.type == "nila merah") {
            //       nilaMerahUsed += j.usage!;
            //     }
            //   }
            // }

            for (var j in seedHistoryList.value.data!) {
              if (i.fishId == j.fishSeedId) {
                if (i.type == "patin") {
                  patinPrice.value += ((j.usage! / j.originalAmount!) *
                          j.seed!.price! *
                          j.originalAmount!)
                      .round();
                }
                if (i.type == "lele") {
                  lelePrice.value += ((j.usage! / j.originalAmount!) *
                          j.seed!.price! *
                          j.originalAmount!)
                      .round();
                }
                if (i.type == "mas") {
                  masPrice.value += ((j.usage! / j.originalAmount!) *
                          j.seed!.price! *
                          j.originalAmount!)
                      .round();
                }
                if (i.type == "nila hitam") {
                  nilaHitamPrice.value += ((j.usage! / j.originalAmount!) *
                          j.seed!.price! *
                          j.originalAmount!)
                      .round();
                }
                if (i.type == "nila merah") {
                  nilaMerahPrice.value += ((j.usage! / j.originalAmount!) *
                          j.seed!.price! *
                          j.originalAmount!)
                      .round();
                }
              }
            }
          }
        }

        inspect(seedHistoryList.value.data!);

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getAllInventory(String firstDate, String lastDate) async {
    isLoadingInventory.value = true;

    DateTime now = DateTime.now();
    var currMonth = DateTime.now().month;
    var currYear = DateTime.now().year;
    int lastday = DateTime(now.year, now.month + 1, 0).day;

    try {
      // var valueA = 0; // Rumus 1 (Aset)

      var valueA = await getAllAssetData(
        firstDate,
        lastDate,
        () => null,
      ); // Rumus 2 (Aset)

      var valueB = await getAllElectricData(
        '$currYear-$currMonth-01',
        '$currYear-$currMonth-$lastday',
        () => null,
      );
      var valueC = await getHistorySuplemenData(
        firstDate,
        lastDate,
        pondName.value,
        () => null,
      );
      var valueD = await getHistoryFeedData(
        firstDate,
        lastDate,
        pondName.value,
        () => null,
      );
      await getHistorySeedData(
        firstDate,
        lastDate,
        pondName.value,
        () => null,
      );

      inspect({
        'first_date': firstDate,
        'last_date': lastDate,
        'asset': valueA,
        'listrik': valueB,
        'sup': valueC,
        'feed': valueD,
      });

      for (var i in activation.fishLive!) {
        if (i.type == 'lele') {
          lelePriceController.text = ConvertToRupiah.formatToRupiah(
            ((valueA + valueB + valueC + valueD + lelePrice.value) /
                    activation.fishAmount!)
                .round(),
          );
        }
        if (i.type == 'mas') {
          masPriceController.text = ConvertToRupiah.formatToRupiah(
            ((valueA + valueB + valueC + valueD + masPrice.value) /
                    activation.fishAmount!)
                .round(),
          );
        }
        if (i.type == 'patin') {
          patinPriceController.text = ConvertToRupiah.formatToRupiah(
            ((valueA + valueB + valueC + valueD + patinPrice.value) /
                    activation.fishAmount!)
                .round(),
          );
        }
        if (i.type == 'nila hitam') {
          nilaHitamPriceController.text = ConvertToRupiah.formatToRupiah(
            ((valueA + valueB + valueC + valueD + nilaHitamPrice.value) /
                    activation.fishAmount!)
                .round(),
          );
        }
        if (i.type == 'nila merah') {
          nilaMerahPriceController.text = ConvertToRupiah.formatToRupiah(
            ((valueA + valueB + valueC + valueD + nilaMerahPrice.value) /
                    activation.fishAmount!)
                .round(),
          );
        }
      }
    } catch (e) {
      inspect(e);
      throw Exception(e);
    }

    Future.delayed(const Duration(seconds: 2), () {
      isLoadingInventory.value = false;
    });
  }

  Future<void> getHarvestedBool(Activation activation) async {
    for (var i in activation.fishLive!) {
      if (i.type == 'lele') {
        isLele.value = true;
        leleAmount.value = i.amount!;
        leleId.value = i.fishId!;
        leleType.value = i.fishCategory!;
      }
      if (i.type == 'patin') {
        isPatin.value = true;
        patinAmount.value = i.amount!;
        patinId.value = i.fishId!;
        patinType.value = i.fishCategory!;
      }
      if (i.type == 'mas') {
        isMas.value = true;
        masAmount.value = i.amount!;
        masId.value = i.fishId!;
        masType.value = i.fishCategory!;
      }
      if (i.type == 'nila hitam') {
        isNilaHitam.value = true;
        nilahitamAmount.value = i.amount!;
        nilaMerahId.value = i.fishId!;
        nilaMerahType.value = i.fishCategory!;
      }
      if (i.type == 'nila merah') {
        isNilaMerah.value = true;
        nilamerahAmount.value = i.amount!;
        nilaMerahId.value = i.fishId!;
        nilaMerahType.value = i.fishCategory!;
      }
    }
  }

  List buildJsonFish() {
    var data = [];
    if (isNilaMerah.value == true) {
      if (nilaMerahWeightController.value.text.contains(",")) {
        String nilaMerah =
            nilaMerahWeightController.value.text.replaceAll(',', '.');
        var fishData = {
          "type": "nila merah",
          "amount": nilamerahAmount.toString(),
          "weight": nilaMerah,
          "fish_seed_id": nilaMerahId.value,
          "fish_category": nilaMerahType.value
        };
        data.add(jsonEncode(fishData));
      } else {
        var fishData = {
          "type": "nila merah",
          "amount": nilamerahAmount.toString(),
          "weight": nilaMerahWeightController.value.text,
          "fish_seed_id": nilaMerahId.value,
          "fish_category": nilaMerahType.value
        };
        data.add(jsonEncode(fishData));
      }
    }
    if (isNilaHitam.value == true) {
      if (nilaHitamWeightController.value.text.contains(",")) {
        String nilaHitam =
            nilaHitamWeightController.value.text.replaceAll(',', '.');
        var fishData = {
          "type": "nila hitam",
          "amount": nilahitamAmount.toString(),
          "weight": nilaHitam,
          "fish_seed_id": nilaHitamId.value,
          "fish_category": nilaHitamType.value
        };
        data.add(jsonEncode(fishData));
      } else {
        var fishData = {
          "type": "nila hitam",
          "amount": nilahitamAmount.toString(),
          "weight": nilaHitamWeightController.value.text,
          "fish_seed_id": nilaHitamId.value,
          "fish_category": nilaHitamType.value
        };
        data.add(jsonEncode(fishData));
      }
    }
    if (isLele.value == true) {
      if (leleWeightController.value.text.contains(",")) {
        String lele = leleWeightController.value.text.replaceAll(',', '.');
        var fishData = {
          "type": "lele",
          "amount": leleAmount.toString(),
          "weight": lele,
          "fish_seed_id": leleId.value,
          "fish_category": leleType.value
        };
        data.add(jsonEncode(fishData));
      } else {
        var fishData = {
          "type": "lele",
          "amount": leleAmount.toString(),
          "weight": leleWeightController.value.text,
          "fish_seed_id": leleId.value,
          "fish_category": leleType.value
        };
        data.add(jsonEncode(fishData));
      }
    }
    if (isPatin.value == true) {
      if (patinWeightController.value.text.contains(",")) {
        String patin = patinWeightController.value.text.replaceAll(',', '.');
        var fishData = {
          "type": "patin",
          "amount": patinAmount.toString(),
          "weight": patin,
          "fish_seed_id": patinId.value,
          "fish_category": patinType.value
        };
        data.add(jsonEncode(fishData));
      } else {
        var fishData = {
          "type": "patin",
          "amount": patinAmount.toString(),
          "weight": patinWeightController.value.text,
          "fish_seed_id": patinId.value,
          "fish_category": patinType.value
        };
        data.add(jsonEncode(fishData));
      }
    }
    if (isMas.value == true) {
      if (masWeightController.value.text.contains(",")) {
        String mas = masWeightController.value.text.replaceAll(',', '.');
        var fishData = {
          "type": "mas",
          "amount": masAmount.toString(),
          "weight": mas,
          "fish_seed_id": masId.value,
          "fish_category": masType.value
        };
        data.add(jsonEncode(fishData));
      } else {
        var fishData = {
          "type": "mas",
          "amount": masAmount.toString(),
          "weight": masWeightController.value.text,
          "fish_seed_id": masId.value,
          "fish_category": masType.value
        };
        data.add(jsonEncode(fishData));
      }
    }
    return data;
  }

  double getWeight() {
    double weightTotal = 0;
    if (isNilaMerah.value == true) {
      if (nilaMerahWeightController.value.text.contains(',')) {
        String nilaMerah =
            nilaMerahWeightController.value.text.replaceAll(',', '.');

        weightTotal += double.parse(nilaMerah);
      } else {
        weightTotal += double.parse(nilaMerahWeightController.value.text);
      }
    }
    if (isNilaHitam.value == true) {
      if (nilaHitamWeightController.text != '') {
        if (nilaHitamWeightController.value.text.contains(',')) {
          String nilaHitam =
              nilaHitamWeightController.value.text.replaceAll(',', '.');

          weightTotal += double.parse(nilaHitam);
        } else {
          weightTotal += double.parse(nilaHitamWeightController.value.text);
        }
      }
    }
    if (isLele.value == true) {
      if (leleWeightController.value.text.contains(',')) {
        String lele = leleWeightController.value.text.replaceAll(',', '.');
        weightTotal += double.parse(lele);
      } else {
        weightTotal += double.parse(leleWeightController.value.text);
      }
    }
    if (isPatin.value == true) {
      if (patinWeightController.value.text.contains(',')) {
        String patin = patinWeightController.value.text.replaceAll(',', '.');
        weightTotal += double.parse(patin);
      } else {
        weightTotal += double.parse(patinWeightController.value.text);
      }
    }
    if (isMas.value == true) {
      if (masWeightController.value.text.contains(',')) {
        String mas = masWeightController.value.text.replaceAll(',', '.');

        weightTotal += double.parse(mas);
      } else {
        weightTotal += double.parse(masWeightController.value.text);
      }
    }
    return weightTotal;
  }

  List buildJsonFishRecap() {
    var data = [];
    if (isNilaMerah.value == true) {
      if (nilaMerahWeightController.value.text.contains(",")) {
        String nilaMerah =
            nilaMerahWeightController.value.text.replaceAll(',', '.');
        var fishData = {
          "type": "nila merah",
          "amount": nilamerahAmount.toString(),
          "weight": nilaMerah,
          "fish_seed_id": nilaMerahId.value,
          "fish_category": nilaMerahType.value,
          "fish_price":
              nilaMerahPriceController.text.split(',')[0].split('.').join(''),
        };
        data.add(fishData);
      } else {
        var fishData = {
          "type": "nila merah",
          "amount": nilamerahAmount.toString(),
          "weight": nilaMerahWeightController.value.text,
          "fish_seed_id": nilaMerahId.value,
          "fish_category": nilaMerahType.value,
          "fish_price":
              nilaMerahPriceController.text.split(',')[0].split('.').join(''),
        };
        data.add(fishData);
      }
    }
    if (isNilaHitam.value == true) {
      if (nilaHitamWeightController.value.text.contains(",")) {
        String nilaHitam =
            nilaHitamWeightController.value.text.replaceAll(',', '.');
        var fishData = {
          "type": "nila hitam",
          "amount": nilahitamAmount.toString(),
          "weight": nilaHitam,
          "fish_seed_id": nilaHitamId.value,
          "fish_category": nilaHitamType.value,
          "fish_price":
              nilaHitamPriceController.text.split(',')[0].split('.').join(''),
        };
        data.add(fishData);
      } else {
        var fishData = {
          "type": "nila hitam",
          "amount": nilahitamAmount.toString(),
          "weight": nilaHitamWeightController.value.text,
          "fish_seed_id": nilaHitamId.value,
          "fish_category": nilaHitamType.value,
          "fish_price":
              nilaHitamPriceController.text.split(',')[0].split('.').join(''),
        };
        data.add(fishData);
      }
    }
    if (isLele.value == true) {
      if (leleWeightController.value.text.contains(",")) {
        String lele = leleWeightController.value.text.replaceAll(',', '.');
        var fishData = {
          "type": "lele",
          "amount": leleAmount.toString(),
          "weight": lele,
          "fish_seed_id": leleId.value,
          "fish_category": leleType.value,
          "fish_price":
              lelePriceController.text.split(',')[0].split('.').join(''),
        };
        data.add(fishData);
      } else {
        var fishData = {
          "type": "lele",
          "amount": leleAmount.toString(),
          "weight": leleWeightController.value.text,
          "fish_seed_id": leleId.value,
          "fish_category": leleType.value,
          "fish_price":
              lelePriceController.text.split(',')[0].split('.').join(''),
        };
        data.add(fishData);
      }
    }
    if (isPatin.value == true) {
      if (patinWeightController.value.text.contains(",")) {
        String patin = patinWeightController.value.text.replaceAll(',', '.');
        var fishData = {
          "type": "patin",
          "amount": patinAmount.toString(),
          "weight": patin,
          "fish_seed_id": patinId.value,
          "fish_category": patinType.value,
          "fish_price":
              patinPriceController.text.split(',')[0].split('.').join(''),
        };
        data.add(fishData);
      } else {
        var fishData = {
          "type": "patin",
          "amount": patinAmount.toString(),
          "weight": patinWeightController.value.text,
          "fish_seed_id": patinId.value,
          "fish_category": patinType.value,
          "fish_price":
              patinPriceController.text.split(',')[0].split('.').join(''),
        };
        data.add(fishData);
      }
    }
    if (isMas.value == true) {
      if (masWeightController.value.text.contains(",")) {
        String mas = masWeightController.value.text.replaceAll(',', '.');
        var fishData = {
          "type": "mas",
          "amount": masAmount.toString(),
          "weight": mas,
          "fish_seed_id": masId.value,
          "fish_category": masType.value,
          "fish_price":
              masPriceController.text.split(',')[0].split('.').join(''),
        };
        data.add(fishData);
      } else {
        var fishData = {
          "type": "mas",
          "amount": masAmount.toString(),
          "weight": masWeightController.value.text,
          "fish_seed_id": masId.value,
          "fish_category": masType.value,
          "fish_price":
              masPriceController.text.split(',')[0].split('.').join(''),
        };
        data.add(fishData);
      }
    }
    return data;
  }

  String dateFormat(String dateString, bool includeHour) {
    DateTime dateTime = DateTime.parse(dateString);
    var formatter = includeHour
        ? DateFormat('EEEE, d MMMM y | HH:mm', 'id')
        : DateFormat('EEEE, d MMMM y', 'id');
    var formattedDate = formatter.format(dateTime);
    return formattedDate.split('|').join('| Jam');
  }

  Future<void> pondDeactivation(BuildContext context, Function doInPost) async {
    var fishDataRecap = buildJsonFishRecap();

    double weight = getWeight();
    if (weight == 0) {
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
      isDeactivationProgress.value = true;
      try {
        await service.postDeactivation(
          pondId: pond.id,
          total_fish_harvested: leleAmount.toInt() +
              patinAmount.toInt() +
              masAmount.toInt() +
              nilahitamAmount.toInt() +
              nilamerahAmount.toInt(),
          total_weight_harvested: getWeight().toString(),
          isFinish: true,
          fish_harvested: buildJsonFish(),
          date: selectedUsedDate.value,
          doInPost: doInPost,
          context: context,
        );
        await deactivationRecapState.postRecap(
          pond.id.toString(),
          fishDataRecap,
          selectedUsedDate.value,
          () => null,
        );
        doInPost();
      } catch (e) {
        //
      }
      isDeactivationProgress.value = false;
    }
  }

  late DateTime startTime;
  late DateTime endTime;
  final fitur = 'Deactivation';

  void onClose() {
    endTime = DateTime.now();
    super.onClose();
  }

  void onInit() {
    startTime = DateTime.now();
    super.onInit();
  }
}

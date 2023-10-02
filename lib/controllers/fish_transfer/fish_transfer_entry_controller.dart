import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:fish/pages/treatment/carbon_type_controller.dart';
import 'package:fish/service/fish_transfer_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/history/history_feed_model.dart';
import '../../models/history/history_seed_model.dart';
import '../../models/history/history_suplemen_model.dart';
import '../../models/inventaris/aset/inventaris_asset_model.dart';
import '../../models/inventaris/listrik/inventaris_listrik_model.dart';
import '../../models/new_sortir_model.dart';
import '../../pages/pond/pond_controller.dart';
import '../../service/logging_service.dart';
import '../../service/pond_service.dart';
import '../../service/url_api.dart';
import 'pond_list_item_controller.dart';
import 'transfer_method_controller.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/models/activation_model.dart';
import 'package:http/http.dart' as http;
import 'transfer_type_controller.dart';
import 'package:fish/widgets/convert_to_rupiah_widget.dart';
class FishTransferEntryController extends GetxController {
  var isLoading = false.obs;
  // final ponds = <Pond>[].obs;
  var isNilaMerah = false.obs;
  var isNilaHitam = false.obs;
  var isLele = false.obs;
  var isPatin = false.obs;
  var isMas = false.obs;
  var destinationIsActive = false.obs;
  var nilamerahAmount = 0.obs;
  var nilahitamAmount = 0.obs;
  var leleAmount = 0.obs;
  var patinAmount = 0.obs;
  var masAmount = 0.obs;
  RxInt nilamerahAmountChecker = 0.obs;
  RxInt nilahitamAmountChecker = 0.obs;
  RxInt leleAmountChecker = 0.obs;
  RxInt patinAmountChecker = 0.obs;
  RxInt masAmountChecker = 0.obs;
  RxInt nilamerahAmountComparator = 0.obs;
  RxInt nilahitamAmountComparator = 0.obs;
  RxInt leleAmountComparator = 0.obs;
  RxInt patinAmountComparator = 0.obs;
  RxInt masAmountComparator = 0.obs;
  var nilamerahWeight = 0.obs;
  var nilahitamWeight = 0.obs;
  var leleWeight = 0.obs;
  var patinWeight = 0.obs;
  var masWeight = 0.obs;

  var isNilaMerahInput = false.obs;
  var isNilaHitamInput = false.obs;
  var isLeleInput = false.obs;
  var isPatinInput = false.obs;
  var isMasInput = false.obs;

  // var aktivasi
  var isNilaMerahActivation = false.obs;
  var isNilaHitamActivation = false.obs;
  var isLeleActivation = false.obs;
  var isPatinActivation = false.obs;
  var isMasActivation = false.obs;

  //fish seed dan fish category
  var fishSeed = ''.obs;
  var fishCategory = ''.obs;

  //for get price
  RxBool isLoadingInventory = false.obs;
  var assetList = InventarisAssetModel(data: []).obs;
  var electricList = InventarisListrikModel(data: []).obs;
  var suplemenHistoryList = HistorySuplemenModel(data: []).obs;
  var feedHistoryList = HistoryFeedModel(data: []).obs;
  var seedHistoryList = HistorySeedModel(data: []).obs;

  RxInt lelePrice = 0.obs;
  RxInt masPrice = 0.obs;
  RxInt patinPrice = 0.obs;
  RxInt nilaHitamPrice = 0.obs;
  RxInt nilaMerahPrice = 0.obs;

  var finalLelePrice = 0.obs;
  var finalMasPrice = 0.obs;
  var finalPatinPrice = 0.obs;
  var finalNilaHitamPrice = 0.obs;
  var finalNilaMerahPrice = 0.obs;

  var finalLeleTotalPrice = 0.obs;
  var finalMasTotalPrice = 0.obs;
  var finalPatinTotalPrice = 0.obs;
  var finalNilaHitamTotalPrice = 0.obs;
  var finalNilaMerahTotalPrice = 0.obs;

  TextEditingController lelePriceController = TextEditingController();
  TextEditingController masPriceController = TextEditingController();
  TextEditingController patinPriceController = TextEditingController();
  TextEditingController nilaHitamPriceController = TextEditingController();
  TextEditingController nilaMerahPriceController = TextEditingController();

  final PondController pondController = Get.put(PondController());
  RxString pondName = ''.obs;


  TextEditingController descController = TextEditingController(text: '');
//input transfer
  PondListController pondlistController = PondListController();
  TransferMethodController methodController = TransferMethodController();
  TransferTypeController typeController = TransferTypeController();

  TextEditingController sampleWeightController =
      TextEditingController(text: '0');

  TextEditingController sampleLongController = TextEditingController(text: '0');
  TextEditingController nilaMerahAmountController =
      TextEditingController(text: '');

  TextEditingController nilaHitamAmountController =
      TextEditingController(text: '');
  TextEditingController leleAmountController = TextEditingController(text: '');

  TextEditingController patinAmountController = TextEditingController(text: '');
  TextEditingController masAmountController = TextEditingController(text: '');

  TextEditingController nilaMerahWeightController =
      TextEditingController(text: '');

  TextEditingController nilaHitamWeightController =
      TextEditingController(text: '');
  TextEditingController leleWeightController = TextEditingController(text: '');

  TextEditingController patinWeightController = TextEditingController(text: '');
  TextEditingController masWeightController = TextEditingController(text: '');
  //input aktifasi
  TextEditingController nilaMerahWeightActivationController =
      TextEditingController(text: '');

  TextEditingController nilaHitamWeightActivationController =
      TextEditingController(text: '');
  TextEditingController leleWeightActivationController =
      TextEditingController(text: '');

  TextEditingController patinWeightActivationController =
      TextEditingController(text: '');
  TextEditingController masWeightActivationController =
      TextEditingController(text: '');
  TextEditingController nilaMerahAmountActivationController =
      TextEditingController(text: '');

  TextEditingController nilaHitamAmountActivationController =
      TextEditingController(text: '');
  TextEditingController leleAmountActivationController =
      TextEditingController(text: '');

  TextEditingController patinAmountActivationController =
      TextEditingController(text: '');
  TextEditingController masAmountActivationController =
      TextEditingController(text: '');
  TextEditingController waterHeightController =
      TextEditingController(text: '0');

  //input deaktifasi
  TextEditingController nilaMerahWeightDeactivationController =
      TextEditingController(text: '');

  TextEditingController nilaHitamWeightDeactivationController =
      TextEditingController(text: '');
  TextEditingController leleWeightDeactivationController =
      TextEditingController(text: '');

  TextEditingController patinWeightDeactivationController =
      TextEditingController(text: '');
  TextEditingController masWeightDeactivationController =
      TextEditingController(text: '');
  TextEditingController nilaMerahAmountDeactivationController =
      TextEditingController(text: '');

  TextEditingController nilaHitamAmountDeactivationController =
      TextEditingController(text: '');
  TextEditingController leleAmountDeactivationController =
      TextEditingController(text: '');

  TextEditingController patinAmountDeactivationController =
      TextEditingController(text: '');
  TextEditingController masAmountDeactivationController =
      TextEditingController(text: '');
  Activation activation = Get.arguments["activation"];
  Pond pond = Get.arguments["pond"];
  // final listPondName = [].obs;
  RxList<String> listPondName = List<String>.empty().obs;
  final pondSelected = <Pond>[].obs;
  var pondIdSelected = "";
  RxList<String> pondIdList = <String>[].obs;
  final listPond = <ListPondSortir>[].obs;
  final listPondSelected = <ListPondSortir>[].obs;

  Future<void> setData(List<ListPondSortir> value) async {
    isLoading.value = true;
    listPondSelected.value = value;
    isLoading.value = false;
  }

  Future<void> getPondsData(String method) async {
    isLoading.value = true;
    List<Pond> pondsData = await PondService().getPonds();
    listPond.clear();
    if (method == "kering") {
      for (var i in pondsData) {
        if (i.alias != pond.alias) {
          ListPondSortir pond = ListPondSortir(
              id: i.id, isInputed: false, name: i.alias, isActive: i.isActive);
          listPond.add(pond);
        }
      }
    } else {
      for (var i in pondsData) {
        if (i.alias != pond.alias) {
          if (i.isActive == true) {
            ListPondSortir pond = ListPondSortir(
                id: i.id,
                isInputed: false,
                name: i.alias,
                isActive: i.isActive);
            listPond.add(pond);
          }
        }
      }
    }
    isLoading.value = false;
  }
  // Future<void> getPondsData(String method) async {
  //   isLoading.value = true;
  //   int index = 0;
  //   List<Pond> pondsData = await PondService().getPonds();
  //   listPondName.clear();
  //   if (method == "kering") {
  //     for (var i in pondsData) {
  //       if (pondlistController.listPondSelected.isEmpty) {
  //         listPondName.add(i.alias.toString());
  //       } else {
  //         if (i.id != pondlistController.listPondSelected[index].id) {
  //           listPondName.add(i.alias.toString());
  //         } else {
  //           index++;
  //         }
  //       }
  //     }
  //   } else {
  //     for (var i in pondsData) {
  //       if (i.isActive == true) {
  //         if (pondlistController.listPondSelected.isEmpty) {
  //           listPondName.add(i.alias.toString());
  //         } else {
  //           if (i.id != pondlistController.listPondSelected[index].id) {
  //             listPondName.add(i.alias.toString());
  //           } else {
  //             index++;
  //           }
  //         }
  //       }
  //     }
  //   }
  //   isLoading.value = false;
  // }

  Future<void> getDestinationId(String alias) async {
    isLoading.value = true;
    List<Pond> pondsData = await PondService().getPonds();
    pondSelected.clear();
    for (var i in pondsData) {
      if (i.alias == alias) {
        pondSelected.add(i);
        destinationIsActive.value = i.isActive!;
        pondIdSelected = i.id.toString();
      }
    }
    print(pondIdSelected);
    print(pondSelected);
    isLoading.value = false;
  }

  Future<void> postFishTransferBasah(
      BuildContext context, Function doInPost) async {
    double sampleweight = int.parse(sampleWeightController.value.text) / 1000;
    bool value = await FishTransferService().postFishTransfer(
        origin_pond_id: pond.id,
        destination_pond_id: pondIdSelected,
        transfer_method: methodController.selected.value,
        transfer_type: "oversized_transfer",
        sample_long: sampleLongController.value.text,
        sample_weight: sampleweight.toString(),
        fish: buildJsonFish());
    print(value);
    doInPost();
  }

  Future<void> getHarvestedBool(Activation activation) async {
    if (!activation.isFinish!){
      for (var i in activation.fishLive!) {
        print("data ikan: ${i.fishId}, ${i.type}, ${i.fishCategory}, ${i.amount}");

        if (i.type == 'lele') {
          isLele.value = true;
          leleAmountChecker.value = i.amount!;
          fishSeed.value = i.fishId!;
          fishCategory.value = i.fishCategory!;
          // finalLelePrice.value = int.parse(lelePriceController.text.toString());
          // finalLeleTotalPrice.value = finalLelePrice.value * i.amount!;
          print("amount lele: ${i.amount!}");
          print("price each lele: ${ finalLelePrice.value}");
          print("total price lele: ${ finalLeleTotalPrice.value}");
        }
        if (i.type == 'patin') {
          isPatin.value = true;
          patinAmountChecker.value = i.amount!;
          fishSeed.value = i.fishId!;
          fishCategory.value = i.fishCategory!;
          // finalPatinPrice.value = int.parse(patinPriceController.text.toString());
          // finalPatinTotalPrice.value = finalPatinPrice.value * i.amount!;
          print("amount patin: ${i.amount!}");
          print("price each patin: ${ finalPatinPrice.value}");
          print("total price patin: ${ finalPatinTotalPrice.value}");
        }
        if (i.type == 'mas') {
          isMas.value = true;
          masAmountChecker.value = i.amount!;
          fishSeed.value = i.fishId!;
          fishCategory.value = i.fishCategory!;
          // finalMasPrice.value = int.parse(masPriceController.text.toString());
          // finalMasTotalPrice.value = finalMasPrice.value * i.amount!;
          print("amount mas: ${i.amount!}");
          print("price each mas: ${ finalMasPrice.value}");
          print("total price mas: ${ finalMasTotalPrice.value}");
        }
        if (i.type == 'nila hitam') {
          isNilaHitam.value = true;
          nilahitamAmountChecker.value = i.amount!;
          fishSeed.value = i.fishId!;
          fishCategory.value = i.fishCategory!;
          print("nila price controller: ${nilaHitamPriceController.text}");
          // finalNilaHitamPrice.value = int.parse(nilaHitamPriceController.text.toString());
          // finalNilaHitamTotalPrice.value = finalNilaHitamPrice.value * i.amount!;
          print("amount nila hitam: ${i.amount!}");
          print("price each NilaHitam: ${ finalNilaHitamPrice.value}");
          print("total price NilaHitam: ${ finalNilaHitamTotalPrice.value}");

        }
        if (i.type == 'nila merah') {
          isNilaMerah.value = true;
          nilamerahAmountChecker.value = i.amount!;
          fishSeed.value = i.fishId!;
          fishCategory.value = i.fishCategory!;
          // finalNilaMerahPrice.value = int.parse(nilaMerahPriceController.text.toString());
          // finalNilaMerahTotalPrice.value = finalNilaMerahPrice.value * i.amount!;
          print("amount nila merah: ${i.amount!}");
          print("price each NilaMerah: ${ finalNilaMerahPrice.value}");
          print("total price NilaMerah: ${ finalNilaMerahTotalPrice.value}");

        }
      }
    }

  }

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
  Future getAllInventory(String firstDate, String lastDate, Activation activation) async {
    print("sedang menghitung harga....");
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

      // inspect({
      //   'first_date': firstDate,
      //   'last_date': lastDate,
      //   'asset': valueA,
      //   'listrik': valueB,
      //   'sup': valueC,
      //   'feed': valueD,
      // });

      if (!activation.isFinish!){
        for (var i in activation.fishLive!) {
          print("data ikan: ${i.fishId}, ${i.type}, ${i.fishCategory}, ${i.amount}");
          if (i.type == 'lele') {
            print("true lele get all inventory");
            lelePriceController.text = ConvertToRupiah.formatToRupiah(
              ((valueA + valueB + valueC + valueD + lelePrice.value) /
                  activation.fishAmount!)
                  .round(),
            );
            print("lele price fish_transfer_entry_controller: ${lelePriceController.text}");
          }
          if (i.type == 'mas') {
            print("true mas");
            masPriceController.text = ConvertToRupiah.formatToRupiah(
              ((valueA + valueB + valueC + valueD + masPrice.value) /
                  activation.fishAmount!)
                  .round(),
            );
          }
          if (i.type == 'patin') {
            print("true patin");
            patinPriceController.text = ConvertToRupiah.formatToRupiah(
              ((valueA + valueB + valueC + valueD + patinPrice.value) /
                  activation.fishAmount!)
                  .round(),
            );
          }
          if (i.type == 'nila hitam') {
            print("true nila hitam");
            nilaHitamPriceController.text = ConvertToRupiah.formatToRupiah(
              ((valueA + valueB + valueC + valueD + nilaHitamPrice.value) /
                  activation.fishAmount!)
                  .round(),
            );
            print("valueA + valueB + valueC + valueD + nilaHitamPrice.value) /activation.fishAmount!).round() = ${nilaHitamPriceController.text}");
          }
          if (i.type == 'nila merah') {
            print("true nila merah");
            nilaMerahPriceController.text = ConvertToRupiah.formatToRupiah(
              ((valueA + valueB + valueC + valueD + nilaMerahPrice.value) /
                  activation.fishAmount!)
                  .round(),
            );

          }
        }
      }
    } catch (e) {
      throw Exception(e);
    }

    isLoadingInventory.value = false;
  }

  void setInputLele(bool value) {
    isLeleInput.value = value;
  }

  void setInputNilaMerah(bool value) {
    isNilaMerahInput.value = value;
  }

  void setInputNilaHitam(bool value) {
    isNilaHitamInput.value = value;
  }

  void setInputPatin(bool value) {
    isPatinInput.value = value;
  }

  void setInputMas(bool value) {
    isMasInput.value = value;
  }

  List buildJsonFish() {
    var data = [];
    if (isNilaMerahInput.value == true) {
      nilamerahAmountComparator +
          int.parse(nilaMerahAmountController.value.text);
      var fishData = {
        "type": "nila merah",
        "amount": nilaMerahAmountController.value.text,
        "weight": nilaMerahWeightController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isNilaHitamInput.value == true) {
      nilahitamAmountComparator +
          int.parse(nilaHitamAmountController.value.text);
      var fishData = {
        "type": "nila hitam",
        "amount": nilaHitamAmountController.value.text,
        "weight": nilaHitamWeightController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isLeleInput.value == true) {
      leleAmountComparator + int.parse(leleAmountController.value.text);
      var fishData = {
        "type": "lele",
        "amount": leleAmountController.value.text,
        "weight": leleWeightController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isPatinInput.value == true) {
      patinAmountComparator + int.parse(patinAmountController.value.text);
      var fishData = {
        "type": "patin",
        "amount": patinAmountController.value.text,
        "weight": patinWeightController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isMasInput.value == true) {
      masAmountComparator + int.parse(masAmountController.value.text);
      var fishData = {
        "type": "mas",
        "amount": masAmountController.value.text,
        "weight": masWeightController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    return data;
  }

//function aktifasi
  void setLele(bool value) {
    isLeleActivation.value = value;
  }

  void setNilaMerah(bool value) {
    isNilaMerahActivation.value = value;
  }

  void setNilaHitam(bool value) {
    isNilaHitamActivation.value = value;
  }

  void setPatin(bool value) {
    isPatinActivation.value = value;
  }

  void setMas(bool value) {
    isMasActivation.value = value;
  }

  List buildJsonFishActivation() {
    var data = [];
    if (isNilaMerahActivation.value == true) {
      var fishData = {
        "type": "nila merah",
        "amount": nilaMerahAmountActivationController.value.text,
        "weight": nilaMerahAmountActivationController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isNilaHitamActivation.value == true) {
      var fishData = {
        "type": "nila hitam",
        "amount": nilaHitamAmountActivationController.value.text,
        "weight": nilaHitamWeightActivationController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isLeleActivation.value == true) {
      var fishData = {
        "type": "lele",
        "amount": leleAmountActivationController.value.text,
        "weight": leleWeightActivationController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isPatinActivation.value == true) {
      var fishData = {
        "type": "patin",
        "amount": patinAmountActivationController.value.text,
        "weight": patinWeightActivationController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isMasActivation.value == true) {
      var fishData = {
        "type": "mas",
        "amount": masAmountActivationController.value.text,
        "weight": masWeightActivationController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    return data;
  }

  //funtion deactivation
  List buildJsonFishDeactivation() {
    var data = [];
    if (isNilaMerah.value == true) {
      var fishData = {
        "type": "nila merah",
        "amount": nilaMerahAmountDeactivationController.value.text,
        "weight": nilaMerahAmountDeactivationController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isNilaHitam.value == true) {
      var fishData = {
        "type": "nila hitam",
        "amount": nilaHitamAmountDeactivationController.value.text,
        "weight": nilaHitamWeightDeactivationController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isLele.value == true) {
      var fishData = {
        "type": "lele",
        "amount": leleAmountDeactivationController.value.text,
        "weight": leleWeightDeactivationController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isPatin.value == true) {
      var fishData = {
        "type": "patin",
        "amount": patinAmountDeactivationController.value.text,
        "weight": patinWeightDeactivationController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    if (isMas.value == true) {
      var fishData = {
        "type": "mas",
        "amount": masAmountDeactivationController.value.text,
        "weight": masWeightDeactivationController.value.text,
      };
      data.add(jsonEncode(fishData));
    }
    return data;
  }

  int getWeightDeactivation() {
    int weightTotal = 0;
    if (isNilaMerah.value == true) {
      weightTotal +=
          int.parse(nilaMerahWeightDeactivationController.value.text);
    }
    if (isNilaHitam.value == true) {
      weightTotal +=
          int.parse(nilaHitamWeightDeactivationController.value.text);
    }
    if (isLele.value == true) {
      weightTotal += int.parse(leleWeightDeactivationController.value.text);
    }
    if (isPatin.value == true) {
      weightTotal += int.parse(patinWeightDeactivationController.value.text);
    }
    if (isMas.value == true) {
      weightTotal += int.parse(masWeightDeactivationController.value.text);
    }
    return weightTotal;
  }

  int getAmountDeactivation() {
    int amountTotal = 0;
    if (isNilaMerah.value == true) {
      amountTotal +=
          int.parse(nilaMerahAmountDeactivationController.value.text);
    }
    if (isNilaHitam.value == true) {
      amountTotal +=
          int.parse(nilaHitamAmountDeactivationController.value.text);
    }
    if (isLele.value == true) {
      amountTotal += int.parse(leleAmountDeactivationController.value.text);
    }
    if (isPatin.value == true) {
      amountTotal += int.parse(patinAmountDeactivationController.value.text);
    }
    if (isMas.value == true) {
      amountTotal += int.parse(masAmountDeactivationController.value.text);
    }
    return amountTotal;
  }

  Future<void> postSortirKering(BuildContext context, Function doInPost) async {
    double sampleweight = int.parse(sampleWeightController.value.text) / 1000;
    bool value = await FishTransferService().postFishTransferKering(
        origin_pond_id: pond.id,
        destination_pond_id: pondIdSelected,
        transfer_method: methodController.selected.value,
        transfer_type: "oversized_transfer",
        sample_long: sampleLongController.value.text,
        sample_weight: sampleweight.toString(),
        total_fish_harvested: leleAmount.toInt() +
            patinAmount.toInt() +
            masAmount.toInt() +
            nilahitamAmount.toInt() +
            nilamerahAmount.toInt(),
        total_weight_harvested: getWeightDeactivation(),
        fish: buildJsonFish(),
        fishstock: buildJsonFishActivation(),
        fishharvested: buildJsonFishDeactivation(),
        water_level: waterHeightController.value.text);
    print(value);
    doInPost();
  }

  final sampleLong = ''.obs;
  final validatesampleLong = false.obs;
  void sampleLongChanged(String val) {
    sampleLong.value = val;
  }

  void valsampleLong() {
    validatesampleLong.value = true;
  }

  final sampleWeight = ''.obs;
  final validatesampleWeight = false.obs;
  void sampleWeightChanged(String val) {
    sampleWeight.value = val;
  }

  void valsampleWeight() {
    validatesampleWeight.value = true;
  }

  final leleAmountval = ''.obs;
  final validateleleAmountval = false.obs;
  void leleAmountvalChanged(String val) {
    leleAmountval.value = val;
  }

  void valleleAmountval() {
    validateleleAmountval.value = true;
  }

  final leleWeightval = ''.obs;
  final validateleleWeightval = false.obs;
  void leleWeightvalChanged(String val) {
    leleWeightval.value = val;
  }

  void valleleWeightval() {
    validateleleWeightval.value = true;
  }

  final nilaMerahAmountval = ''.obs;
  final validatenilaMerahAmountval = false.obs;
  void nilaMerahAmountvalChanged(String val) {
    nilaMerahAmountval.value = val;
  }

  void valnilaMerahAmountval() {
    validatenilaMerahAmountval.value = true;
  }

  final nilaMerahWeightval = ''.obs;
  final validatenilaMerahWeightval = false.obs;
  void nilaMerahWeightvalChanged(String val) {
    nilaMerahWeightval.value = val;
  }

  void valnilaMerahWeightval() {
    validatenilaMerahWeightval.value = true;
  }

  final nilaHitamAmountval = ''.obs;
  final validatenilaHitamAmountval = false.obs;
  void nilaHitamAmountvalChanged(String val) {
    nilaHitamAmountval.value = val;
  }

  void valnilaHitamAmountval() {
    validatenilaHitamAmountval.value = true;
  }

  final nilaHitamWeightval = ''.obs;
  final validatenilaHitamWeightval = false.obs;
  void nilaHitamWeightvalChanged(String val) {
    nilaHitamWeightval.value = val;
  }

  void valnilaHitamWeightval() {
    validatenilaHitamWeightval.value = true;
  }

  final masAmountval = ''.obs;
  final validatemasAmountval = false.obs;
  void masAmountvalChanged(String val) {
    masAmountval.value = val;
  }

  void valmasAmountval() {
    validatemasAmountval.value = true;
  }

  final masWeightval = ''.obs;
  final validatemasWeightval = false.obs;
  void masWeightvalChanged(String val) {
    masWeightval.value = val;
  }

  void valmasWeightval() {
    validatemasWeightval.value = true;
  }

  final patinAmountval = ''.obs;
  final validatepatinAmountval = false.obs;
  void patinAmountvalChanged(String val) {
    patinAmountval.value = val;
  }

  void valpatinAmountval() {
    validatepatinAmountval.value = true;
  }

  final patinWeightval = ''.obs;
  final validatepatinWeightval = false.obs;
  void patinWeightvalChanged(String val) {
    patinWeightval.value = val;
  }

  void valpatinWeightval() {
    validatepatinWeightval.value = true;
  }

  final DateTime startTime = DateTime.now();
  late DateTime endTime;
  final fitur = 'Fist Transfer(Sortir)';

  Future<void> postDataLog(String fitur) async {
    // print(buildJsonFish());
    bool value =
        await LoggingService().postLogging(startAt: startTime, fitur: fitur);
  }
}

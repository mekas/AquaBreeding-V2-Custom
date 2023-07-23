import 'dart:convert';
import 'dart:developer';

import 'package:fish/models/history/history_seed_model.dart';
import 'package:fish/models/inventaris/benih/detail_inventaris_benih_model.dart';
import 'package:fish/models/inventaris/benih/inventaris_benih_model.dart';
import 'package:fish/service/url_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class InventarisBenihState extends Urls {
  RxString pageIdentifier = 'benih'.obs;

  RxBool isLoadingPage = false.obs;
  RxBool isLoadingPost = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool isLoadingDetail = false.obs;
  RxBool isLoadingHistory = false.obs;

  final List listLele = [];
  RxMap<String, dynamic> selectedLele = <String, dynamic>{}.obs;
  RxBool isLoadingLeleDetail = false.obs;
  RxString leleFishWeigth = ''.obs;
  RxString leleFishSize = ''.obs;
  RxString leleFishStock = ''.obs;
  RxBool isLeleSelected = false.obs;

  final List listNilaHitam = [];
  RxMap<String, dynamic> selectedNilaHitam = <String, dynamic>{}.obs;
  RxBool isLoadingNilaHitamDetail = false.obs;
  RxString nilaHitamFishWeigth = ''.obs;
  RxString nilaHitamFishSize = ''.obs;
  RxString nilaHitamFishStock = ''.obs;
  RxBool isNilaHitamSelected = false.obs;

  final List listNilaMerah = [];
  RxMap<String, dynamic> selectedNilaMerah = <String, dynamic>{}.obs;
  RxBool isLoadingNilaMerahDetail = false.obs;
  RxString nilaMerahFishWeigth = ''.obs;
  RxString nilaMerahFishSize = ''.obs;
  RxString nilaMerahFishStock = ''.obs;
  RxBool isNilaMerahSelected = false.obs;

  final List listPatin = [];
  RxMap<String, dynamic> selectedPatin = <String, dynamic>{}.obs;
  RxBool isLoadingPatinDetail = false.obs;
  RxString patinFishWeigth = ''.obs;
  RxString patinFishSize = ''.obs;
  RxString patinFishStock = ''.obs;
  RxBool isPatinSelected = false.obs;

  final List listMas = [];
  RxMap<String, dynamic> selectedMas = <String, dynamic>{}.obs;
  RxBool isLoadingMasDetail = false.obs;
  RxString masFishWeigth = ''.obs;
  RxString masFishSize = ''.obs;
  RxString masFishStock = ''.obs;
  RxBool isMasSelected = false.obs;

  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();

  var seedList = InventarisBenihModel(data: []).obs;
  var seedHistoryList = HistorySeedModel(data: []).obs;

  var dropdownList = [
    'Benih',
    'Pembesaran',
  ];
  var dropdownList2 = [
    'Lele',
    'Nila Merah',
    'Nila Hitam',
    'Patin',
    'Mas',
  ];
  var dropdownList3 = [
    '1-2 cm',
    '2-3 cm',
    '3-4 cm',
    '4-5 cm',
    '5-6 cm',
    '6-7 cm',
    '7-8 cm',
    '8-9 cm',
    '9-10 cm',
    '10-11 cm',
    '11-12 cm',
    '12-13 cm',
  ];

  RxString seedCategory = 'Benih'.obs;
  RxString fishCategory = 'Lele'.obs;
  RxString sortSize = '1-2 cm'.obs;
  RxString fishName = ''.obs;
  TextEditingController fishAmount = TextEditingController();
  TextEditingController fishWeight = TextEditingController();
  TextEditingController fishPrice = TextEditingController(text: '0');
  TextEditingController fishPriceTotal = TextEditingController(text: '0');
  RxString fishImage =
      'https://www.hepper.com/wp-content/uploads/2022/09/red-male-betta-fish-in-aquarium_Grigorii-Pisotscki-Shutterstock.jpg'
          .obs;

  RxBool fishAmountEdit = false.obs;
  RxBool fishWeightEdit = false.obs;
  RxBool fishPriceEdit = false.obs;
  RxBool fishPriceTotalEdit = false.obs;

  RxBool isSheetEditable = false.obs;
  RxBool isReversed = false.obs;

  var nameHistoryList = [
    '',
  ];
  RxString selectedNameHistory = ''.obs;

  Future getAllSeedData(String type) async {
    seedList.value.data!.clear();
    nameHistoryList.clear();
    nameHistoryList.add('Semua');
    listMas.clear();
    listNilaHitam.clear();
    listNilaMerah.clear();
    listPatin.clear();
    listLele.clear();
    resetVariables();
    isLoadingPage.value = true;
    final response = await http.get(Uri.parse('${Urls.invSeed}?type=$type'));

    try {
      if (response.statusCode == 200) {
        InventarisBenihModel res =
            InventarisBenihModel.fromJson(jsonDecode(response.body));

        seedList.value = res;

        for (var i in seedList.value.data!) {
          nameHistoryList.add(i.brandName.toString());
        }

        for (var i in seedList.value.data!) {
          if (i.fishType == 'Lele') {
            listLele.add({
              'id': i.idInt,
              'seed_id': i.sId,
              'fishName': i.brandName,
            });

            selectedLele.value = listLele[0];
          }
          if (i.fishType == 'Nila Hitam') {
            listNilaHitam.add({
              'id': i.idInt,
              'seed_id': i.sId,
              'fishName': i.brandName,
            });

            selectedNilaHitam.value = listNilaHitam[0];
          }
          if (i.fishType == 'Nila Merah') {
            listNilaMerah.add({
              'id': i.idInt,
              'seed_id': i.sId,
              'fishName': i.brandName,
            });

            selectedNilaMerah.value = listNilaMerah[0];
          }
          if (i.fishType == 'Patin') {
            listPatin.add({
              'id': i.idInt,
              'seed_id': i.sId,
              'fishName': i.brandName,
            });

            selectedPatin.value = listPatin[0];
          }
          if (i.fishType == 'Mas') {
            listMas.add({
              'id': i.idInt,
              'seed_id': i.sId,
              'fishName': i.brandName,
            });

            selectedMas.value = listMas[0];
          }
        }

        selectedNameHistory.value = nameHistoryList[0];
      }
      // inspect(listLele);
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPage.value = false;
  }

  Future getFishSeedDetail(String type, int id, Function() doAfter) async {
    resetVariables();
    final response = await http.get(Uri.parse('${Urls.invSeed}/$id'));

    try {
      if (type == 'Lele') {
        isLoadingLeleDetail.value = true;
        isLeleSelected.value = true;

        if (response.statusCode == 200) {
          DetailInventarisBenihModel res =
              DetailInventarisBenihModel.fromJson(jsonDecode(response.body));

          leleFishWeigth.value = res.data!.weight.toString() == '0'
              ? '-'
              : res.data!.weight.toString();
          leleFishSize.value = res.data!.width.toString() == ''
              ? '-'
              : res.data!.width.toString();
          leleFishStock.value = res.data!.amount.toString();
        }
      }

      if (type == 'Mas') {
        isLoadingMasDetail.value = true;
        isMasSelected.value = true;

        if (response.statusCode == 200) {
          DetailInventarisBenihModel res =
              DetailInventarisBenihModel.fromJson(jsonDecode(response.body));

          masFishWeigth.value = res.data!.weight.toString() == '0'
              ? '-'
              : res.data!.weight.toString();
          masFishSize.value = res.data!.width.toString() == ''
              ? '-'
              : res.data!.width.toString();
          masFishStock.value = res.data!.amount.toString();
        }
      }

      if (type == 'Patin') {
        isLoadingPatinDetail.value = true;
        isPatinSelected.value = true;

        if (response.statusCode == 200) {
          DetailInventarisBenihModel res =
              DetailInventarisBenihModel.fromJson(jsonDecode(response.body));

          patinFishWeigth.value = res.data!.weight.toString() == '0'
              ? '-'
              : res.data!.weight.toString();
          patinFishSize.value = res.data!.width.toString() == ''
              ? '-'
              : res.data!.width.toString();
          patinFishStock.value = res.data!.amount.toString();
        }
      }

      if (type == 'Nila Hitam') {
        isLoadingNilaHitamDetail.value = true;
        isNilaHitamSelected.value = true;

        if (response.statusCode == 200) {
          DetailInventarisBenihModel res =
              DetailInventarisBenihModel.fromJson(jsonDecode(response.body));

          nilaHitamFishWeigth.value = res.data!.weight.toString() == '0'
              ? '-'
              : res.data!.weight.toString();
          nilaHitamFishSize.value = res.data!.width.toString() == ''
              ? '-'
              : res.data!.width.toString();
          nilaHitamFishStock.value = res.data!.amount.toString();
        }
      }

      if (type == 'Nila Merah') {
        isLoadingNilaMerahDetail.value = true;
        isNilaMerahSelected.value = true;

        if (response.statusCode == 200) {
          DetailInventarisBenihModel res =
              DetailInventarisBenihModel.fromJson(jsonDecode(response.body));

          nilaMerahFishWeigth.value = res.data!.weight.toString() == '0'
              ? '-'
              : res.data!.weight.toString();
          nilaMerahFishSize.value = res.data!.width.toString() == ''
              ? '-'
              : res.data!.width.toString();
          nilaMerahFishStock.value = res.data!.amount.toString();
        }
      }

      doAfter();
      isLoadingLeleDetail.value = false;
      isLoadingNilaHitamDetail.value = false;
      isLoadingNilaMerahDetail.value = false;
      isLoadingPatinDetail.value = false;
      isLoadingMasDetail.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getSeedDataByID(int id, Function() doAfter) async {
    isLoadingDetail.value = true;
    final response = await http.get(Uri.parse('${Urls.invSeed}/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisBenihModel res =
            DetailInventarisBenihModel.fromJson(jsonDecode(response.body));

        seedCategory.value = res.data!.fishSeedCategory.toString();
        fishCategory.value = res.data!.fishType.toString();
        sortSize.value = res.data!.width.toString();
        fishName.value = seedCategory.value == 'Benih'
            ? '${fishCategory.value}${sortSize.value.split(' ')[0].replaceAll('-', '')}'
            : '${fishCategory.value}${fishWeight.text.split(' ')[0]}';
        fishAmount.text = res.data!.amount.toString();
        fishWeight.text = res.data!.weight!.toStringAsFixed(2);
        fishPrice.text = res.data!.price.toString();
        fishPriceTotal.text = res.data!.totalPrice.toString();
        fishImage.value = res.data!.image.toString();
      }
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingDetail.value = false;
  }

  Future postSeedData(Function() doAfter) async {
    var map = <String, dynamic>{};

    map['fish_seed_category'] = seedCategory.value;
    map['fish_type'] = fishCategory.value;
    map['brand_name'] = seedCategory.value == 'Benih'
        ? '${fishCategory.value.replaceAll(' ', '')}${sortSize.value.split(' ')[0]}'
        : '${fishCategory.value.replaceAll(' ', '')}${fishWeight.text.replaceAll(',', '.').split('.')[0]}';
    map['amount'] = fishAmount.text == '' ? '0' : fishAmount.text;
    map['weight'] =
        fishWeight.text == '' ? '0' : fishWeight.text.replaceAll(',', '.');
    map['width'] = seedCategory.value == 'Benih' ? sortSize.value : "";
    map['price'] = fishPrice.text == '' ? '0' : fishPrice.text;
    map['total_price'] = fishPriceTotal.text == '' ? '0' : fishPriceTotal.text;
    map['image'] = fishImage.value;

    isLoadingPost.value = true;

    inspect(map);

    try {
      await http.post(
        Uri.parse(Urls.invSeed),
        body: map,
      );
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPost.value = false;
  }

  Future updateSeedData(int id, Function() doAfter) async {
    var map = <String, dynamic>{};

    map['fish_seed_category'] = seedCategory.value;
    map['fish_type'] = fishCategory.value;
    map['brand_name'] = seedCategory.value == 'Benih'
        ? '${fishCategory.value.replaceAll(' ', '')}${sortSize.value.split(' ')[0]}'
        : '${fishCategory.value.replaceAll(' ', '')}${fishWeight.text.replaceAll(',', '.').split('.')[0]}';
    map['amount'] = fishAmount.text == '' ? '0' : fishAmount.text;
    map['weight'] =
        fishWeight.text == '' ? '0' : fishWeight.text.replaceAll(',', '.');
    map['width'] = seedCategory.value == 'Benih' ? sortSize.value : "";
    map['price'] = fishPrice.text == '' ? '0' : fishPrice.text;
    map['total_price'] = fishPriceTotal.text == '' ? '0' : fishPriceTotal.text;
    map['image'] = fishImage.value;

    isLoadingPost.value = true;

    try {
      inspect(map);
      await http.put(
        Uri.parse('${Urls.invSeed}/$id'),
        body: map,
      );
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPost.value = false;
  }

  Future deleteSeedData(int id, Function() doAfter) async {
    isLoadingDelete.value = true;
    try {
      await http.delete(
        Uri.parse(
          '${Urls.invSeed}/$id',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingDelete.value = false;
  }

  Future postHistorySeedData(
      String pondName, List fish, Function() doAfter) async {
    var map = <String, dynamic>{};

    map['pond'] = pondName;

    // print('HEHE');

    for (var i = 0; i < fish.length; i++) {
      map['fish_seed_id'] = fish[i]['seed_id'];
      map['original_amount'] = fish[i]['original_value'];
      map['usage'] = fish[i]['amount'];

      try {
        await http.post(
          Uri.parse(Urls.seedSch),
          body: map,
        );
        doAfter();
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  Future getHistorySeedData(bool isReversed, String firstDate, String lastDate,
      String name, Function() doAfter) async {
    seedHistoryList.value.data!.clear();
    isLoadingHistory.value = true;

    final response = await http.get(Uri.parse(
        '${Urls.seedSch}?start_date=$firstDate&end_date=$lastDate&name=$name'));

    try {
      if (response.statusCode == 200) {
        HistorySeedModel res =
            HistorySeedModel.fromJson(jsonDecode(response.body));

        if (isReversed) {
          var temp = res;
          seedHistoryList.value.data = temp.data!.reversed.toList();
        } else {
          var temp = res;
          seedHistoryList.value.data = temp.data!;
        }

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }
    isLoadingHistory.value = false;
  }

  resetVariables() {
    leleFishSize.value = '';
    leleFishStock.value = '';
    leleFishWeigth.value = '';

    masFishSize.value = '';
    masFishStock.value = '';
    masFishWeigth.value = '';

    patinFishSize.value = '';
    patinFishStock.value = '';
    patinFishWeigth.value = '';

    nilaHitamFishSize.value = '';
    nilaHitamFishStock.value = '';
    nilaHitamFishWeigth.value = '';

    nilaMerahFishSize.value = '';
    nilaMerahFishStock.value = '';
    nilaMerahFishWeigth.value = '';

    fishName.value = '';
    fishPriceTotal.clear();
    fishAmount.clear();
    fishWeight.clear();
    fishPrice.clear();
  }

  String dateFormat(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    var formatter = DateFormat('EEEE, d MMMM y | HH:mm', 'id');
    var formattedDate = formatter.format(dateTime);
    return formattedDate.split('|').join('| Jam');
  }

  setSheetVariableEdit(bool status) {
    if (status) {
      isSheetEditable.value = true;

      fishAmountEdit.value = true;
      fishWeightEdit.value = true;
      fishPriceEdit.value = true;
      fishPriceTotalEdit.value = true;
    } else {
      isSheetEditable.value = false;

      fishAmountEdit.value = false;
      fishWeightEdit.value = false;
      fishPriceEdit.value = false;
      fishPriceTotalEdit.value = false;
    }
  }
}

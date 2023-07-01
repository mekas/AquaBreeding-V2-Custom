import 'dart:convert';
import 'dart:developer';

import 'package:fish/core/baseUrl.dart';
import 'package:fish/models/inventaris/benih/detail_inventaris_benih_model.dart';
import 'package:fish/models/inventaris/benih/inventaris_benih_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InventarisBenihState extends BaseURL {
  RxString pageIdentifier = 'benih'.obs;

  RxBool isLoadingPage = false.obs;
  RxBool isLoadingPost = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool isLoadingDetail = false.obs;

  final List listLele = [];
  RxMap<String, dynamic> selectedLele = <String, dynamic>{}.obs;
  RxBool isLoadingLeleDetail = false.obs;
  RxString leleFishWeigth = ''.obs;
  RxString leleFishSize = ''.obs;
  RxString leleFishStock = ''.obs;
  RxString leleID = ''.obs;

  final List listNilaHitam = [];
  RxMap<String, dynamic> selectedNilaHitam = <String, dynamic>{}.obs;
  RxBool isLoadingNilaHitamDetail = false.obs;
  RxString nilaHitamFishWeigth = ''.obs;
  RxString nilaHitamFishSize = ''.obs;
  RxString nilaHitamFishStock = ''.obs;
  RxString nilaHitamID = ''.obs;

  final List listNilaMerah = [];
  RxMap<String, dynamic> selectedNilaMerah = <String, dynamic>{}.obs;
  RxBool isLoadingNilaMerahDetail = false.obs;
  RxString nilaMerahFishWeigth = ''.obs;
  RxString nilaMerahFishSize = ''.obs;
  RxString nilaMerahFishStock = ''.obs;
  RxString nilaMerahID = ''.obs;

  final List listPatin = [];
  RxMap<String, dynamic> selectedPatin = <String, dynamic>{}.obs;
  RxBool isLoadingPatinDetail = false.obs;
  RxString patinFishWeigth = ''.obs;
  RxString patinFishSize = ''.obs;
  RxString patinFishStock = ''.obs;
  RxString patinID = ''.obs;

  final List listMas = [];
  RxMap<String, dynamic> selectedMas = <String, dynamic>{}.obs;
  RxBool isLoadingMasDetail = false.obs;
  RxString masFishWeigth = ''.obs;
  RxString masFishSize = ''.obs;
  RxString masFishStock = ''.obs;
  RxString masID = ''.obs;

  RxBool switchValue = false.obs;

  var seedList = InventarisBenihModel(data: []).obs;

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
  TextEditingController fishName = TextEditingController();
  TextEditingController fishAmount = TextEditingController();
  TextEditingController fishWeight = TextEditingController();
  TextEditingController fishPrice = TextEditingController();
  RxString fishImage =
      'https://www.hepper.com/wp-content/uploads/2022/09/red-male-betta-fish-in-aquarium_Grigorii-Pisotscki-Shutterstock.jpg'
          .obs;

  Future getAllSeedData(String type) async {
    seedList.value.data!.clear();
    isLoadingPage.value = true;
    final response =
        await http.get(Uri.parse('$baseUrl/inventory/seed?type=$type'));

    try {
      if (response.statusCode == 200) {
        InventarisBenihModel res =
            InventarisBenihModel.fromJson(jsonDecode(response.body));

        seedList.value = res;

        for (var i in seedList.value.data!) {
          if (i.fishType == 'Lele') {
            listMas.clear();
            listNilaHitam.clear();
            listNilaMerah.clear();
            listPatin.clear();

            listLele.add({
              'id': i.idInt,
              'fishName': i.brandName,
            });

            selectedLele.value = listLele[0];
          }
          if (i.fishType == 'Nila Hitam') {
            listLele.clear();
            listNilaMerah.clear();
            listPatin.clear();
            listMas.clear();
            listNilaHitam.add({
              'id': i.idInt,
              'fishName': i.brandName,
            });
          }
          if (i.fishType == 'Nila Merah') {
            listNilaHitam.clear();
            listLele.clear();
            listMas.clear();
            listPatin.clear();
            listNilaMerah.add({
              'id': i.idInt,
              'fishName': i.brandName,
            });
          }
          if (i.fishType == 'Patin') {
            listMas.clear();
            listLele.clear();
            listNilaHitam.clear();
            listNilaMerah.clear();
            listPatin.add({
              'id': i.idInt,
              'fishName': i.brandName,
            });
          }
          if (i.fishType == 'Mas') {
            listLele.clear();
            listNilaHitam.clear();
            listNilaMerah.clear();
            listPatin.clear();
            listMas.add({
              'id': i.idInt,
              'fishName': i.brandName,
            });
          }
        }
      }
      // inspect(listLele);
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPage.value = false;
  }

  Future getSeedDataByID(int id, Function() doAfter) async {
    isLoadingDetail.value = true;

    isLoadingLeleDetail.value = true;

    final response = await http.get(Uri.parse('$baseUrl/inventory/seed/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisBenihModel res =
            DetailInventarisBenihModel.fromJson(jsonDecode(response.body));

        if (res.data!.fishType == 'Lele') {
          leleFishWeigth.value = res.data!.weight.toString() == '0'
              ? '-'
              : res.data!.weight.toString();
          leleFishSize.value = res.data!.width.toString() == ''
              ? '-'
              : res.data!.width.toString();
          leleFishStock.value = res.data!.amount.toString();
          leleID.value = res.data!.sId.toString();
          isLoadingLeleDetail.value = false;
        }

        seedCategory.value = res.data!.fishSeedCategory.toString();
        fishCategory.value = res.data!.fishType.toString();
        sortSize.value = res.data!.width.toString();
        fishName.text = res.data!.brandName.toString();
        fishAmount.text = res.data!.amount.toString();
        fishWeight.text = res.data!.weight.toString();
        fishPrice.text = res.data!.price.toString();
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
    map['brand_name'] = fishName.text;
    map['amount'] = fishAmount.text == '' ? '0' : fishAmount.text;
    map['weight'] = fishWeight.text == '' ? '0' : fishWeight.text;
    map['width'] = seedCategory.value == 'Benih' ? sortSize.value : "";
    map['price'] = fishPrice.text == '' ? '0' : fishPrice.text;
    map['image'] = fishImage.value;

    isLoadingPost.value = true;

    try {
      await http.post(
        Uri.parse('$baseUrl/inventory/seed'),
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
    map['brand_name'] = fishName.text;
    map['amount'] = fishAmount.text == '' ? '0' : fishAmount.text;
    map['weight'] = fishWeight.text == '' ? '0' : fishWeight.text;
    map['width'] = seedCategory.value == 'Benih' ? sortSize.value : "";
    map['price'] = fishPrice.text == '' ? '0' : fishPrice.text;
    map['image'] = fishImage.value;

    isLoadingPost.value = true;

    try {
      inspect(map);
      await http.put(
        Uri.parse('$baseUrl/inventory/seed/$id'),
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
          '$baseUrl/inventory/seed/$id',
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

  resetVariables() {
    fishName.clear();
    fishAmount.clear();
    fishWeight.clear();
    fishPrice.clear();
  }
}

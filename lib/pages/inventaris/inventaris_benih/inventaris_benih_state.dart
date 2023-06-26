import 'dart:convert';
import 'dart:developer';

import 'package:fish/models/inventaris/benih/detail_inventaris_benih_model.dart';
import 'package:fish/models/inventaris/benih/inventaris_benih_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InventarisBenihState {
  String url = 'https://e2ef-103-136-58-71.ap.ngrok.io/api';

  RxString pageIdentifier = 'benih'.obs;

  RxBool isLoadingPage = false.obs;
  RxBool isLoadingPost = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool isLoadingDetail = false.obs;

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
    '1 - 2 cm',
    '2 - 3 cm',
    '3 - 4 cm',
    '4 - 5 cm',
    '5 - 6 cm',
    '6 - 7 cm',
    '7 - 8 cm',
    '8 - 9 cm',
    '9 - 10 cm',
    '10 - 11 cm',
    '11 - 12 cm',
    '12 - 13 cm',
  ];

  RxString seedCategory = 'Benih'.obs;
  RxString fishCategory = 'Lele'.obs;
  RxString sortSize = '1 - 2 cm'.obs;
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
        await http.get(Uri.parse('$url/inventory/seed?type=$type'));

    try {
      if (response.statusCode == 200) {
        InventarisBenihModel res =
            InventarisBenihModel.fromJson(jsonDecode(response.body));

        seedList.value = res;
        inspect(seedList.value.data);
      }
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPage.value = false;
  }

  Future getSeedDataByID(int id, Function() doAfter) async {
    isLoadingDetail.value = true;

    final response = await http.get(Uri.parse('$url/inventory/seed/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisBenihModel res =
            DetailInventarisBenihModel.fromJson(jsonDecode(response.body));

        seedCategory.value = res.data!.fishSeedCategory!;
        fishCategory.value = res.data!.fishType!;
        sortSize.value = res.data!.width!;
        fishName.text = res.data!.brandName!;
        fishAmount.text = res.data!.amount.toString();
        fishWeight.text = res.data!.weight.toString();
        fishPrice.text = res.data!.price.toString();
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
        Uri.parse('$url/inventory/seed'),
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
        Uri.parse('$url/inventory/seed/$id'),
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
          '$url/inventory/seed/$id',
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

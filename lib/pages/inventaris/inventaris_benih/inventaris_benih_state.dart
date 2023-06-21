import 'dart:convert';
import 'dart:developer';

import 'package:fish/models/inventaris/benih/inventaris_benih_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InventarisBenihState {
  String url = 'https://ba22-182-3-52-243.ap.ngrok.io/api';

  RxBool isLoadingPage = false.obs;
  RxBool isLoadingPost = false.obs;

  var seedList = InventarisBenihModel(data: []).obs;

  RxString seedCategory = 'Benih'.obs;
  RxString fishCategory = 'Lele'.obs;
  TextEditingController fishName = TextEditingController();
  TextEditingController fishAmount = TextEditingController();
  RxString sortSize = ''.obs;
  TextEditingController fishWeight = TextEditingController();
  TextEditingController fishPrice = TextEditingController();
  RxString fishImage =
      'https://www.hepper.com/wp-content/uploads/2022/09/red-male-betta-fish-in-aquarium_Grigorii-Pisotscki-Shutterstock.jpg'
          .obs;

  Future getAllSeedData(String type) async {
    seedList.value.data!.clear();
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
      const SnackBar(
        content: Text(
          'Failed to load',
        ),
      );
    }
  }

  Future getSeedDataByID(int id) async {}

  Future postSeedData(Function() doAfter) async {
    var map = <String, dynamic>{};

    map['fish_seed_category'] = seedCategory.value;
    map['fish_type'] = fishCategory.value;
    map['brand_name'] = fishName.text;
    map['amount'] = fishAmount.text == '' ? '0' : fishAmount.text;
    map['weight'] = fishWeight.text == '' ? '0' : fishWeight.text;
    map['width'] = sortSize.value;
    map['price'] = fishPrice.text == '' ? '0' : fishPrice.text;
    map['image'] = fishImage.value;

    try {
      isLoadingPost.value = true;
      inspect(map);
      await http.post(
        Uri.parse('$url/inventory/seed'),
        body: map,
      );
      isLoadingPost.value = false;
    } catch (e) {
      const SnackBar(
        content: Text(
          'Failed to post',
        ),
      );
    }
    doAfter();
  }

  Future updateSeedData(int id) async {}

  Future deleteSeedData(int id) async {}

  resetVariables() {
    fishName.clear();
    fishAmount.clear();
    sortSize.value = '';
    fishWeight.clear();
    fishPrice.clear();
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:fish/models/inventaris/benih/inventaris_benih_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InventarisBenihState {
  String url = 'https://ba16-110-138-92-153.ap.ngrok.io/api';

  RxString selectedDropdown = 'Kelas Benih'.obs;
  RxString selectedDropdown2 = ''.obs;
  RxString selectedDropdown3 = ''.obs;
  RxString selectedPage = 'Kelas Benih'.obs;
  RxBool isLoadingPage = false.obs;

  var seedList = InventarisBenihModel(data: []).obs;

  RxList dummyDataValue = [
    {
      'year': 2023,
      'fish_type': 'lele',
      'amount': 90,
      'weight': 800,
    },
    {
      'year': 2023,
      'fish_type': 'lele',
      'amount': 90,
      'weight': 800,
    },
    {
      'year': 2023,
      'fish_type': 'lele',
      'amount': 90,
      'weight': 800,
    },
    {
      'year': 2023,
      'fish_type': 'lele',
      'amount': 90,
      'weight': 800,
    }
  ].obs;

  RxList dummyDataValue4 = [
    {
      'year': 2023,
      'fish_type': 'lele',
      'sortir': '1-2',
      'weight': 800,
    },
    {
      'year': 2023,
      'fish_type': 'lele',
      'sortir': '1-2',
      'weight': 800,
    },
    {
      'year': 2023,
      'fish_type': 'lele',
      'sortir': '1-2',
      'weight': 800,
    },
    {
      'year': 2023,
      'fish_type': 'lele',
      'sortir': '1-2',
      'weight': 800,
    }
  ].obs;

  RxList dummyDataValue2 = [
    {
      'date_input': '22-02-2022',
      'amount': 10,
      'weight': 400,
      'price': 50000,
      'category': 'Kelas Benih',
      'fish_type': 'Lele',
      'sortir': '1-2',
      'panjang': null,
      'lebar': null,
    },
    {
      'date_input': '22-02-2022',
      'amount': 10,
      'weight': 400,
      'price': 50000,
      'category': 'Kelas Benih',
      'fish_type': 'Lele',
      'sortir': '1-2',
      'panjang': null,
      'lebar': null,
    },
  ].obs;

  RxList dummyDataValue3 = [
    {
      'date_input': '22-02-2022',
      'amount': 10,
      'weight': 400,
      'price': 50000,
      'category': 'Kelas Pembesaran',
      'fish_type': 'Lele',
      'sortir': null,
      'panjang': 10,
      'lebar': 10,
    },
    {
      'date_input': '22-02-2022',
      'amount': 10,
      'weight': 400,
      'price': 50000,
      'category': 'Kelas Pembesaran',
      'fish_type': 'Lele',
      'sortir': null,
      'panjang': 10,
      'lebar': 10,
    },
    {
      'date_input': '22-02-2022',
      'amount': 10,
      'weight': 400,
      'price': 50000,
      'category': 'Kelas Pembesaran',
      'fish_type': 'Lele',
      'sortir': null,
      'panjang': 10,
      'lebar': 10,
    },
  ].obs;

  Future getAllSeedData(String type) async {
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
      throw Exception('Failed to load');
    }
  }

  Future getSeedDataByID(int id) async {}

  Future postSeedData() async {}

  Future updateSeedData(int id) async {}

  Future deleteSeedData(int id) async {}
}

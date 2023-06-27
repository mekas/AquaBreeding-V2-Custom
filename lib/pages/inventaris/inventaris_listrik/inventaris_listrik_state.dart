import 'dart:convert';
import 'dart:developer';

import 'package:fish/core/baseUrl.dart';
import 'package:fish/models/inventaris/listrik/detail_inventaris_listrik_model.dart';
import 'package:fish/models/inventaris/listrik/inventaris_listrik_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InventarisListrikState extends BaseURL {
  RxBool isLoadingPage = false.obs;
  RxBool isLoadingPost = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool isLoadingDetail = false.obs;

  var electricList = InventarisListrikModel(data: []).obs;

  RxString pageIdentifier = 'prabayar'.obs;
  DateTime thisYear = DateTime(2023);

  var dropdownList = [
    'Prabayar',
    'Pascabayar',
  ];

  RxString electricCategory = 'Prabayar'.obs;
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController power = TextEditingController();
  RxString image =
      "https://media.istockphoto.com/id/1183169839/vector/lightning-isolated-vector-icon-electric-bolt-flash-icon-power-energy-symbol-thunder-icon.jpg?s=612x612&w=0&k=20&c=kFdwoQHmrv8EzCofbdzL7EVW8vtgiHvhrGkOl0_N0io="
          .obs;

  Future getAllData(int year, String type, Function() doAfter) async {
    electricList.value.data!.clear();
    isLoadingPage.value = true;
    final response = await http
        .get(Uri.parse('$baseUrl/inventory/electric?year=$year&type=$type'));

    try {
      if (response.statusCode == 200) {
        InventarisListrikModel res =
            InventarisListrikModel.fromJson(jsonDecode(response.body));

        electricList.value = res;
        inspect(electricList.value.data);
        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPage.value = false;
  }

  Future getDataByID(int id, Function() doAfter) async {
    isLoadingDetail.value = true;

    final response =
        await http.get(Uri.parse('$baseUrl/inventory/electric/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisListrikModel res =
            DetailInventarisListrikModel.fromJson(jsonDecode(response.body));

        electricCategory.value = res.data!.type.toString();
        name.text = res.data!.name.toString();
        power.text = res.data!.daya.toString();
        price.text = res.data!.price.toString();
        image.value = res.data!.image.toString();
      }
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingDetail.value = false;
  }

  Future postData(Function() doAfter) async {
    var map = <String, dynamic>{};

    map['name'] = name.text;
    map['type'] = electricCategory.value;
    map['price'] = price.text;
    map['daya'] = power.text;
    map['image'] = image.value;

    isLoadingPost.value = true;

    try {
      await http.post(
        Uri.parse('$baseUrl/inventory/electric'),
        body: map,
      );
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPost.value = false;
  }

  Future updateData(int id, Function() doAfter) async {
    var map = <String, dynamic>{};

    map['name'] = name.text;
    map['type'] = electricCategory.value;
    map['price'] = price.text;
    map['daya'] = power.text;
    map['image'] = image.value;

    isLoadingPost.value = true;

    try {
      inspect(map);
      await http.put(
        Uri.parse('$baseUrl/inventory/electric/$id'),
        body: map,
      );
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPost.value = false;
  }

  Future deleteData(int id, Function() doAfter) async {
    isLoadingDelete.value = true;
    try {
      await http.delete(
        Uri.parse(
          '$baseUrl/inventory/electric/$id',
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
    name.clear();
    price.clear();
    power.clear();
  }
}

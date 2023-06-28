import 'dart:convert';
import 'dart:developer';

import 'package:fish/core/baseUrl.dart';
import 'package:fish/models/inventaris/aset/detail_inventaris_asset_model.dart';
import 'package:fish/models/inventaris/aset/inventaris_asset_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InventarisAsetState extends BaseURL {
  RxBool isLoadingPage = false.obs;
  RxBool isLoadingPost = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool isLoadingDetail = false.obs;

  var assetList = InventarisAssetModel(data: []).obs;

  RxList filterList = [
    {'title_id': 1, 'title': 'Alat Budidaya', 'key': 'alat'},
    {'title_id': 2, 'title': 'Perlengkapan Habis Pakai', 'key': 'pakai'},
    {'title_id': 3, 'title': 'Infrastruktur', 'key': 'infrastruktur'},
    {'title_id': 4, 'title': 'Aset Lainnya', 'key': 'lain'},
  ].obs;

  RxString pageIdentifier = 'Alat Budidaya'.obs;
  RxInt currIndexFilter = 1.obs;

  var dropdownList = [
    'Alat Budidaya',
    'Perlengkapan Habis Pakai',
    'Infrastruktur',
    'Aset Lainnya'
  ];

  RxString assetCategory = 'Alat Budidaya'.obs;
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController price = TextEditingController();
  RxString image =
      'https://lh3.googleusercontent.com/p/AF1QipPgPgQ17AeKRLeQWWb3sZYRtkyoJndsRMKE8rNc=w1080-h608-p-no-v0'
          .obs;

  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();

  Future getAllData(String type, String firstDate, String lastDate,
      Function() doAfter) async {
    assetList.value.data!.clear();
    isLoadingPage.value = true;
    final response = await http.get(Uri.parse(
        '$baseUrl/inventory/asset?type=$type&start_date=$firstDate&end_date=$lastDate'));

    try {
      if (response.statusCode == 200) {
        InventarisAssetModel res =
            InventarisAssetModel.fromJson(jsonDecode(response.body));

        assetList.value = res;
        inspect(assetList.value.data);

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPage.value = false;
  }

  Future getDataByID(int id, Function() doAfter) async {
    isLoadingDetail.value = true;

    final response = await http.get(Uri.parse('$baseUrl/inventory/asset/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisAssetModel res =
            DetailInventarisAssetModel.fromJson(jsonDecode(response.body));

        assetCategory.value = res.data!.assetCategory!.toString();
        name.text = res.data!.name.toString();
        desc.text = res.data!.description.toString();
        price.text = res.data!.price.toString();
        amount.text = res.data!.amount.toString();
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

    map['asset_category'] = assetCategory.value;
    map['name'] = name.text;
    map['description'] = desc.text;
    map['price'] = price.text;
    map['amount'] = amount.text;
    map['image'] = image.value;

    isLoadingPost.value = true;

    try {
      final res = await http.post(
        Uri.parse('$baseUrl/inventory/asset'),
        body: map,
      );
      inspect(res);
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPost.value = false;
  }

  Future updateData(int id, Function() doAfter) async {
    var map = <String, dynamic>{};

    map['asset_category'] = assetCategory.value;
    map['name'] = name.text;
    map['description'] = desc.text;
    map['price'] = price.text;
    map['amount'] = amount.text;
    map['image'] = image.value;

    isLoadingPost.value = true;

    try {
      inspect(map);
      final res = await http.put(
        Uri.parse('$baseUrl/inventory/asset/$id'),
        body: map,
      );
      inspect(res);
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
          '$baseUrl/inventory/asset/$id',
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
    desc.clear();
    price.clear();
    amount.clear();
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:fish/controllers/authentication/profile_controller.dart';
import 'package:fish/models/inventaris/aset/detail_inventaris_asset_model.dart';
import 'package:fish/models/inventaris/aset/inventaris_asset_model.dart';
import 'package:fish/service/url_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InventarisAsetState extends Urls {
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

  RxBool nameEdit = false.obs;
  RxBool descEdit = false.obs;
  RxBool amountEdit = false.obs;
  RxBool priceEdit = false.obs;
  RxBool isSheetEditable = false.obs;

  final ProfileController profControl = Get.put(ProfileController());

  Future getAllData(
      String type, String first, String last, Function() doAfter) async {
    assetList.value.data!.clear();
    isLoadingPage.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
      Uri.parse('${Urls.invAsset}?type=$type&start_date=$first&end_date=$last'),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        InventarisAssetModel res =
            InventarisAssetModel.fromJson(jsonDecode(response.body));

        assetList.value = res;

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPage.value = false;
  }

  Future getDataByID(int id, Function() doAfter) async {
    isLoadingDetail.value = true;

    final response = await http.get(Uri.parse('${Urls.invAsset}/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisAssetModel res =
            DetailInventarisAssetModel.fromJson(jsonDecode(response.body));

        assetCategory.value = res.data!.assetCategory!.toString();
        name.text = res.data!.name.toString();
        desc.text = res.data!.description.toString() == ''
            ? '-'
            : res.data!.description.toString();
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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};
    map['asset_category'] = assetCategory.value;
    map['name'] = name.text;
    map['description'] = desc.text;
    map['price'] = price.text;
    map['amount'] = amount.text;
    map['image'] = image.value;

    isLoadingPost.value = true;

    try {
      final res = await http.post(
        Uri.parse(Urls.invAsset),
        body: map,
        headers: headers,
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
    map['description'] = desc.text == '' ? '-' : desc.text;
    map['price'] = price.text;
    map['amount'] = amount.text;
    map['image'] = image.value;

    isLoadingPost.value = true;

    try {
      // inspect(map);
      final res = await http.put(
        Uri.parse('${Urls.invAsset}/$id'),
        body: map,
      );
      // inspect(res);
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
          '${Urls.invAsset}/$id',
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

  String dateFormat(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    var formatter = DateFormat('EEEE, d MMMM y | HH:mm', 'id');
    var formattedDate = formatter.format(dateTime);
    return formattedDate.split('|').join('| Jam');
  }

  String findDateRange(DateTime currDate, String date) {
    DateTime dateTime = DateTime.parse(date);

    final diff = currDate.difference(dateTime);

    if ((diff.inDays / 30).round() < 1) {
      return '${diff.inDays < 0 ? 0 : diff.inDays} hari';
    } else {
      return '${(diff.inDays / 30).round()} bulan';
    }
  }

  resetVariables() {
    name.clear();
    desc.clear();
    price.clear();
    amount.clear();
    firstDate.clear();
    lastDate.clear();
  }

  setSheetVariableEdit(bool status) {
    if (status) {
      isSheetEditable.value = true;

      nameEdit.value = true;
      descEdit.value = true;
      amountEdit.value = true;
      priceEdit.value = true;
    } else {
      isSheetEditable.value = false;

      nameEdit.value = false;
      descEdit.value = false;
      amountEdit.value = false;
      priceEdit.value = false;
    }
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:fish/models/inventaris/listrik/detail_inventaris_listrik_model.dart';
import 'package:fish/models/inventaris/listrik/inventaris_listrik_model.dart';
import 'package:fish/service/url_api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InventarisListrikState extends Urls {
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
  TextEditingController idToken = TextEditingController();
  TextEditingController monthPicked = TextEditingController();
  RxString image =
      "https://media.istockphoto.com/id/1183169839/vector/lightning-isolated-vector-icon-electric-bolt-flash-icon-power-energy-symbol-thunder-icon.jpg?s=612x612&w=0&k=20&c=kFdwoQHmrv8EzCofbdzL7EVW8vtgiHvhrGkOl0_N0io="
          .obs;

  RxBool isSheetEditable = false.obs;
  RxBool nameEdit = false.obs;
  RxBool priceEdit = false.obs;
  RxBool powerEdit = false.obs;
  RxBool idTokenEdit = false.obs;
  RxBool monthPickedEdit = false.obs;

  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();

  Future getAllData(
      String first, String last, String type, Function() doAfter) async {
    electricList.value.data!.clear();
    isLoadingPage.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
        Uri.parse('${Urls.invElect}?type=$type&first=$first&last=$last'),
        headers: headers);

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

    final response = await http.get(Uri.parse('${Urls.invElect}/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisListrikModel res =
            DetailInventarisListrikModel.fromJson(jsonDecode(response.body));

        electricCategory.value = res.data!.type.toString();
        name.text = res.data!.name.toString();
        power.text = res.data!.daya.toString();
        price.text = res.data!.price.toString();
        idToken.text = res.data!.idToken.toString();
        monthPicked.text = res.data!.month.toString();
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

    map['name'] = name.text;
    map['type'] = electricCategory.value;
    map['price'] = price.text;
    map['daya'] = power.text;
    map['image'] = image.value;
    map['id_token'] = idToken.text;
    map['month'] = monthPicked.text;

    isLoadingPost.value = true;

    try {
      await http.post(
        Uri.parse(Urls.invElect),
        body: map,
        headers: headers,
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
    map['id_token'] = idToken.text;
    map['month'] = monthPicked.text;

    isLoadingPost.value = true;

    try {
      inspect(map);
      await http.put(
        Uri.parse('${Urls.invElect}/$id'),
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
          '${Urls.invElect}/$id',
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

  resetVariables() {
    name.clear();
    price.clear();
    power.clear();
    idToken.clear();
    monthPicked.clear();
  }

  setSheetVariableEdit(bool status) {
    if (status) {
      isSheetEditable.value = true;

      nameEdit.value = true;
      priceEdit.value = true;
      powerEdit.value = true;
      idTokenEdit.value = true;
      monthPickedEdit.value = true;
    } else {
      isSheetEditable.value = false;

      nameEdit.value = false;
      priceEdit.value = false;
      powerEdit.value = false;
      idTokenEdit.value = false;
      monthPickedEdit.value = false;
    }
  }
}

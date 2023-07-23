import 'dart:convert';
import 'dart:developer';

import 'package:fish/models/history/history_suplemen_model.dart';
import 'package:fish/models/inventaris/suplemen/detail_inventaris_suplemen_model.dart';
import 'package:fish/models/inventaris/suplemen/inventaris_suplemen_model.dart';
import 'package:fish/models/inventaris/suplemen/inventaris_suplemen_name_model.dart';
import 'package:fish/service/url_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class InventarisBahanBudidayaState extends Urls {
  RxBool isLoadingPage = false.obs;
  RxBool isLoadingPost = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool isLoadingDetail = false.obs;
  RxBool isLoadingHistory = false.obs;

  var suplemenList = InventarisSuplemenModel(data: []).obs;
  var suplemenHistoryList = HistorySuplemenModel(data: []).obs;
  var suplemenNameList = InventarisSuplemenNameModel(data: []).obs;

  RxList filterList = [
    {'title_id': 1, 'title': 'Obat', 'key': 'obat'},
    {'title_id': 2, 'title': 'Perawatan Air', 'key': 'perawatan'},
    {'title_id': 3, 'title': 'Probiotik', 'key': 'probiotik'},
    {'title_id': 4, 'title': 'Feed Additive', 'key': 'feed'},
  ].obs;

  RxString pageIdentifier = 'Obat'.obs;
  RxInt currIndexFilter = 1.obs;

  var dropdownList = [
    'Obat',
    'Perawatan Air',
    'Probiotik',
    'Feed Additive',
  ];

  var dropdownList2 = [
    'kg',
    'ltr',
    'pack',
  ];

  RxString functionCategory = 'Perawatan Air'.obs;
  RxString typeCategory = 'kg'.obs;
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController minExp = TextEditingController();
  TextEditingController maxExp = TextEditingController();
  RxString image =
      'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/06/28062837/vector_5.kesehatan-vitamin-dan-suplemen.jpg'
          .obs;

  RxBool descSwitchValue = false.obs;
  RxBool minSwitchValue = false.obs;
  RxBool maxSwitchValue = false.obs;

  RxBool nameEdit = false.obs;
  RxBool descEdit = false.obs;
  RxBool priceEdit = false.obs;
  RxBool amountEdit = false.obs;
  RxBool minExpEdit = false.obs;
  RxBool maxExpEdit = false.obs;

  RxString pondName = ''.obs;

  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();

  final List listSuplemenName = [];
  TextEditingController suplemenName = TextEditingController();
  RxMap<String, dynamic> selectedSuplemen = <String, dynamic>{}.obs;
  RxBool isSuplemenSelected = false.obs;

  RxBool isSheetEditable = false.obs;
  RxBool isReversed = false.obs;

  Future getAllData(String type, Function() doAfter) async {
    suplemenList.value.data!.clear();
    isLoadingPage.value = true;
    final response = await http.get(Uri.parse('${Urls.invSup}?type=$type'));

    try {
      if (response.statusCode == 200) {
        InventarisSuplemenModel res =
            InventarisSuplemenModel.fromJson(jsonDecode(response.body));

        suplemenList.value = res;
        inspect(suplemenList.value.data);

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPage.value = false;
  }

  Future getDataByID(int id, Function() doAfter) async {
    isLoadingDetail.value = true;

    final response = await http.get(Uri.parse('${Urls.invSup}/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisSuplemenModel res =
            DetailInventarisSuplemenModel.fromJson(jsonDecode(response.body));

        // for (var i in listSuplemenName) {
        //   if (i['suplemen_name_id'] == res.data.fee)
        // }

        functionCategory.value = res.data!.function!.toString();

        for (var i in listSuplemenName) {
          if (i['suplemen_name_id'] == res.data!.suplemenNameId) {
            selectedSuplemen.value = i;
          }
        }

        desc.text = res.data!.description.toString();
        price.text = res.data!.price.toString();
        amount.text = res.data!.amount!.toStringAsFixed(2);
        typeCategory.value = res.data!.type.toString();
        minExp.text = res.data!.minExpiredPeriod.toString();
        maxExp.text = res.data!.maxExpiredPeriod.toString();
        image.value = res.data!.image.toString();
      }
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingDetail.value = false;
  }

  String amountChecker(String text) {
    var textList = text.split('');

    for (var i = 0; i < textList.length; i++) {
      if (textList[i] == ',') {
        textList[i] = '.';
      }
    }

    return textList.join('');
  }

  Future postData(Function() doAfter) async {
    var map = <String, dynamic>{};

    map['suplemen_name_id'] = selectedSuplemen.value['suplemen_name_id'];
    map['function'] = functionCategory.value;
    map['name'] = selectedSuplemen.value['suplemen_name'];
    map['description'] = desc.text == '' ? '-' : desc.text;
    map['price'] = price.text;
    map['amount'] = amount.text.replaceAll(',', '.');
    map['type'] = typeCategory.value;
    map['min_expired_period'] = minExp.text == '' ? '0' : minExp.text;
    map['max_expired_period'] = maxExp.text == ''
        ? (int.parse(minExp.text == '' ? '0' : minExp.text) * 2).toString()
        : maxExp.text;
    map['image'] = image.value;

    isLoadingPost.value = true;

    inspect(map);

    try {
      await http.post(
        Uri.parse(Urls.invSup),
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

    inspect(id);

    map['suplemen_name_id'] = selectedSuplemen.value['suplemen_name_id'];
    map['function'] = functionCategory.value;
    map['name'] = selectedSuplemen.value['suplemen_name'];
    map['description'] = desc.text == '' ? '-' : desc.text;
    map['price'] = price.text;
    map['amount'] = amount.text.replaceAll(',', '.');
    map['type'] = typeCategory.value;
    map['min_expired_period'] = minExp.text == '' ? '0' : minExp.text;
    map['max_expired_period'] = maxExp.text == ''
        ? (int.parse(minExp.text == '' ? '0' : minExp.text) * 2).toString()
        : maxExp.text;
    map['image'] = image.value;

    isLoadingPost.value = true;

    try {
      inspect(map);
      final res = await http.put(
        Uri.parse('${Urls.invSup}/$id'),
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
          '${Urls.invSup}/$id',
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

  Future postHistorySuplemenData(
      String pondName, List suplemen, Function() doAfter) async {
    var map = <String, dynamic>{};

    map['pond'] = pondName;

    // print('HEHE');

    for (var i = 0; i < suplemen.length; i++) {
      map['fish_suplemen_id'] = suplemen[i]['suplemen_id'];
      map['original_amount'] = suplemen[i]['original_value'];
      map['usage'] = suplemen[i]['amount'];

      try {
        await http.post(
          Uri.parse(Urls.suplemenSch),
          body: map,
        );
        doAfter();
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  Future getHistorySuplemenData(bool isReversed, String firstDate,
      String lastDate, Function() doAfter) async {
    suplemenHistoryList.value.data!.clear();
    isLoadingHistory.value = true;

    final response = await http.get(Uri.parse(
        '${Urls.suplemenSch}?start_date=$firstDate&end_date=$lastDate'));

    try {
      if (response.statusCode == 200) {
        HistorySuplemenModel res =
            HistorySuplemenModel.fromJson(jsonDecode(response.body));

        if (isReversed) {
          var temp = res;
          suplemenHistoryList.value.data = temp.data!.reversed.toList();
        } else {
          var temp = res;
          suplemenHistoryList.value.data = temp.data!;
        }

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }
    isLoadingHistory.value = false;
  }

  Future getSuplemenNameData(String type) async {
    suplemenNameList.value.data!.clear();
    listSuplemenName.clear();
    isLoadingDetail.value = true;

    final response =
        await http.get(Uri.parse('${Urls.suplemenNameList}?type=$type'));

    try {
      if (response.statusCode == 200) {
        InventarisSuplemenNameModel res =
            InventarisSuplemenNameModel.fromJson(jsonDecode(response.body));

        suplemenNameList.value = res;

        for (var i in suplemenNameList.value.data!) {
          listSuplemenName.add({
            'id': i.idInt,
            'suplemen_name_id': i.sId,
            'suplemen_name': i.name,
          });

          selectedSuplemen.value = listSuplemenName[0];
        }

        inspect(suplemenNameList.value);
      }
    } catch (e) {
      throw Exception(e);
    }
    isLoadingDetail.value = false;
  }

  Future postSuplemenNameData(Function() doAfter) async {
    isLoadingPost.value = true;
    var map = <String, dynamic>{};

    map['type'] = functionCategory.value;
    map['name'] = suplemenName.text;

    try {
      await http.post(
        Uri.parse(Urls.suplemenNameList),
        body: map,
      );
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPost.value = false;
  }

  Future deleteSuplemenName(int id, Function() doAfter) async {
    isLoadingDelete.value = true;
    try {
      await http.delete(
        Uri.parse(
          '${Urls.suplemenNameList}/$id',
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
    desc.clear();
    price.clear();
    amount.clear();
    minExp.clear();
    maxExp.clear();
  }

  convertDaysToDate(DateTime time, int days) {
    DateTime newTime = time.add(Duration(days: days));
    return newTime.toString().split(' ')[0].split('-').reversed.join('-');
  }

  setSheetVariableEdit(bool status) {
    if (status) {
      isSheetEditable.value = true;

      nameEdit.value = true;
      descEdit.value = true;
      priceEdit.value = true;
      amountEdit.value = true;
      minExpEdit.value = true;
      maxExpEdit.value = true;
    } else {
      isSheetEditable.value = false;

      nameEdit.value = false;
      descEdit.value = false;
      priceEdit.value = false;
      amountEdit.value = false;
      minExpEdit.value = false;
      maxExpEdit.value = false;
    }
  }
}

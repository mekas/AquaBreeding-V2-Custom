import 'dart:convert';
import 'dart:developer';

import 'package:fish/models/history/history_feed_chart_model.dart';
import 'package:fish/models/history/history_feed_model.dart';
import 'package:fish/models/inventaris/pakan/detail_inventaris_pakan_model.dart';
import 'package:fish/models/inventaris/pakan/detail_inventaris_pakan_name_model.dart';
import 'package:fish/models/inventaris/pakan/inventaris_pakan_model.dart';
import 'package:fish/models/inventaris/pakan/inventaris_pakan_name_model.dart';
import 'package:fish/service/url_api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InventarisPakanState extends Urls {
  RxBool isLoadingPage = false.obs;
  RxBool isLoadingPost = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool isLoadingDetail = false.obs;
  RxBool isLoadingHistory = false.obs;
  RxBool isLoadingChart = false.obs;
  RxBool isLoadingName = false.obs;
  RxBool isLoadingNameDetail = false.obs;

  var feedList = InventarisPakanModel(data: []).obs;
  var feedHistoryList = HistoryFeedModel(data: []).obs;
  var feedChartHistoryList = HistoryFeedChartModel(data: []).obs;
  var feedNameList = InventarisPakanNameModel(data: []).obs;

  RxString pageIdentifier = 'alami'.obs;

  var dropdownList = [
    'Alami',
    'Industri',
    'Custom',
  ];

  RxBool switchValue = false.obs;

  // Pakan Controller
  TextEditingController price = TextEditingController();
  TextEditingController amount = TextEditingController();

  RxBool brandNameEdit = false.obs;
  RxBool priceEdit = false.obs;
  RxBool amountEdit = false.obs;

  // Pakan Name Controller
  RxString feedCategory = 'Alami'.obs;
  TextEditingController category = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController producer = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController protein = TextEditingController();
  TextEditingController carbo = TextEditingController();
  TextEditingController minExp = TextEditingController();
  TextEditingController maxExp = TextEditingController();
  RxString image =
      'https://1.bp.blogspot.com/-9tt1qS0wO-8/X8uLEZd9HGI/AAAAAAAAAnQ/4uGdwluBvYg-cwgjFAf85P_MzITSUos1ACLcBGAsYHQ/s1078/Pakan.png'
          .obs;

  RxBool descSwitchValue = false.obs;
  RxBool proteinSwitchValue = false.obs;
  RxBool carbSwitchValue = false.obs;
  RxBool minSwitchValue = false.obs;
  RxBool maxSwitchValue = false.obs;

  RxBool nameEdit = false.obs;
  RxBool descEdit = false.obs;
  RxBool producerEdit = false.obs;
  RxBool proteinEdit = false.obs;
  RxBool carboEdit = false.obs;
  RxBool minExpEdit = false.obs;
  RxBool maxExpEdit = false.obs;
  RxBool imageEdit = false.obs;

  final List listPakanName = [];
  RxMap<String, dynamic> selectedPakan = <String, dynamic>{}.obs;
  RxBool isPakanSelected = false.obs;

  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();

  RxString selectedFeedType = 'Alami'.obs;
  final List selectedFeedList = [];
  RxMap<String, dynamic> selectedFeedName = <String, dynamic>{}.obs;

  RxBool isLoadingFeedList = false.obs;
  RxBool isLoadingFeedDetail = false.obs;
  RxBool setStatusDetailFeed = false.obs;
  RxBool isSheetEditable = false.obs;

  RxString pondName = ''.obs;
  RxString selectedUsedDate = ''.obs;
  TextEditingController showedUsedDate = TextEditingController();

  RxBool isReversed = false.obs;

  String amountChecker(String text) {
    var textList = text.split('');

    for (var i = 0; i < textList.length; i++) {
      if (textList[i] == ',') {
        textList[i] = '.';
      }
    }

    return textList.join('');
  }

  Future getAllData(String type, Function() doAfter) async {
    feedList.value.data!.clear();
    selectedFeedList.clear();
    isLoadingPage.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
      Uri.parse('${Urls.invFeed}?type=$type'),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        InventarisPakanModel res =
            InventarisPakanModel.fromJson(jsonDecode(response.body));

        feedList.value = res;

        for (var i in feedList.value.data!) {
          selectedFeedList.add({
            'id': i.idInt,
            'feed_id': i.sId,
            'feed_name': i.brandName,
          });

          selectedFeedName.value = selectedFeedList[0];
        }

        inspect(feedList.value.data);

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPage.value = false;
  }

  Future getDataByID(int id, Function() doAfter) async {
    // resetVariables();
    isLoadingDetail.value = true;
    isLoadingFeedDetail.value = true;

    final response = await http.get(Uri.parse('${Urls.invFeed}/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisPakanModel res =
            DetailInventarisPakanModel.fromJson(jsonDecode(response.body));

        feedCategory.value = res.data!.feedCategory!;

        for (var i in listPakanName) {
          if (i['feed_name_id'] == res.data!.feedNameId) {
            selectedPakan.value = i;
          }
        }

        // desc.text = res.data!.description.toString();
        price.text = res.data!.price.toString();
        amount.text = res.data!.amount!.toStringAsFixed(2);
        producer.text = res.data!.feed!.producer.toString();
        protein.text = res.data!.feed!.protein.toString();
        carbo.text = res.data!.feed!.carbohydrate.toString();
        minExp.text = res.data!.feed!.minExpiredPeriod.toString();
        // maxExp.text = res.data!.maxExpiredPeriod.toString();
        // image.value = res.data!.image.toString();
      }
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingDetail.value = false;
    isLoadingFeedDetail.value = false;
  }

  Future postData(Function() doAfter) async {
    var map = <String, dynamic>{};

    map['feed_name_id'] = selectedPakan.value['feed_name_id'];
    map['feed_category'] = feedCategory.value;
    map['brand_name'] = selectedPakan.value['feed_name'];
    map['price'] = price.text;
    map['amount'] = amount.text.replaceAll(',', '.');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    isLoadingPost.value = true;

    inspect(map);

    try {
      await http.post(
        Uri.parse(Urls.invFeed),
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

    map['feed_name_id'] = selectedPakan.value['feed_name_id'];
    map['feed_category'] = feedCategory.value;
    map['brand_name'] = selectedPakan.value['feed_name'];
    map['price'] = price.text;
    map['amount'] = amount.text.replaceAll(',', '.');

    isLoadingPost.value = true;

    try {
      inspect(map);
      await http.put(
        Uri.parse('${Urls.invFeed}/$id'),
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
          '${Urls.invFeed}/$id',
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

  Future postHistoryFeedData(
    String pondName,
    String feedId,
    String amount,
    String used,
    String usedDate,
    Function() doAfter,
  ) async {
    var map = <String, dynamic>{};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    map['pond'] = pondName;
    map['fish_feed_id'] = feedId;
    map['original_amount'] = amount;
    map['usage'] = used.replaceAll(',', '.');
    map['created_at'] = usedDate;

    inspect(map);

    try {
      final res = await http.post(
        Uri.parse(Urls.feedSch),
        body: map,
        headers: headers,
      );
      if (res.statusCode != 200) {
        inspect(res);
      }
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getHistoryFeedData(bool isReversed, String firstDate, String lastDate,
      Function() doAfter) async {
    feedHistoryList.value.data!.clear();
    isLoadingHistory.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
        Uri.parse('${Urls.feedSch}?start_date=$firstDate&end_date=$lastDate'),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        HistoryFeedModel res =
            HistoryFeedModel.fromJson(jsonDecode(response.body));

        if (isReversed) {
          var temp = res;
          feedHistoryList.value.data = temp.data!.reversed.toList();
        } else {
          var temp = res;
          feedHistoryList.value.data = temp.data!;
        }

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }
    isLoadingHistory.value = false;
  }

  Future getHistoryFeedChartData(String type, Function() doAfter) async {
    feedChartHistoryList.value.data!.clear();
    isLoadingChart.value = true;

    final response = await http.get(Uri.parse(Urls.feedChartHistory(type)));

    try {
      if (response.statusCode == 200) {
        HistoryFeedChartModel res =
            HistoryFeedChartModel.fromJson(jsonDecode(response.body));

        feedChartHistoryList.value = res;

        inspect(feedChartHistoryList.value);

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }
    isLoadingChart.value = false;
  }

  Future getPakanNameData(String type, Function() doAfter) async {
    feedNameList.value.data!.clear();
    listPakanName.clear();
    isLoadingName.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http
        .get(Uri.parse('${Urls.feedNameList}?type=$type'), headers: headers);

    try {
      if (response.statusCode == 200) {
        InventarisPakanNameModel res =
            InventarisPakanNameModel.fromJson(jsonDecode(response.body));

        feedNameList.value = res;

        if (feedNameList.value.data!.isNotEmpty) {
          for (var i in feedNameList.value.data!) {
            listPakanName.add({
              'id': i.idInt,
              'feed_name_id': i.sId,
              'feed_name': i.name,
            });
          }

          selectedPakan.value = listPakanName[0];
        }
      }
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingName.value = false;
  }

  Future getDetailPakanNameData(int id, Function() doAfter) async {
    isLoadingNameDetail.value = true;

    final response = await http.get(Uri.parse('${Urls.feedNameList}/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisPakanNameModel res =
            DetailInventarisPakanNameModel.fromJson(jsonDecode(response.body));

        feedCategory.value = res.data!.type.toString();
        name.text = res.data!.name.toString();
        producer.text = res.data!.producer.toString();
        desc.text = res.data!.description.toString();
        protein.text = res.data!.protein.toString();
        carbo.text = res.data!.carbohydrate.toString();
        minExp.text = res.data!.minExpiredPeriod.toString();
        maxExp.text = res.data!.maxExpiredPeriod.toString();
      }
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingNameDetail.value = false;
  }

  Future postPakanNameData(Function() doAfter) async {
    var map = <String, dynamic>{};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    map['type'] = feedCategory.value;
    map['name'] = name.text;
    map['description'] = desc.text == '' ? '-' : desc.text;
    // map['price'] = price.text;
    // map['amount'] = amount.text.replaceAll(',', '.');
    map['producer'] = producer.text;
    map['protein'] = protein.text == '' ? '0' : protein.text;
    map['carbohydrate'] = feedCategory.value == 'Industri'
        ? '50'
        : carbo.text == ''
            ? '0'
            : carbo.text;
    map['min_expired_period'] = minExp.text == '' ? '0' : minExp.text;
    map['max_expired_period'] = maxExp.text == ''
        ? (int.parse(minExp.text == '' ? '0' : minExp.text) * 2).toString()
        : maxExp.text;
    map['image'] = image.value;

    isLoadingPost.value = true;

    try {
      inspect(map);
      await http.post(
        Uri.parse(Urls.feedNameList),
        body: map,
        headers: headers,
      );
      doAfter();
    } catch (e) {
      inspect(e);
      throw Exception(e);
    }
    isLoadingPost.value = false;
  }

  Future updatePakanNameData(int id, Function() doAfter) async {
    var map = <String, dynamic>{};

    map['type'] = feedCategory.value;
    map['name'] = name.text;
    map['description'] = desc.text == '' ? '-' : desc.text;
    // map['price'] = price.text;
    // map['amount'] = amount.text.replaceAll(',', '.');
    map['producer'] = producer.text;
    map['protein'] = protein.text == '' ? '0' : protein.text;
    map['carbohydrate'] = feedCategory.value == 'Industri'
        ? '50'
        : carbo.text == ''
            ? '0'
            : carbo.text;
    map['min_expired_period'] = minExp.text == '' ? '0' : minExp.text;
    map['max_expired_period'] = maxExp.text == ''
        ? (int.parse(minExp.text == '' ? '0' : minExp.text) * 2).toString()
        : maxExp.text;
    map['image'] = image.value;

    isLoadingPost.value = true;

    try {
      inspect(map);
      await http.put(
        Uri.parse('${Urls.feedNameList}/$id'),
        body: map,
      );
      doAfter();
    } catch (e) {
      inspect(e);
      throw Exception(e);
    }
    isLoadingPost.value = false;
  }

  Future deletePakanName(int id, Function() doAfter) async {
    isLoadingDelete.value = true;
    try {
      await http.delete(
        Uri.parse(
          '${Urls.feedNameList}/$id',
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

  convertDaysToDate(DateTime time, int days) {
    DateTime newTime = time.add(Duration(days: days));
    var formatter = DateFormat('d MMMM y', 'id');
    var formattedDate = formatter.format(newTime);
    return formattedDate;
    // return newTime.toString().split(' ')[0].split('-').reversed.join('-');
  }

  String dateFormat(String dateString, bool includeHour) {
    DateTime dateTime = DateTime.parse(dateString);
    var formatter = includeHour
        ? DateFormat('EEEE, d MMMM y | HH:mm', 'id')
        : DateFormat('EEEE, d MMMM y', 'id');
    var formattedDate = formatter.format(dateTime);
    return formattedDate.split('|').join('| Jam');
  }

  resetNameVariables() {
    name.clear();
    desc.clear();
    producer.clear();
    protein.clear();
    carbo.clear();
    minExp.clear();
    maxExp.clear();
  }

  resetFeedVariables() {
    price.clear();
    amount.clear();
  }

  setSheetFeedVariableEdit(bool status) {
    if (status) {
      isSheetEditable.value = true;

      brandNameEdit.value = true;
      priceEdit.value = true;
      amountEdit.value = true;
    } else {
      isSheetEditable.value = false;

      brandNameEdit.value = false;
      priceEdit.value = false;
      amountEdit.value = false;
    }
  }

  setSheetNameVariableEdit(bool status) {
    if (status) {
      isSheetEditable.value = true;

      nameEdit.value = true;
      descEdit.value = true;
      producerEdit.value = true;
      proteinEdit.value = true;
      carboEdit.value = true;
      minExpEdit.value = true;
      maxExpEdit.value = true;
    } else {
      isSheetEditable.value = false;

      nameEdit.value = false;
      descEdit.value = false;
      producerEdit.value = false;
      proteinEdit.value = false;
      carboEdit.value = false;
      minExpEdit.value = false;
      maxExpEdit.value = false;
    }
  }
}

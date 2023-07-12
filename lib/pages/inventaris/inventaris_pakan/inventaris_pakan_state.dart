import 'dart:convert';
import 'dart:developer';

import 'package:fish/models/history/history_feed_chart_model.dart';
import 'package:fish/models/history/history_feed_model.dart';
import 'package:fish/models/inventaris/pakan/detail_inventaris_pakan_model.dart';
import 'package:fish/models/inventaris/pakan/inventaris_pakan_model.dart';
import 'package:fish/service/url_api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InventarisPakanState extends Urls {
  RxBool isLoadingPage = false.obs;
  RxBool isLoadingPost = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool isLoadingDetail = false.obs;
  RxBool isLoadingHistory = false.obs;
  RxBool isLoadingChart = false.obs;

  var feedList = InventarisPakanModel(data: []).obs;
  var feedHistoryList = HistoryFeedModel(data: []).obs;
  var feedChartHistoryList = HistoryFeedChartModel(data: []).obs;

  RxString pageIdentifier = 'alami'.obs;

  var dropdownList = [
    'Alami',
    'Industri',
    'Custom',
  ];

  RxBool switchValue = false.obs;

  RxString feedCategory = 'Alami'.obs;
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController producer = TextEditingController();
  TextEditingController protein = TextEditingController();
  TextEditingController carbo = TextEditingController();
  TextEditingController minExp = TextEditingController();
  TextEditingController maxExp = TextEditingController();
  RxString image =
      'https://1.bp.blogspot.com/-9tt1qS0wO-8/X8uLEZd9HGI/AAAAAAAAAnQ/4uGdwluBvYg-cwgjFAf85P_MzITSUos1ACLcBGAsYHQ/s1078/Pakan.png'
          .obs;

  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();

  RxString selectedFeedType = 'Alami'.obs;
  final List selectedFeedList = [];
  RxMap<String, dynamic> selectedFeedName = <String, dynamic>{}.obs;

  RxBool isLoadingFeedList = false.obs;
  RxBool isLoadingFeedDetail = false.obs;
  RxBool setStatusDetailFeed = false.obs;

  RxString pondName = ''.obs;

  Future getAllData(String type, Function() doAfter) async {
    feedList.value.data!.clear();
    selectedFeedList.clear();
    isLoadingPage.value = true;
    final response = await http.get(Uri.parse('${Urls.invFeed}?type=$type'));

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
        name.text = res.data!.brandName.toString();
        desc.text = res.data!.description.toString();
        price.text = res.data!.price.toString();
        amount.text = res.data!.amount!.toStringAsFixed(2);
        producer.text = res.data!.producer.toString();
        protein.text = res.data!.protein.toString();
        carbo.text = res.data!.carbohydrate.toString();
        minExp.text = res.data!.minExpiredPeriod.toString();
        maxExp.text = res.data!.maxExpiredPeriod.toString();
        image.value = res.data!.image.toString();
      }
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isLoadingDetail.value = false;
    isLoadingFeedDetail.value = false;
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

    map['feed_category'] = feedCategory.value;
    map['brand_name'] = name.text;
    map['description'] = desc.text;
    map['price'] = price.text;
    map['amount'] = amountChecker(amount.text);
    map['producer'] = producer.text;
    map['protein'] = protein.text;
    map['carbohydrate'] = carbo.text;
    map['min_expired_period'] = minExp.text;
    map['max_expired_period'] = maxExp.text == ''
        ? (int.parse(minExp.text) * 2).toString()
        : maxExp.text;
    map['image'] = image.value;

    isLoadingPost.value = true;

    inspect(map);

    try {
      await http.post(
        Uri.parse(Urls.invFeed),
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

    map['feed_category'] = feedCategory.value;
    map['brand_name'] = name.text;
    map['description'] = desc.text;
    map['price'] = price.text;
    map['amount'] = amount.text;
    map['producer'] = producer.text;
    map['protein'] = protein.text;
    map['carbohydrate'] = carbo.text;
    map['min_expired_period'] = minExp.text;
    map['max_expired_period'] = maxExp.text == ''
        ? (int.parse(minExp.text) * 2).toString()
        : maxExp.text;
    map['image'] = image.value;

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
    Function() doAfter,
  ) async {
    var map = <String, dynamic>{};

    map['pond'] = pondName;
    map['fish_feed_id'] = feedId;
    map['original_amount'] = amount;
    map['usage'] = amountChecker(used);

    try {
      await http.post(
        Uri.parse(Urls.feedSch),
        body: map,
      );
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getHistoryFeedData(
      String firstDate, String lastDate, Function() doAfter) async {
    feedHistoryList.value.data!.clear();
    isLoadingHistory.value = true;

    final response = await http.get(
        Uri.parse('${Urls.feedSch}?start_date=$firstDate&end_date=$lastDate'));

    try {
      if (response.statusCode == 200) {
        HistoryFeedModel res =
            HistoryFeedModel.fromJson(jsonDecode(response.body));

        feedHistoryList.value = res;

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

  resetVariables() {
    name.clear();
    desc.clear();
    price.clear();
    amount.clear();
    producer.clear();
    protein.clear();
    carbo.clear();
    minExp.clear();
    maxExp.clear();
  }

  convertDaysToDate(DateTime time, int days) {
    DateTime newTime = time.add(Duration(days: days));
    return newTime.toString().split(' ')[0].split('-').reversed.join('-');
  }
}

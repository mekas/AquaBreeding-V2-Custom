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

import '../../../models/inventaris/suplemen/detail_inventaris_suplemen_model.dart';
import '../../../models/inventaris/suplemen/inventaris_suplemen_model.dart';

class InventarisPakanState extends Urls {
  RxBool isLoadingPage = false.obs;
  RxBool isLoadingPost = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool isLoadingDetail = false.obs;
  RxBool isLoadingHistory = false.obs;
  RxBool isLoadingChart = false.obs;
  RxBool isLoadingName = false.obs;
  RxBool isLoadingNameDetail = false.obs;
  RxBool isProbLoading = false.obs;
  RxBool isCarbLoading = false.obs;
  RxBool isObatLoading = false.obs;


  RxBool isCustomInput2 = false.obs;
  RxBool isCustomInput3 = false.obs;
  RxBool isCustomInput4 = false.obs;
  RxBool isCustomInput5 = false.obs;
  RxBool isCustomInput6 = false.obs;
  RxBool isCustomInput7 = false.obs;
  RxBool isCustomInput8 = false.obs;
  RxBool isCustomInput9 = false.obs;
  RxBool isCustomInput10 = false.obs;
  RxBool isCustomInput11 = false.obs;
  RxBool isCustomInput12 = false.obs;
  RxBool isCustomInput13 = false.obs;
  RxBool isCustomInput14 = false.obs;
  RxBool isCustomInput15 = false.obs;

  final List listCarbon = [];
  RxMap<String, dynamic> selectedCarbon = <String, dynamic>{}.obs;

  final List listCarbon2 = [];
  RxMap<String, dynamic> selectedCarbon2 = <String, dynamic>{}.obs;

  final List listCarbon3 = [];
  RxMap<String, dynamic> selectedCarbon3 = <String, dynamic>{}.obs;

  final List listCarbon4 = [];
  RxMap<String, dynamic> selectedCarbon4 = <String, dynamic>{}.obs;

  final List listCarbon5 = [];
  RxMap<String, dynamic> selectedCarbon5 = <String, dynamic>{}.obs;

  final List listCultureProbiotik = [];
  RxMap<String, dynamic> selectedCultureProbiotik = <String, dynamic>{}.obs;

  final List listObat = [];
  RxMap<String, dynamic> selectedObat = <String, dynamic>{}.obs;

  var suplemenList = InventarisSuplemenModel(data: []).obs;

  var feedList = InventarisPakanModel(data: []).obs;
  var customFeedList = InventarisPakanModel(data: []).obs;
  var feedHistoryList = HistoryFeedModel(data: []).obs;
  var feedChartHistoryList = HistoryFeedChartModel(data: []).obs;
  var feedNameList = InventarisPakanNameModel(data: []).obs;

  RxString pageIdentifier = 'alami'.obs;

  var dropdownList = [
    'Alami',
    'Industri',
    'Custom',
  ];

  var pageList = [
    'Industri',
    'Alami',
    'Custom',
  ];

  var kategoriBahanBudidaya = [
    'Obat',
    'Perawatan Air',
    'Probiotik',
    'Feed Additive',
  ];

  RxBool switchValue = false.obs;

  // Pakan Controller
  TextEditingController price = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController finalAmount = TextEditingController();
  TextEditingController finalObatAmount = TextEditingController();
  TextEditingController finalProbiotikAmount = TextEditingController();
  TextEditingController finalCarbonAmount = TextEditingController();
  TextEditingController finalCarbon2Amount = TextEditingController();
  TextEditingController finalCarbon3Amount = TextEditingController();
  TextEditingController finalCarbon4Amount = TextEditingController();
  TextEditingController finalCarbon5Amount = TextEditingController();

  TextEditingController customPakanName = TextEditingController();

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

  RxString fishFeedId = ''.obs;

  RxString selectedCategory = 'Obat'.obs;
  final List selectedCategoryList = [];

  RxString selectedCategory2 = 'Obat'.obs;
  final List selectedCategoryList2 = [];

  RxString selectedCategory3 = 'Obat'.obs;
  final List selectedCategoryList3 = [];

  RxString selectedCategory4 = 'Obat'.obs;
  final List selectedCategoryList4 = [];

  RxString selectedCategory5 = 'Obat'.obs;
  final List selectedCategoryList5 = [];

  RxString selectedFeedType = 'Alami'.obs;
  final List selectedFeedList = [];
  final List selectedCustomFeedList = [];
  RxMap<String, dynamic> selectedFeedName = <String, dynamic>{}.obs;
  RxMap<String, dynamic> selectedCustomFeedName = <String, dynamic>{}.obs;

  RxBool isLoadingFeedList = false.obs;
  RxBool isLoadingFeedDetail = false.obs;
  RxBool setStatusDetailFeed = false.obs;
  RxBool isSheetEditable = false.obs;

  RxString pondName = ''.obs;
  RxString selectedUsedDate = ''.obs;
  TextEditingController showedUsedDate = TextEditingController();

  RxBool isReversed = false.obs;

  RxString functionCategory = 'Perawatan Air'.obs;
  RxString typeCategory = 'kg'.obs;
  var listFeedAdditive = ['Molase', 'Tapioka', 'Terigu', 'Gula', 'Garam'];
  RxString selectedFeedAdditive = 'Molase'.obs;

  RxDouble calculatedProbStock = 0.0.obs;
  RxBool isProbSelected = false.obs;
  RxDouble probStock = 0.0.obs;
  RxString probType = ''.obs;
  RxString probID = ''.obs;

  RxDouble calculatedCarbonStock = 0.0.obs;
  RxDouble carbStock = 0.0.obs;

  RxDouble calculatedCarbonStock2 = 0.0.obs;
  RxDouble carbStock2 = 0.0.obs;

  RxDouble calculatedCarbonStock3 = 0.0.obs;
  RxDouble carbStock3 = 0.0.obs;

  RxDouble calculatedCarbonStock4 = 0.0.obs;
  RxDouble carbStock4 = 0.0.obs;

  RxDouble calculatedCarbonStock5 = 0.0.obs;
  RxDouble carbStock5 = 0.0.obs;

  RxBool isCarbSelected = false.obs;
  RxString carbType = ''.obs;
  RxBool carbCheck = false.obs;
  RxString carbID = ''.obs;
  RxString carbID2 = ''.obs;
  RxString carbID3 = ''.obs;
  RxString carbID4 = ''.obs;
  RxString carbID5 = ''.obs;

  RxBool isSaltLoading = false.obs;
  RxDouble calculatedSaltStock = 0.0.obs;
  RxDouble saltStock = 0.0.obs;
  var saltDetail = InventarisSuplemenModel(data: []).obs;
  RxString saltID = ''.obs;

  RxDouble calculatedObatStock = 0.0.obs;
  RxBool isObatSelected = false.obs;
  RxDouble obatStock = 0.0.obs;
  RxString obatType = ''.obs;
  RxString obatID = ''.obs;

  TextEditingController suplementName = TextEditingController();
  TextEditingController suplementDesc = TextEditingController();
  TextEditingController suplementPrice = TextEditingController();
  TextEditingController obatPrice = TextEditingController();
  TextEditingController carbonPrice = TextEditingController();
  TextEditingController probiotikPrice = TextEditingController();
  TextEditingController suplementAmount = TextEditingController();
  TextEditingController suplementMinExp = TextEditingController();
  TextEditingController suplementMaxExp = TextEditingController();




  String amountChecker(String text) {
    var textList = text.split('');

    for (var i = 0; i < textList.length; i++) {
      if (textList[i] == ',') {
        textList[i] = '.';
      }
    }

    return textList.join('');
  }

  resetVariables() {
    name.clear();
    desc.clear();
    price.clear();
    amount.clear();
    minExp.clear();
    maxExp.clear();
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
    print("GET URL: ${Uri.parse('${Urls.invFeed}?type=$type')}");

    try {
      if (response.statusCode == 200) {
        InventarisPakanModel res =
            InventarisPakanModel.fromJson(jsonDecode(response.body));

        feedList.value = res;
        print("inventaris pakan: ${response.body}");
        for (var i in feedList.value.data!) {
          print({
            'id': i.idInt,
            'feed_id': i.sId,
            'feed_name': i.brandName,
            "amount" : i.amount,
          });
          selectedFeedList.add({
            'id': i.idInt,
            'feed_id': i.sId,
            'feed_name': i.brandName,
            "amount": i.amount,
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

  Future getAllCustomData(Function() doAfter) async {
    customFeedList.value.data!.clear();
    selectedCustomFeedList.clear();
    isLoadingPage.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
      Uri.parse('${Urls.invFeed}?type=custom'),
      headers: headers,
    );
    print("GET URL: ${Uri.parse('${Urls.invFeed}?type=custom')}");

    try {
      if (response.statusCode == 200) {
        InventarisPakanModel res =
        InventarisPakanModel.fromJson(jsonDecode(response.body));

        customFeedList.value = res;
        print("inventaris pakan: ${response.body}");
        for (var i in customFeedList.value.data!) {
          selectedCustomFeedList.add({
            'id': i.idInt,
            'feed_id': i.sId,
            'feed_name': i.brandName,
          });

          selectedCustomFeedName.value = selectedCustomFeedList[0];
        }

        inspect(customFeedList.value.data);

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

    print("GET URL ${Uri.parse('${Urls.invFeed}/$id')}");


    try {
      if (response.statusCode == 200) {
        DetailInventarisPakanModel res =
            DetailInventarisPakanModel.fromJson(jsonDecode(response.body));
        print("detail inventaris pakan ${response.body}");
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
    var totalAmount = double.parse(amount.text.replaceAll(',', '.')) + calculatedCarbonStock.value + calculatedProbStock.value + calculatedSaltStock.value;
    var obatName = selectedObat.value['suplemen_name'].toString().length != 0 ? selectedObat.value['suplemen_name'] : '';
    var carbonName = selectedCarbon.value['suplemen_name'].toString().length != 0 ? selectedObat.value['suplemen_name'] : '';
    var probiotikName = selectedCultureProbiotik.value['suplemen_name'].toString().length != 0 ? selectedObat.value['suplemen_name'] : '';
    print("category: ${feedCategory.value}");
    map['feed_name_id'] = selectedPakan.value['feed_name_id'];
    map['feed_category'] = feedCategory.value;
    map['brand_name'] = selectedPakan.value['feed_name'];
    map['price'] = "${int.parse(price.text)}" ;
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

  Future postDataCustom(Function() doAfter) async {
    var map = <String, dynamic>{};
    var totalAmount = double.parse(finalAmount.text.replaceAll(',', '.')) + double.parse(finalObatAmount.text.replaceAll(',', '.')) + double.parse(finalProbiotikAmount.text.replaceAll(',', '.')) + double.parse(finalCarbonAmount.text.replaceAll(',', '.')) + double.parse(finalCarbon2Amount.text.replaceAll(',', '.')) + double.parse(finalCarbon3Amount.text.replaceAll(',', '.')) + double.parse(finalCarbon4Amount.text.replaceAll(',', '.')) + double.parse(finalCarbon5Amount.text.replaceAll(',', '.'));
    print("total amount = ${finalAmount.text.replaceAll(',', '.')} + ${calculatedCarbonStock.value} + ${calculatedProbStock.value} + ${calculatedSaltStock} = $totalAmount");
    var totalPrice= int.parse(price.text) + int.parse(carbonPrice.text.length != 0 ? carbonPrice.text : "0") + int.parse(probiotikPrice.text.length != 0 ? probiotikPrice.text : "0") + int.parse(obatPrice.text.length != 0 ? obatPrice.text : "0");
    print("total price: ${int.parse(price.text) + int.parse(carbonPrice.text.length != 0 ? carbonPrice.text : "0") + int.parse(probiotikPrice.text.length != 0 ? probiotikPrice.text : "0") + int.parse(obatPrice.text.length != 0 ? obatPrice.text : "0")} = $totalPrice");
    print("category: ${feedCategory.value}");

    map['feed_name_id'] = selectedPakan.value['feed_name_id'];
    map['feed_category'] = "Custom";
    map['brand_name'] = "Campuran ${customPakanName.text}";
    map['price'] = "${int.parse(price.text) + int.parse(carbonPrice.text.length != 0 ? carbonPrice.text : "0") + int.parse(probiotikPrice.text.length != 0 ? probiotikPrice.text : "0") + int.parse(obatPrice.text.length != 0 ? obatPrice.text : "0")}";
    map['amount'] = "${totalAmount}";
    map["fish_feed_id"] = fishFeedId.value;
    map["feed_amount"] = "${finalAmount.text.replaceAll(',', '.')}";
    map["prob_id"] = probID.value;
    map["prob_amount"] = "${finalProbiotikAmount.text.replaceAll(',', '.')}";
    map["carb_id"] = "${carbID.value}, ${carbID2.value}, ${carbID3.value}, ${carbID4.value}, ${carbID5.value}";
    map["carb_amount"] = "${finalCarbonAmount.text.replaceAll(',', '.')}, ${finalCarbon2Amount.text.replaceAll(',', '.')}, ${finalCarbon3Amount.text.replaceAll(',', '.')}, ${finalCarbon4Amount.text.replaceAll(',', '.')}, ${finalCarbon5Amount.text.replaceAll(',', '.')}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    isLoadingPost.value = true;

    inspect(map);
    print("data req: ${map}");

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
    print("GET URL : ${Uri.parse('${Urls.feedNameList}?type=$type')}");
    try {
      if (response.statusCode == 200) {
        InventarisPakanNameModel res =
            InventarisPakanNameModel.fromJson(jsonDecode(response.body));

        feedNameList.value = res;
        print("inventaris pakan name: ${response.body}");
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
      print("POST URL: ${Uri.parse(Urls.feedNameList)}");
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

  resetSuplementVariables(){
    carbonPrice.clear();
    obatPrice.clear();
    probiotikPrice.clear();
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

  Future getAllSuplementData(String type, Function() doAfter) async {
    suplemenList.value.data!.clear();
    isLoadingPage.value = true;
    isProbLoading.value = true;
    isCarbLoading.value = true;
    listCarbon.clear();
    listCarbon2.clear();
    listCarbon3.clear();
    listCarbon4.clear();
    listCarbon5.clear();
    listObat.clear();
    listCultureProbiotik.clear();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
      Uri.parse('${Urls.invSup}?type=$type'),
      headers: headers,
    );
    print("GET URL: ${Uri.parse('${Urls.invSup}?type=$type')}");
    try {
      if (response.statusCode == 200) {
        InventarisSuplemenModel res =
        InventarisSuplemenModel.fromJson(jsonDecode(response.body));

        suplemenList.value = res;
        print("INVENTARIS BAHAN BUDIDAYA: ${response.body}");
        // inspect(suplemenList.value.data);

        if (suplemenList.value.data!.isNotEmpty) {
          for (var i in suplemenList.value.data!) {
            if (type == 'Obat') {
              listObat.add({
                'id': i.idInt,
                'suplemen_id': i.sId,
                'suplemen_name': i.name,
              });

              selectedObat.value = listObat[0];
            }
            if (type == 'Probiotik') {
              listCultureProbiotik.add({
                'id': i.idInt,
                'suplemen_id': i.sId,
                'suplemen_name': i.name,
              });

              selectedCultureProbiotik.value = listCultureProbiotik[0];
            }
            if (type == 'Feed Additive') {
              if (!listCarbon.contains(i.name)){
                listCarbon.add({
                  'id': i.idInt,
                  'suplemen_id': i.sId,
                  'suplemen_name': i.name,
                });
              }

              if (!listCarbon2.contains(i.name)){
                listCarbon2.add({
                  'id': i.idInt,
                  'suplemen_id': i.sId,
                  'suplemen_name': i.name,
                });
              }

              if (!listCarbon3.contains(i.name)){
                listCarbon3.add({
                  'id': i.idInt,
                  'suplemen_id': i.sId,
                  'suplemen_name': i.name,
                });
              }

              if (!listCarbon4.contains(i.name)){
                listCarbon4.add({
                  'id': i.idInt,
                  'suplemen_id': i.sId,
                  'suplemen_name': i.name,
                });
              }

              if (!listCarbon5.contains(i.name)){
                listCarbon5.add({
                  'id': i.idInt,
                  'suplemen_id': i.sId,
                  'suplemen_name': i.name,
                });
              }

              selectedCarbon.value = listCarbon[0];
              selectedCarbon2.value = listCarbon2[0];
              selectedCarbon3.value = listCarbon3[0];
              selectedCarbon4.value = listCarbon4[0];
              selectedCarbon5.value = listCarbon5[0];
            }
          }
        }

        // inspect(listCultureProbiotik);

        doAfter();
      }
    } catch (e) {
      inspect(e);
      throw Exception(e);
    }
    isProbLoading.value = false;
    isCarbLoading.value = false;
    isLoadingPage.value = false;
  }

  Future getSuplementDataByID(int id, Function() doAfter) async {
    isLoadingDetail.value = true;

    final response = await http.get(Uri.parse('${Urls.invSup}/$id'));
    print("GET URL ${Uri.parse('${Urls.invSup}/$id')}");

    try {
      if (response.statusCode == 200) {
        DetailInventarisSuplemenModel res =
        DetailInventarisSuplemenModel.fromJson(jsonDecode(response.body));

        // for (var i in listSuplemenName) {
        //   if (i['suplemen_name_id'] == res.data.fee)
        // }
        print("res: ${response.body}");

        functionCategory.value = res.data!.function!.toString();
        suplementName.text = res.data!.name!.toString();
        selectedFeedAdditive.value = res.data!.name!.toString();
        suplementDesc.text = res.data!.description.toString();
        suplementPrice.text = res.data!.price.toString();
        suplementAmount.text = res.data!.amount!.toStringAsFixed(2);
        typeCategory.value = res.data!.type.toString();
        suplementMinExp.text = res.data!.minExpiredPeriod.toString();
        suplementMaxExp.text = res.data!.maxExpiredPeriod.toString();
        image.value = res.data!.image.toString();
      }
      doAfter();
    } catch (e) {
      print("e: $e");
      // throw Exception(e);
    }
    isLoadingDetail.value = false;
  }
  Future getObatDetail(int id, Function() doAfter) async {
    isObatLoading.value = true;
    isObatSelected.value = true;

    final response = await http.get(Uri.parse('${Urls.invSup}/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisSuplemenModel res =
        DetailInventarisSuplemenModel.fromJson(jsonDecode(response.body));

        obatStock.value = double.parse(res.data!.amount!.toStringAsFixed(2));
        calculatedObatStock.value =
            double.parse(res.data!.amount!.toStringAsFixed(2));
        obatType.value = res.data!.type!.toString();
      }
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isObatLoading.value = false;
  }
  Future getProbDetail(int id, Function() doAfter) async {
    isProbLoading.value = true;
    isProbSelected.value = true;

    final response = await http.get(Uri.parse('${Urls.invSup}/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisSuplemenModel res =
        DetailInventarisSuplemenModel.fromJson(jsonDecode(response.body));

        probStock.value = double.parse(res.data!.amount!.toStringAsFixed(2));
        calculatedProbStock.value =
            double.parse(res.data!.amount!.toStringAsFixed(2));
        probType.value = res.data!.type!.toString();
      }
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isProbLoading.value = false;
  }

  Future getCarbDetail(int id, Function() doAfter) async {
    isCarbLoading.value = true;
    isCarbSelected.value = true;

    final response = await http.get(Uri.parse('${Urls.invSup}/$id'));

    try {
      if (response.statusCode == 200) {
        DetailInventarisSuplemenModel res =
        DetailInventarisSuplemenModel.fromJson(jsonDecode(response.body));

        carbStock.value = double.parse(res.data!.amount!.toStringAsFixed(2));
        calculatedCarbonStock.value =
            double.parse(res.data!.amount!.toStringAsFixed(2));

        carbStock2.value = double.parse(res.data!.amount!.toStringAsFixed(2));
        calculatedCarbonStock2.value =
            double.parse(res.data!.amount!.toStringAsFixed(2));

        carbStock3.value = double.parse(res.data!.amount!.toStringAsFixed(2));
        calculatedCarbonStock3.value =
            double.parse(res.data!.amount!.toStringAsFixed(2));

        carbStock4.value = double.parse(res.data!.amount!.toStringAsFixed(2));
        calculatedCarbonStock4.value =
            double.parse(res.data!.amount!.toStringAsFixed(2));

        carbStock5.value = double.parse(res.data!.amount!.toStringAsFixed(2));
        calculatedCarbonStock5.value =
            double.parse(res.data!.amount!.toStringAsFixed(2));
        carbType.value = res.data!.type!.toString();
      }
      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isCarbLoading.value = false;
  }

  Future getSaltDetail(Function() doAfter) async {
    isSaltLoading.value = true;
    var named = 'Garam';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse('${Urls.invSup}?name=$named'),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        InventarisSuplemenModel res =
        InventarisSuplemenModel.fromJson(jsonDecode(response.body));

        saltDetail.value = res;

        doAfter();
      }

      doAfter();
    } catch (e) {
      throw Exception(e);
    }
    isSaltLoading.value = true;
  }
}

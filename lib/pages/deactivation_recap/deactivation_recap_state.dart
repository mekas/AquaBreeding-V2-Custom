import 'dart:convert';
import 'dart:developer';

import 'package:fish/models/deactivation_recap_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fish/service/url_api.dart';

class DeactivationRecapState extends GetxController {
  RxBool isLoadingPage = false.obs;
  RxBool isLoadingPost = false.obs;

  var deactRecapList = DeactivationRecapModel(data: []).obs;

  var dropdownType = ['Benih', 'Pembesaran'];

  RxString selectedType = 'Benih'.obs;
  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();

  Future getRecap(
      String type, String startDate, String endDate, Function() doAfter) async {
    deactRecapList.value.data!.clear();
    isLoadingPage.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
      Uri.parse(
          '${Urls.deactivationRecap}?start_date=$startDate&end_date=$endDate'),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        DeactivationRecapModel res =
            DeactivationRecapModel.fromJson(jsonDecode(response.body));

        deactRecapList.value = res;

        doAfter();
      }
    } catch (e) {
      throw Exception(e);
    }
    isLoadingPage.value = false;
  }

  Future postRecap(String pondId, List fishs, Function() doAfter) async {
    var map = <String, dynamic>{};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};

    map['pond_id'] = pondId;

    isLoadingPost.value = true;

    for (var i = 0; i < fishs.length; i++) {
      map['fish_seed_id'] = fishs[i]['fish_seed_id'];
      map['fish_type'] = fishs[i]['type'];
      map['fish_amount'] = fishs[i]['amount'];
      map['fish_weight'] = fishs[i]['weight'];
      map['fish_category'] = fishs[i]['fish_category'];
      map['fish_price'] = fishs[i]['fish_price'];

      inspect(map);

      try {
        final response = await http.post(
          Uri.parse(Urls.deactivationRecap),
          headers: headers,
          body: map,
        );
        inspect(response);
        doAfter();
      } catch (e) {
        throw Exception(e);
      }
    }

    isLoadingPost.value = false;
  }

  String dateFormat(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    var formatter = DateFormat('EEEE, d MMMM y | HH:mm', 'id');
    var formattedDate = formatter.format(dateTime);
    return formattedDate.split('|').join('| Jam');
  }
}

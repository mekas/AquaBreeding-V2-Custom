import 'dart:convert';
import 'dart:developer';
import 'package:fish/models/activation_model.dart';
import 'package:fish/models/fish_live_model.dart';
import 'package:fish/models/fishchart_model.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/dashboard.dart';
import 'package:fish/pages/deactivation_recap/deactivation_recap_page.dart';
import 'package:fish/service/url_api.dart';
import 'package:fish/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActivationService {
  Future<List<Activation>> getActivations({required String pondId}) async {
    var url = Uri.parse(Urls.activation(pondId));
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);
    print("get url: ${Uri.parse(Urls.activation(pondId))}");
    print("response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Activation> activations = [];

      for (var item in data["pond_activation_list"]) {
        activations.add(Activation.fromJson(item));
      }

      print("success get activations");
      // inspect(activations);
      return activations;
    } else {
      throw Exception('Gagal Get Activation!');
    }
  }

  Future<List<FishChartData>> getFishChart(
      {required String activationId}) async {
    var url = Uri.parse(Urls.fishChart(activationId));
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);
    print("get url: ${Uri.parse(Urls.fishChart(activationId))}");
    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      List<FishChartData> fishDatas = FishChartData.fromJsonList(data);

      return fishDatas;
    } else {
      throw Exception('Gagal Get fish chart!');
    }
  }

  Future<bool> postActivation(
      {required String? pondId,
      required List? fish,
      required bool? isWaterPreparation,
      required String? waterLevel,
      required String? activeDate,
      required Function doInPost}) async {
    final response = await http.post(Uri.parse(Urls.pondActivation(pondId)),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          "fish": fish.toString(),
          "isWaterPreparation": false.toString(),
          "water_level": waterLevel,
          "active_at": activeDate,
        });

    if (response.statusCode == 200) {
      doInPost();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> postDeactivation(
      {required String? pondId,
      required num? total_fish_harvested,
      required String? total_weight_harvested,
      String? date,
      List? fish_harvested,
      bool? isFinish,
      required Function doInPost,
      required BuildContext context}) async {
    if (total_weight_harvested!.toString().isNotEmpty) {
      if (total_weight_harvested.contains(",")) {
        total_weight_harvested =
            total_weight_harvested.toString().replaceAll(',', '.');
      }
    }

    inspect(date);

    final response = await http.post(Uri.parse(Urls.pondDeactivation(pondId)),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          "total_weight_harvested": total_weight_harvested.toString(),
          "total_fish_harvested": total_fish_harvested.toString(),
          "fish": fish_harvested.toString(),
          "deactivated_at": date,
        });

    if (response.statusCode == 200) {
      print('sukses deaktifasi');
      doInPost();
      return true;
    } else {
      print(response.body);
      inspect(response);
      return false;
    }
  }

  Future<bool> postAddFishInActivation(
      {required String? pondId,
      required List? fish,
      required Function doInPost}) async {
    final response = await http.post(Uri.parse(Urls.addFish),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          "pond_id": pondId,
          "fish": fish.toString(),
        });
    inspect(response);
    if (response.statusCode == 200) {
      doInPost();
      return true;
    } else {
      return false;
    }
  }
}

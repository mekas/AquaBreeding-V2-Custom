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
import 'package:shared_preferences/shared_preferences.dart';

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
      required Function doInPost,
      Function()? doAfter}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fishCategory = prefs.getString('fishCategory').toString();
    final response = await http.post(Uri.parse(Urls.pondActivation(pondId)),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          "fish": fish.toString(),
          "water_level": waterLevel,
          "active_at": activeDate,
          "fish_category": fishCategory
        });
    print({
      "fish": fish.toString(),
      "water_level": waterLevel,
      "active_at": activeDate,
      "fish_category": fishCategory
    });

    if (response.statusCode == 200) {
      doInPost();
      if (doAfter != null) {
        doAfter();
      }
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
      Function()? doAfter,
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
        });
    print({
      "total_weight_harvested": total_weight_harvested.toString(),
      "total_fish_harvested": total_fish_harvested.toString(),
      "fish": fish_harvested.toString(),
    });

    if (response.statusCode == 200) {
      print('sukses deaktifasi');
      print("response body: ${response.body}");
      var temp = jsonDecode(response.body);
      print("id fish harvest: ${temp["id"]}");
      if (temp != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print(temp["id"] is int);
        prefs.setString("idFishHarvest", temp["id"]);
      }
      doInPost();
      if (doAfter != null) {
        doAfter();
      }
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

  Future postHistorySeedData(
      String pondName, List fish, String usedDate, Function() doAfter) async {
    var map = <String, dynamic>{};

    map['pond'] = pondName;
    print("postHistorySeed...");
    print("fish $fish}");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/x-www-form-urlencoded"
    };

    // print('HEHE');

    for (var i = 0; i < fish.length; i++) {
      if (fish[i]['seed_id'] is int) {
        print("yes seed id int");
      } else {
        print("no seed id not int");
      }
      if (fish[i]['original_value'] is int) {
        print("yes original_value int");
      } else {
        print("no original_value not int");
      }
      if (fish[i]['amount'] is int) {
        print("yes amount int");
      } else {
        print("no amount not int");
      }
      map['fish_seed_id'] = fish[i]['seed_id'];
      map['original_amount'] = fish[i]['original_value'];
      map['usage'] = fish[i]['amount'].toString();
      map['created_at'] = usedDate;
      print("loop fish");
      print("post url: ${Uri.parse(Urls.seedSch)}");
      print("map $map");
      try {
        print("try...");
        await http.post(
          Uri.parse(Urls.seedSch),
          body: map,
          headers: headers,
        );
        print("post url: ${Uri.parse(Urls.seedSch)}");
        doAfter();
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  Future postFishHarvestedPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    String id = prefs.getString('idFishHarvest').toString();
    int assetPrice = prefs.getInt('assetPrice') ?? 0;
    int electricPrice = prefs.getInt('electricPrice') ?? 0;
    int feedPrice = prefs.getInt('feedPrice') ?? 0;
    int seedPrice = prefs.getInt('seedPrice') ?? 0;
    int suplementPrice = prefs.getInt('suplementPrice') ?? 0;
    int totalPrice = prefs.getInt('totalPrice') ?? 0;
    var headers = {
      'Authorization': 'Bearer $token',
    };
    try {
      print("trying to post...");
      final response = await http.post(
        Uri.parse(Urls.fishHarvestedPrice),
        body: {
          "fish_harvested_id": id.toString(),
          "asset_price": assetPrice.toString(),
          "electric_price": electricPrice.toString(),
          "seed_price": seedPrice.toString(),
          "feed_price": feedPrice.toString(),
          "suplement_price": suplementPrice.toString(),
          "total_price": totalPrice.toString(),
        },
        headers: headers,
      );
      if (response.statusCode == 200) {
        print('sukses deaktifasi');
        print("response body: ${response.body}");
        var temp = jsonDecode(response.body);
        print("id fish harvest: ${temp["id"]}");
        if (temp != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("idFishHarvestPrice", temp["id"]);
        }
      }
      print({
        "fish_harvested_id": id,
        "asset_price": assetPrice,
        "electric_price": electricPrice,
        "seed_price": seedPrice,
        "feed_price": feedPrice,
        "suplement_price": suplementPrice,
        "total_price": totalPrice,
      });
      print("sukses post fish harvested price!");
    } catch (e) {
      throw Exception(e);
    }
  }
}

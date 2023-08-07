import 'dart:convert';
import 'dart:developer';
import 'package:fish/models/fish_death_model.dart';
import 'package:fish/models/fish_live_model.dart';
import 'package:fish/service/activation_service.dart';
import 'package:fish/service/url_api.dart';
import 'package:http/http.dart' as http;

class FishDeathService {
  Future<List<FishDeath>> fetchFishDeaths(
      {required String activationId}) async {
    var url = Uri.parse(Urls.fishDeath(activationId));
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<FishDeath> fishlive = FishDeath.fromJsonList(data);
      print("success add fishlvie");
      return fishlive;
    } else {
      throw Exception('Gagal Get fishdeath!');
    }
  }

  Future<List<FishLiveData>> fetchFishLive(
      {required String activationId}) async {
    var url = Uri.parse(Urls.fishDeath(activationId));
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<FishLiveData> fishdeath = FishLiveData.fromJsonList(data);
      print("success add fishdeath");
      return fishdeath;
    } else {
      throw Exception('Gagal Get fishdeath!');
    }
  }

  Future<bool> postFishDeath({
    required String? pondId,
    required List fish,
    required String? diagnosis,
  }) async {
    print({"pond_id": pondId, "fish_death_amount": fish});
    final response = await http.post(
      Uri.parse(Urls.fishDeaths),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "pond_id": pondId,
        "fish_death_amount": fish.toString(),
        "diagnosis": diagnosis,
      },
    );

    if (response.statusCode == 200) {
      inspect(response);
      return true;
    } else {
      inspect(response);
      return false;
    }
  }
}

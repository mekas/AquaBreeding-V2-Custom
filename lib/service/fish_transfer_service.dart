import 'dart:convert';
import 'dart:developer';
import 'package:fish/models/fish_transfer_model.dart';
import 'package:fish/service/url_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FishTransferService {
  Future<List<FishTransfer>> getFishTransferList() async {
    print("get transfer list, url: ${Uri.parse(Urls.fishtransfer)}");
    var url = Uri.parse(Urls.fishtransfer);
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<FishTransfer> transferhistory = [];

      for (var item in data) {
        transferhistory.add(FishTransfer.fromJson(item));
      }
      // Treatment treatment = Treatment.fromJson(data[0]);
      // print(data[1]);

      print("ini leght transfer ${transferhistory.length}");
      return transferhistory;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }

  Future<bool> postFishTransfer({
    required String? origin_pond_id,
    required String? destination_pond_id,
    required String? transfer_method,
    required String? transfer_type,
    required String? sample_weight,
    required String? sample_long,
    required List? fish,
  }) async {
    print("POST TRANSFER FISH BODY. TRANSFER BASAH");
    print("post url: ${Uri.parse(Urls.fishtransfer)}");
    print({
      "origin_pond_id": origin_pond_id.toString(),
      "destination_pond_id": destination_pond_id.toString(),
      "transfer_method": transfer_method,
      "transfer_type": transfer_type,
      "sample_long": sample_long,
      "sample_weight": sample_weight,
      "fish": fish.toString()
    });
    final response = await http.post(
      Uri.parse(Urls.fishtransfer),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "origin_pond_id": origin_pond_id.toString(),
        "destination_pond_id": destination_pond_id.toString(),
        "transfer_method": transfer_method,
        "transfer_type": transfer_type,
        "sample_long": sample_long,
        "sample_weight": sample_weight,
        "fish": fish.toString()
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  Future<bool> postFishTransferKering(
      {required String? origin_pond_id,
      required String? destination_pond_id,
      required String? transfer_method,
      required String? transfer_type,
      required String? sample_weight,
      required String? sample_long,
      required List? fish,
      required List? fishstock,
      required List? fishharvested,
      required num? total_fish_harvested,
      required num? total_weight_harvested,
      String? water_level}) async {
    print("POST TRANSFER FISH BODY. TRANSFER KERING");
    print({
      "origin_pond_id": origin_pond_id.toString(),
      "destination_pond_id": destination_pond_id.toString(),
      "transfer_method": transfer_method,
      "transfer_type": transfer_type,
      "sample_long": sample_long,
      "sample_weight": sample_weight,
      "fish": fish.toString(),
      "fish_stock": fishstock.toString(),
      "fish_harvested": fishharvested.toString(),
      "total_weight_harvested": total_weight_harvested.toString(),
      "total_fish_harvested": total_fish_harvested.toString(),
      "water_level": water_level
    });
    final response = await http.post(
      Uri.parse(Urls.fishtransfer),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "origin_pond_id": origin_pond_id.toString(),
        "destination_pond_id": destination_pond_id.toString(),
        "transfer_method": transfer_method,
        "transfer_type": transfer_type,
        "sample_long": sample_long,
        "sample_weight": sample_weight,
        "fish": fish.toString(),
        "fish_stock": fishstock.toString(),
        "fish_harvested": fishharvested.toString(),
        "total_weight_harvested": total_weight_harvested.toString(),
        "total_fish_harvested": total_fish_harvested.toString(),
        "water_level": water_level
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  Future<bool> postTransfer(
      {required String origin_pond_id,
      required String transfer_method,
      required List<dynamic> transferList,
      required BuildContext ctx}) async {
    List<dynamic> transferListPost = [];
    for (var i in transferList) {
      print("data: $i");
      if(i["price"].runtimeType == int){
        print("true int");
      } else {
        print("not int");
      }
      var fishSeed = i["fish_seed"];
      var fishCategory =  i["fish_category"];
      final fish = [];
      for (var j in i["fish"]) {
        var k = json.decode(j);
        print("ini daata for ${k["type"]}");
        final datafish = {
          "type": k["type"],
          "amount": int.parse(k["amount"]),
          "weight": double.parse(k["weight"])
        };
        fish.add(datafish);
        print("ini fish baru $fish");
      }
      final datas = {
        "destination_pond_id": i["destination_pond_id"],
        "status": i["status"],
        "fish": fish,
        "sample_weight": int.parse(i["sample_weight"]),
        "sample_long": double.parse(i['sample_long']),
        "transfer_type": i["transfer_type"],
        "fish_seed_id" : i["fish_seed"],
        "fish_category" : i["fish_category"],
        "price" : i["price"],
        if (i["status"] == "isNotActivated") ...{
          "water_level": int.parse(i["water_level"])
        }
      };
      transferListPost.add(datas);
    }
    print("POST NEW TRANSFER FISH BODY. NEW TRANSFER LIST");
    print("post url: ${Uri.parse(Urls.newfishtransfer)}");
    print("transferlistpost: $transferListPost");
    print("transferlistpost seed: ${transferListPost[0]["fish_seed_id"]}");
    print({
      "origin_pond_id": origin_pond_id.toString(),
      "fish_sort_type": transfer_method,
      "transfer_list": json.encode(transferListPost)
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(
      Uri.parse(Urls.newfishtransfer),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        'Authorization': 'Bearer $token'
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "origin_pond_id": origin_pond_id.toString(),
        "fish_sort_type": transfer_method,
        "transfer_list": json.encode(transferListPost),
        "fish_seed_id" : transferListPost[0]["fish_seed_id"],
        "fish_category" : transferListPost[0]["fish_category"],
        "price" : transferListPost[0]["price"].toString(),
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      final snackBar = SnackBar(
        content: const Text('Sortir Ikan Berhasil!'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      return true;
    } else {
      print(response.body);
      final snackBar = SnackBar(
        content: const Text('Sortir Ikan Gagal!'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);

      print("gagal post");

      return false;
    }
  }

  // Future<bool> postPondTreatmentBerat(
  //     {required String? pondId,
  //     String? type,
  //     String? desc,
  //     required num? total_fish_harvested,
  //     required num? total_weight_harvested,
  //     List? fish_harvested,
  //     bool? isFinish}) async {
  //   print({
  //     "pond_id": pondId.toString(),
  //     "treatment_type": type,
  //     "description": desc,
  //   });
  //   final response = await http.post(
  //     Uri.parse(Urls.treatment),
  //     headers: {
  //       "Content-Type": "application/x-www-form-urlencoded",
  //     },
  //     encoding: Encoding.getByName('utf-8'),
  //     body: {
  //       "pond_id": pondId,
  //       "treatment_type": type,
  //       "description": desc.toString(),
  //       "total_weight_harvested": total_weight_harvested.toString(),
  //       "total_fish_harvested": total_fish_harvested.toString(),
  //       "fish": fish_harvested.toString()
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     return true;
  //   } else {
  //     print(response.body);
  //     return false;
  //   }
  // }
}

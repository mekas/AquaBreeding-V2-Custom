class HistorySeedModel {
  String? status;
  List<Data>? data;

  HistorySeedModel({this.status, this.data});

  HistorySeedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? fishSeedId;
  int? originalAmount;
  int? usage;
  String? pond;
  String? createdAt;
  String? updatedAt;
  Seed? seed;

  Data(
      {this.sId,
      this.fishSeedId,
      this.originalAmount,
      this.usage,
      this.pond,
      this.createdAt,
      this.updatedAt,
      this.seed});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fishSeedId = json['fish_seed_id'];
    originalAmount = json['original_amount'];
    usage = json['usage'];
    pond = json['pond'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    seed = json['seed'] != null ? new Seed.fromJson(json['seed']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fish_seed_id'] = this.fishSeedId;
    data['original_amount'] = this.originalAmount;
    data['usage'] = this.usage;
    data['pond'] = this.pond;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.seed != null) {
      data['seed'] = this.seed!.toJson();
    }
    return data;
  }
}

class Seed {
  String? sId;
  String? fishSeedCategory;
  String? fishType;
  String? brandName;
  int? price;
  String? createdAt;

  Seed(
      {this.sId,
      this.fishSeedCategory,
      this.fishType,
      this.brandName,
      this.price,
      this.createdAt});

  Seed.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fishSeedCategory = json['fish_seed_category'];
    fishType = json['fish_type'];
    brandName = json['brand_name'];
    price = json['price'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fish_seed_category'] = this.fishSeedCategory;
    data['fish_type'] = this.fishType;
    data['brand_name'] = this.brandName;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class DeactivationRecapModel {
  String? status;
  List<Data>? data;

  DeactivationRecapModel({this.status, this.data});

  DeactivationRecapModel.fromJson(Map<String, dynamic> json) {
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
  int? idInt;
  String? pondId;
  String? farmId;
  String? fishSeedId;
  double? fishWeight;
  int? fishAmount;
  String? fishType;
  String? fishCategory;
  int? fishPrice;
  String? createdAt;
  String? updatedAt;
  PondDetail? pondDetail;

  Data(
      {this.sId,
      this.idInt,
      this.pondId,
      this.farmId,
      this.fishSeedId,
      this.fishWeight,
      this.fishAmount,
      this.fishType,
      this.fishCategory,
      this.fishPrice,
      this.createdAt,
      this.updatedAt,
      this.pondDetail});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    idInt = json['id_int'];
    pondId = json['pond_id'];
    farmId = json['farm_id'];
    fishSeedId = json['fish_seed_id'];
    fishWeight = json['fish_weight'];
    fishAmount = json['fish_amount'];
    fishType = json['fish_type'];
    fishCategory = json['fish_category'];
    fishPrice = json['fish_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pondDetail = json['pond_detail'] != null
        ? new PondDetail.fromJson(json['pond_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id_int'] = this.idInt;
    data['pond_id'] = this.pondId;
    data['farm_id'] = this.farmId;
    data['fish_seed_id'] = this.fishSeedId;
    data['fish_weight'] = this.fishWeight;
    data['fish_amount'] = this.fishAmount;
    data['fish_type'] = this.fishType;
    data['fish_category'] = this.fishCategory;
    data['fish_price'] = this.fishPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pondDetail != null) {
      data['pond_detail'] = this.pondDetail!.toJson();
    }
    return data;
  }
}

class PondDetail {
  String? sId;
  String? alias;
  String? location;
  String? createdAt;

  PondDetail({this.sId, this.alias, this.location, this.createdAt});

  PondDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    alias = json['alias'];
    location = json['location'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['alias'] = this.alias;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    return data;
  }
}

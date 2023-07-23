class InventarisBenihModel {
  String? status;
  List<Data>? data;

  InventarisBenihModel({this.status, this.data});

  InventarisBenihModel.fromJson(Map<String, dynamic> json) {
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
  String? fishSeedCategory;
  String? fishType;
  String? brandName;
  int? amount;
  double? weight;
  String? width;
  int? price;
  int? totalPrice;
  String? image;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.idInt,
      this.fishSeedCategory,
      this.fishType,
      this.brandName,
      this.amount,
      this.weight,
      this.width,
      this.price,
      this.totalPrice,
      this.image,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    idInt = json['id_int'];
    fishSeedCategory = json['fish_seed_category'];
    fishType = json['fish_type'];
    brandName = json['brand_name'];
    amount = json['amount'];
    weight = json['weight'];
    width = json['width'];
    price = json['price'];
    totalPrice = json['total_price'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id_int'] = this.idInt;
    data['fish_seed_category'] = this.fishSeedCategory;
    data['fish_type'] = this.fishType;
    data['brand_name'] = this.brandName;
    data['amount'] = this.amount;
    data['weight'] = this.weight;
    data['width'] = this.width;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

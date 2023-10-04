class InventarisPakanModel {
  String? status;
  List<Data>? data;

  InventarisPakanModel({this.status, this.data});

  InventarisPakanModel.fromJson(Map<String, dynamic> json) {
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
  String? feedNameId;
  int? idInt;
  String? feedCategory;
  String? brandName;
  int? price;
  double? amount;
  String? createdAt;
  String? updatedAt;
  Feed? feed;

  Data(
      {this.sId,
      this.feedNameId,
      this.idInt,
      this.feedCategory,
      this.brandName,
      this.price,
      this.amount,
      this.createdAt,
      this.updatedAt,
      this.feed});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    feedNameId = json['feed_name_id'];
    idInt = json['id_int'];
    feedCategory = json['feed_category'];
    brandName = json['brand_name'];
    price = json['price'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    feed = json['feed'] != null ? new Feed.fromJson(json['feed']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['feed_name_id'] = this.feedNameId;
    data['id_int'] = this.idInt;
    data['feed_category'] = this.feedCategory;
    data['brand_name'] = this.brandName;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.feed != null) {
      data['feed'] = this.feed!.toJson();
    }
    return data;
  }
}

class Feed {
  String? sId;
  int? idInt;
  String? type;
  String? name;
  String? description;
  String? producer;
  int? protein;
  int? carbohydrate;
  int? minExpiredPeriod;
  int? maxExpiredPeriod;
  String? image;
  String? createdAt;

  Feed(
      {this.sId,
      this.idInt,
      this.type,
      this.name,
      this.description,
      this.producer,
      this.protein,
      this.carbohydrate,
      this.minExpiredPeriod,
      this.maxExpiredPeriod,
      this.image,
      this.createdAt});

  Feed.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    idInt = json['id_int'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    producer = json['producer'];
    protein = json['protein'];
    carbohydrate = json['carbohydrate'];
    minExpiredPeriod = json['min_expired_period'];
    maxExpiredPeriod = json['max_expired_period'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id_int'] = this.idInt;
    data['type'] = this.type;
    data['name'] = this.name;
    data['description'] = this.description;
    data['producer'] = this.producer;
    data['protein'] = this.protein;
    data['carbohydrate'] = this.carbohydrate;
    data['min_expired_period'] = this.minExpiredPeriod;
    data['max_expired_period'] = this.maxExpiredPeriod;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}

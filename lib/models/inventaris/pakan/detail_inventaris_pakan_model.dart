class DetailInventarisPakanModel {
  String? status;
  Data? data;

  DetailInventarisPakanModel({this.status, this.data});

  DetailInventarisPakanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  String? description;
  int? price;
  double? amount;
  String? producer;
  int? protein;
  int? carbohydrate;
  int? minExpiredPeriod;
  int? maxExpiredPeriod;
  String? image;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.feedNameId,
      this.idInt,
      this.feedCategory,
      this.brandName,
      this.description,
      this.price,
      this.amount,
      this.producer,
      this.protein,
      this.carbohydrate,
      this.minExpiredPeriod,
      this.maxExpiredPeriod,
      this.image,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    feedNameId = json['feed_name_id'];
    idInt = json['id_int'];
    feedCategory = json['feed_category'];
    brandName = json['brand_name'];
    description = json['description'];
    price = json['price'];
    amount = json['amount'];
    producer = json['producer'];
    protein = json['protein'];
    carbohydrate = json['carbohydrate'];
    minExpiredPeriod = json['min_expired_period'];
    maxExpiredPeriod = json['max_expired_period'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['feed_name_id'] = this.feedNameId;
    data['id_int'] = this.idInt;
    data['feed_category'] = this.feedCategory;
    data['brand_name'] = this.brandName;
    data['description'] = this.description;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['producer'] = this.producer;
    data['protein'] = this.protein;
    data['carbohydrate'] = this.carbohydrate;
    data['min_expired_period'] = this.minExpiredPeriod;
    data['max_expired_period'] = this.maxExpiredPeriod;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class HistoryFeedChartModel {
  String? status;
  List<Data>? data;

  HistoryFeedChartModel({this.status, this.data});

  HistoryFeedChartModel.fromJson(Map<String, dynamic> json) {
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
  Id? iId;
  double? totalUsage;
  List<FeedData>? feedData;

  Data({this.iId, this.totalUsage, this.feedData});

  Data.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    totalUsage = json['total_usage'];
    if (json['feed_data'] != null) {
      feedData = <FeedData>[];
      json['feed_data'].forEach((v) {
        feedData!.add(new FeedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['total_usage'] = this.totalUsage;
    if (this.feedData != null) {
      data['feed_data'] = this.feedData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Id {
  String? createdAt;

  Id({this.createdAt});

  Id.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    return data;
  }
}

class FeedData {
  String? sId;
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

  FeedData(
      {this.sId,
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
      this.createdAt});

  FeedData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
    return data;
  }
}

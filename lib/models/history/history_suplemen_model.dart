class HistorySuplemenModel {
  String? status;
  List<Data>? data;

  HistorySuplemenModel({this.status, this.data});

  HistorySuplemenModel.fromJson(Map<String, dynamic> json) {
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
  String? fishSuplemenId;
  double? originalAmount;
  double? usage;
  String? pond;
  String? createdAt;
  String? updatedAt;
  Suplemen? suplemen;

  Data(
      {this.sId,
      this.fishSuplemenId,
      this.originalAmount,
      this.usage,
      this.pond,
      this.createdAt,
      this.updatedAt,
      this.suplemen});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fishSuplemenId = json['fish_suplemen_id'];
    originalAmount = json['original_amount'];
    usage = json['usage'];
    pond = json['pond'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    suplemen = json['suplemen'] != null
        ? new Suplemen.fromJson(json['suplemen'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fish_suplemen_id'] = this.fishSuplemenId;
    data['original_amount'] = this.originalAmount;
    data['usage'] = this.usage;
    data['pond'] = this.pond;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.suplemen != null) {
      data['suplemen'] = this.suplemen!.toJson();
    }
    return data;
  }
}

class Suplemen {
  String? sId;
  int? idInt;
  String? function;
  String? name;
  String? description;
  int? price;
  double? amount;
  String? type;
  int? minExpiredPeriod;
  int? maxExpiredPeriod;
  String? image;
  String? createdAt;

  Suplemen(
      {this.sId,
      this.idInt,
      this.function,
      this.name,
      this.description,
      this.price,
      this.amount,
      this.type,
      this.minExpiredPeriod,
      this.maxExpiredPeriod,
      this.image,
      this.createdAt});

  Suplemen.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    idInt = json['id_int'];
    function = json['function'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    amount = json['amount'];
    type = json['type'];
    minExpiredPeriod = json['min_expired_period'];
    maxExpiredPeriod = json['max_expired_period'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id_int'] = this.idInt;
    data['function'] = this.function;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['min_expired_period'] = this.minExpiredPeriod;
    data['max_expired_period'] = this.maxExpiredPeriod;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}

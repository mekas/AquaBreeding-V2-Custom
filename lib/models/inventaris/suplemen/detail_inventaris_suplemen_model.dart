class DetailInventarisSuplemenModel {
  String? status;
  Data? data;

  DetailInventarisSuplemenModel({this.status, this.data});

  DetailInventarisSuplemenModel.fromJson(Map<String, dynamic> json) {
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
  String? suplemenNameId;
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
  String? updatedAt;

  Data(
      {this.sId,
      this.suplemenNameId,
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
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    suplemenNameId = json['suplemen_name_id'];
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
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['suplemen_name_id'] = this.suplemenNameId;
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
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

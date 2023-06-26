class InventarisListrikModel {
  String? status;
  List<Data>? data;

  InventarisListrikModel({this.status, this.data});

  InventarisListrikModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? daya;
  String? type;
  int? price;
  String? image;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.idInt,
      this.name,
      this.daya,
      this.type,
      this.price,
      this.image,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    idInt = json['id_int'];
    name = json['name'];
    daya = json['daya'];
    type = json['type'];
    price = json['price'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id_int'] = this.idInt;
    data['name'] = this.name;
    data['daya'] = this.daya;
    data['type'] = this.type;
    data['price'] = this.price;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

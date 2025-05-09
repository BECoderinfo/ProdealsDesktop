import 'package:pro_deals_admin/modal/business.dart';

class FoodTypeListModel {
  String? sId;
  String? foodType;
  IData? image;
  String? city;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FoodTypeListModel({this.sId,
    this.foodType,
    this.image,
    this.city,
    this.createdAt,
    this.updatedAt,
    this.iV});

  FoodTypeListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    foodType = json['foodType'].toString();
    image = json['image'] != null ? IData.fromJson(json['image']) : null;
    city = json['city'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['foodType'] = foodType;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['city'] = city;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

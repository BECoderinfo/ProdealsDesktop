import 'package:pro_deals_admin/modal/business.dart';

class CategoryListModel {
  String? sId;
  String? category;
  IData? icon;
  IData? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryListModel(
      {this.sId,
      this.category,
      this.icon,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    icon = json['icon'] != null ? IData.fromJson(json['icon']) : null;
    image = json['image'] != null ? IData.fromJson(json['image']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['category'] = category;
    if (icon != null) {
      data['icon'] = icon!.toJson();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class NotificationListResopnse {
  String? sId;
  String? title;
  String? description;
  String? type;
  NotificationData? data;
  String? data1;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotificationListResopnse(
      {this.sId,
      this.title,
      this.description,
      this.type,
      this.data,
      this.data1,
      this.createdAt,
      this.updatedAt,
      this.iV});

  NotificationListResopnse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    if (json['data'] is String) {
      data1 = json['data'] ?? "";
    } else {
      data = json['data'] != null
          ? new NotificationData.fromJson(json['data'])
          : null;
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    } else {
      data['data'] = data1;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class NotificationData {
  String? businessId;
  String? businessName;

  NotificationData({this.businessId, this.businessName});

  NotificationData.fromJson(Map<String, dynamic> json) {
    businessId = json['businessId'];
    businessName = json['businessName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['businessId'] = businessId;
    data['businessName'] = businessName;
    return data;
  }
}

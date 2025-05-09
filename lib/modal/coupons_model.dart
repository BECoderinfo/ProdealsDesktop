class RedeemedPromoListModel {
  String? sId;
  String? promocode;
  List<UsedBy>? usedBy;
  String? neededAmount;
  String? discountType;
  String? discount;
  String? description;
  String? expiryDate;
  int? iV;
  String? updatedAt;

  RedeemedPromoListModel(
      {this.sId,
      this.promocode,
      this.usedBy,
      this.neededAmount,
      this.discountType,
      this.discount,
      this.description,
      this.expiryDate,
      this.iV,
      this.updatedAt});

  RedeemedPromoListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    promocode = json['promocode'].toString();
    if (json['usedBy'] != null) {
      usedBy = <UsedBy>[];
      json['usedBy'].forEach((v) {
        usedBy!.add(UsedBy.fromJson(v));
      });
    }
    neededAmount = json['neededAmount'].toString();
    discountType = json['discountType'].toString();
    discount = json['discount'].toString();
    description = json['description'].toString();
    expiryDate = json['expiryDate'];
    iV = json['__v'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['promocode'] = promocode;
    if (usedBy != null) {
      data['usedBy'] = usedBy!.map((v) => v.toJson()).toList();
    }
    data['neededAmount'] = neededAmount;
    data['discountType'] = discountType;
    data['discount'] = discount;
    data['description'] = description;
    data['expiryDate'] = expiryDate;
    data['__v'] = iV;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class UsedBy {
  UData? userId;
  String? usedAt;
  String? sId;

  UsedBy({this.userId, this.usedAt, this.sId});

  UsedBy.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null ? UData.fromJson(json['userId']) : null;
    usedAt = json['usedAt'].toString();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    data['usedAt'] = usedAt;
    data['_id'] = sId;
    return data;
  }
}

class UData {
  String? userName;
  String? email;
  String? phone;

  UData({
    this.userName,
    this.email,
    this.phone,
  });

  UData.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}

class PromoListModel {
  String? sId;
  String? promocode;
  List<UsedBy1>? usedBy;
  String? neededAmount;
  String? discountType;
  String? discount;
  String? description;
  String? expiryDate;
  int? iV;
  String? updatedAt;

  PromoListModel(
      {this.sId,
      this.promocode,
      this.usedBy,
      this.neededAmount,
      this.discountType,
      this.discount,
      this.description,
      this.expiryDate,
      this.iV,
      this.updatedAt});

  PromoListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    promocode = json['promocode'].toString();
    if (json['usedBy'] != null) {
      usedBy = <UsedBy1>[];
      json['usedBy'].forEach((v) {
        usedBy!.add(UsedBy1.fromJson(v));
      });
    }
    neededAmount = json['neededAmount'].toString();
    discountType = json['discountType'].toString();
    discount = json['discount'].toString();
    description = json['description'].toString();
    expiryDate = json['expiryDate'];
    iV = json['__v'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['promocode'] = promocode;
    if (usedBy != null) {
      data['usedBy'] = usedBy!.map((v) => v.toJson()).toList();
    }
    data['neededAmount'] = neededAmount;
    data['discountType'] = discountType;
    data['discount'] = discount;
    data['description'] = description;
    data['expiryDate'] = expiryDate;
    data['__v'] = iV;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class UsedBy1 {
  String? userId;
  String? usedAt;
  String? sId;

  UsedBy1({this.userId, this.usedAt, this.sId});

  UsedBy1.fromJson(Map<String, dynamic> json) {
    userId = json['userId'].toString();
    usedAt = json['usedAt'].toString();
    sId = json['_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['usedAt'] = usedAt;
    data['_id'] = sId;
    return data;
  }
}

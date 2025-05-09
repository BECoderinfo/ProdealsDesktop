import 'package:pro_deals_admin/modal/business.dart';

class BannerListModel {
  String? sId;
  OfferId? offerId;
  IData? image;
  String? status;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BannerListModel(
      {this.sId,
      this.offerId,
      this.image,
      this.status,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BannerListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    offerId =
        json['offerId'] != null ? new OfferId.fromJson(json['offerId']) : null;
    image = json['image'] != null ? new IData.fromJson(json['image']) : null;
    status = json['status'].toString();
    type = json['type'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (offerId != null) {
      data['offerId'] = offerId!.toJson();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['status'] = status;
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class OfferId {
  String? sId;
  String? businessId;
  String? offertype;
  String? productPrice;
  String? offerPrice;
  String? paymentAmount;
  String? validOn;
  String? description;
  String? expiryDate;
  String? createdAt;
  String? updatedAt;
  List<String>? usedBy;
  int? iV;
  bool? isActive;

  OfferId(
      {this.sId,
      this.businessId,
      this.offertype,
      this.productPrice,
      this.offerPrice,
      this.paymentAmount,
      this.validOn,
      this.description,
      this.expiryDate,
      this.createdAt,
      this.updatedAt,
      this.usedBy,
      this.iV,
      this.isActive});

  OfferId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    businessId = json['businessId'].toString();
    offertype = json['offertype'].toString();
    productPrice = json['productPrice'].toString();
    offerPrice = json['offerPrice'].toString();
    paymentAmount = json['paymentAmount'].toString();
    validOn = json['validOn'].toString();
    description = json['description'].toString();
    expiryDate = json['expiryDate'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
    usedBy = json['usedBy'].cast<String>();
    iV = json['__v'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['businessId'] = businessId;
    data['offertype'] = offertype;
    data['productPrice'] = productPrice;
    data['offerPrice'] = offerPrice;
    data['paymentAmount'] = paymentAmount;
    data['validOn'] = validOn;
    data['description'] = description;
    data['expiryDate'] = expiryDate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['usedBy'] = usedBy;
    data['__v'] = iV;
    data['isActive'] = isActive;
    return data;
  }
}

class Offers {
  String? description;
  BusinessId? businessId;
  String? sId;

  Offers({
    this.description,
    this.businessId,
    this.sId,
  });

  Offers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    businessId = json['businessId'] != null
        ? new BusinessId.fromJson(json['businessId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['description'] = description;
    if (businessId != null) {
      data['businessId'] = businessId!.toJson();
    }
    return data;
  }
}

class BusinessId {
  String? sId;
  String? businessName;

  BusinessId({
    this.sId,
    this.businessName,
  });

  BusinessId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessName = json['businessName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['businessName'] = businessName;
    return data;
  }
}

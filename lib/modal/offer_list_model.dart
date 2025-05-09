class OfferListModel {
  String? sId;
  BusinessModel? businessId;
  String? offertype;
  String? productPrice;
  String? offerPrice;
  String? paymentAmount;
  String? validOn;
  String? description;
  String? expiryDate;
  bool? isActive;
  int? usedBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  OfferListModel(
      {this.sId,
      this.businessId,
      this.offertype,
      this.productPrice,
      this.offerPrice,
      this.paymentAmount,
      this.validOn,
      this.description,
      this.expiryDate,
      this.isActive,
      this.usedBy,
      this.createdAt,
      this.updatedAt,
      this.iV});

  OfferListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    businessId = json['businessId'] != null
        ? new BusinessModel.fromJson(json['businessId'])
        : null;
    offertype = json['offertype'].toString();
    productPrice = json['productPrice'].toString();
    offerPrice = json['offerPrice'].toString();
    paymentAmount = json['paymentAmount'].toString();
    validOn = json['validOn'].toString();
    description = json['description'].toString();
    expiryDate = json['expiryDate'].toString();
    isActive = json['isActive'];
    usedBy = json['usedBy'].length;
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (businessId != null) {
      data['businessId'] = businessId!.toJson();
    }
    data['offertype'] = offertype;
    data['productPrice'] = productPrice;
    data['offerPrice'] = offerPrice;
    data['paymentAmount'] = paymentAmount;
    data['validOn'] = validOn;
    data['description'] = description;
    data['expiryDate'] = expiryDate;
    data['isActive'] = isActive;
    data['usedBy'] = usedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class BusinessModel {
  String? sId;
  String? userId;
  String? businessName;
  String? contactNumber;
  String? address;
  String? state;
  String? city;
  int? pincode;
  String? category;
  String? gstNumber;
  String? panNumber;
  String? openTime;
  String? closeTime;
  int? areaSqures;
  String? description;
  int? iV;

  BusinessModel(
      {this.sId,
      this.userId,
      this.businessName,
      this.contactNumber,
      this.address,
      this.state,
      this.city,
      this.pincode,
      this.category,
      this.gstNumber,
      this.panNumber,
      this.openTime,
      this.closeTime,
      this.areaSqures,
      this.description,
      this.iV});

  BusinessModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    userId = json['userId'].toString();
    businessName = json['businessName'].toString();
    contactNumber = json['contactNumber'].toString();
    address = json['address'].toString();
    state = json['state'].toString();
    city = json['city'].toString();
    pincode = json['pincode'];
    category = json['category'].toString();
    gstNumber = json['gstNumber'].toString();
    panNumber = json['panNumber'].toString();
    openTime = json['openTime'].toString();
    closeTime = json['closeTime'].toString();
    areaSqures = json['areaSqures'];
    description = json['Description'].toString();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['businessName'] = businessName;
    data['contactNumber'] = contactNumber;
    data['address'] = address;
    data['state'] = state;
    data['city'] = city;
    data['pincode'] = pincode;
    data['category'] = category;
    data['gstNumber'] = gstNumber;
    data['panNumber'] = panNumber;
    data['openTime'] = openTime;
    data['closeTime'] = closeTime;
    data['areaSqures'] = areaSqures;
    data['Description'] = description;
    data['__v'] = iV;
    return data;
  }
}

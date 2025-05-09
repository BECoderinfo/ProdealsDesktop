import '../utils/imports.dart';

class OrderModal {
  String? sId;
  BusinessId? businessId;
  String? status;
  String? orderStatus;
  UserId? userId;
  List<OfferId>? offerId;
  List<int>? quantity;
  int? offerprice;
  String? promocode;
  int? discount;
  int? totalPrice;
  int? totalsave;
  String? createdAt;
  String? updatedAt;
  int? iV;

  OrderModal(
      {this.sId,
      this.businessId,
      this.status,
      this.orderStatus,
      this.userId,
      this.offerId,
      this.quantity,
      this.offerprice,
      this.promocode,
      this.discount,
      this.totalPrice,
      this.totalsave,
      this.createdAt,
      this.updatedAt,
      this.iV});

  OrderModal.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessId = json['businessId'] != null
        ? BusinessId.fromJson(json['businessId'])
        : null;
    status = json['status'];
    orderStatus = json['orderStatus'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    if (json['offerId'] != null) {
      offerId = <OfferId>[];
      json['offerId'].forEach((v) {
        offerId!.add(OfferId.fromJson(v));
      });
    }
    quantity = json['quantity'].cast<int>();
    offerprice = json['offerprice'];
    promocode = json['promocode'];
    discount = json['discount'];
    totalPrice = json['totalPrice'];
    totalsave = json['totalsave'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (businessId != null) {
      data['businessId'] = businessId!.toJson();
    }
    data['status'] = status;
    data['orderStatus'] = orderStatus;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    if (offerId != null) {
      data['offerId'] = offerId!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = quantity;
    data['offerprice'] = offerprice;
    data['promocode'] = promocode;
    data['discount'] = discount;
    data['totalPrice'] = totalPrice;
    data['totalsave'] = totalsave;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class BusinessId {
  MainImage? mainImage;
  String? sId;
  String? businessName;
  String? contactNumber;
  String? address;
  String? state;
  String? city;
  int? pincode;

  BusinessId(
      {this.mainImage,
      this.sId,
      this.businessName,
      this.contactNumber,
      this.address,
      this.state,
      this.city,
      this.pincode});

  BusinessId.fromJson(Map<String, dynamic> json) {
    mainImage = json['mainImage'] != null
        ? MainImage.fromJson(json['mainImage'])
        : null;
    sId = json['_id'];
    businessName = json['businessName'];
    contactNumber = json['contactNumber'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mainImage != null) {
      data['mainImage'] = mainImage!.toJson();
    }
    data['_id'] = sId;
    data['businessName'] = businessName;
    data['contactNumber'] = contactNumber;
    data['address'] = address;
    data['state'] = state;
    data['city'] = city;
    data['pincode'] = pincode;
    return data;
  }
}

class Data {
  String? type;
  List<int>? data;

  Data({this.type, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['data'] = this.data;
    return data;
  }
}

class UserId {
  String? sId;
  String? userName;
  String? email;
  String? phone;
  Data? image;

  UserId({this.sId, this.userName, this.email, this.phone, this.image});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'] != null ? Data.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    data['phone'] = phone;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class OfferId {
  String? sId;
  String? businessId;
  String? offertype;
  int? productPrice;
  int? offerPrice;
  int? paymentAmount;
  String? validOn;
  String? description;
  List<String>? usedBy;
  String? expiryDate;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  OfferId(
      {this.sId,
      this.businessId,
      this.offertype,
      this.productPrice,
      this.offerPrice,
      this.paymentAmount,
      this.validOn,
      this.description,
      this.usedBy,
      this.expiryDate,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.iV});

  OfferId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessId = json['businessId'];
    offertype = json['offertype'];
    productPrice = json['productPrice'];
    offerPrice = json['offerPrice'];
    paymentAmount = json['paymentAmount'];
    validOn = json['validOn'];
    description = json['description'];
    usedBy = json['usedBy'].cast<String>();
    expiryDate = json['expiryDate'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
    data['usedBy'] = usedBy;
    data['expiryDate'] = expiryDate;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

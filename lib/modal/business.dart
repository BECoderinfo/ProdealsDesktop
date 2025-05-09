class AllBusinessModel {
  MainImage? mainImage;
  MainImage? waterIdImage;
  MainImage? govermentIdImage;
  String? sId;
  UserId? userId;
  String? businessName;
  String? contactNumber;
  String? address;
  String? state;
  String? city;
  String? pincode;
  String? category;
  String? gstNumber;
  String? panNumber;
  IData? proofImage;
  String? openTime;
  String? closeTime;
  int? areaSqures;
  String? description;
  int? iV;
  List<MainImageId>? menuImages;
  String? offDays;
  List<MainImageId>? storeImages;

  AllBusinessModel(
      {this.mainImage,
      this.waterIdImage,
      this.govermentIdImage,
      this.sId,
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
      this.proofImage,
      this.openTime,
      this.closeTime,
      this.areaSqures,
      this.description,
      this.iV,
      this.menuImages,
      this.offDays,
      this.storeImages});

  AllBusinessModel.fromJson(Map<String, dynamic> json) {
    mainImage = json['mainImage'] != null
        ? MainImage.fromJson(json['mainImage'])
        : null;
    waterIdImage = json['waterIdImage'] != null
        ? MainImage.fromJson(json['waterIdImage'])
        : null;
    govermentIdImage = json['govermentIdImage'] != null
        ? MainImage.fromJson(json['govermentIdImage'])
        : null;
    sId = json['_id'].toString();
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    businessName = json['businessName'].toString();
    contactNumber = json['contactNumber'].toString();
    address = json['address'].toString();
    state = json['state'].toString();
    city = json['city'].toString();
    pincode = json['pincode'].toString();
    category = json['category'];
    gstNumber = json['gstNumber'].toString();
    panNumber = json['panNumber'].toString();
    proofImage =
        json['proofImage'] != null ? IData.fromJson(json['proofImage']) : null;
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    areaSqures = json['areaSqures'];
    description = json['Description'];
    iV = json['__v'];
    if (json['menuImages'] != null) {
      menuImages = <MainImageId>[];
      json['menuImages'].forEach((v) {
        menuImages!.add(MainImageId.fromJson(v));
      });
    }
    offDays = json['offDays'];
    if (json['storeImages'] != null) {
      storeImages = <MainImageId>[];
      json['storeImages'].forEach((v) {
        storeImages!.add(MainImageId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mainImage != null) {
      data['mainImage'] = mainImage!.toJson();
    }
    if (waterIdImage != null) {
      data['waterIdImage'] = waterIdImage!.toJson();
    }
    if (govermentIdImage != null) {
      data['govermentIdImage'] = govermentIdImage!.toJson();
    }
    data['_id'] = sId;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    data['businessName'] = businessName;
    data['contactNumber'] = contactNumber;
    data['address'] = address;
    data['state'] = state;
    data['city'] = city;
    data['pincode'] = pincode;
    data['category'] = category;
    data['gstNumber'] = gstNumber;
    data['panNumber'] = panNumber;
    if (proofImage != null) {
      data['proofImage'] = proofImage!.toJson();
    }
    data['openTime'] = openTime;
    data['closeTime'] = closeTime;
    data['areaSqures'] = areaSqures;
    data['Description'] = description;
    data['__v'] = iV;
    if (menuImages != null) {
      data['menuImages'] = menuImages!.map((v) => v.toJson()).toList();
    }
    data['offDays'] = offDays;
    if (storeImages != null) {
      data['storeImages'] = storeImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainImage {
  IData? data;
  String? contentType;

  MainImage({this.data, this.contentType});

  MainImage.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? IData.fromJson(json['data']) : null;
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['contentType'] = contentType;
    return data;
  }
}

class IData {
  String? type;
  List<int>? data;

  IData({this.type, this.data});

  IData.fromJson(Map<String, dynamic> json) {
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
  IData? image;
  String? businessId;

  UserId(
      {this.sId,
      this.userName,
      this.email,
      this.phone,
      this.image,
      this.businessId});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'] != null ? IData.fromJson(json['image']) : null;
    businessId = json['businessId'];
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
    data['businessId'] = businessId;
    return data;
  }
}

class MainImageId {
  IData1? data;
  String? contentType;
  String? sId;

  MainImageId({this.data, this.contentType, this.sId});

  MainImageId.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? IData1.fromJson(json['data']) : null;
    contentType = json['contentType'].toString();
    sId = json['_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['contentType'] = contentType;
    data['_id'] = sId;
    return data;
  }
}

class IData1 {
  String? type;
  List<int>? data;

  IData1({this.type, this.data});

  IData1.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['data'] = this.data;
    return data;
  }
}

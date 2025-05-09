class RequestBusinessModel {
  String? sId;
  String? businessName;
  String? contactNumber;
  UserData? userId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RequestBusinessModel(
      {this.sId,
      this.businessName,
      this.contactNumber,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  RequestBusinessModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessName = json['businessName'];
    contactNumber = json['contactNumber'];
    userId = json['userId'] != null ? UserData.fromJson(json['userId']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['businessName'] = businessName;
    data['contactNumber'] = contactNumber;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class UserData {
  String? userName;
  String? email;
  String? phone;

  UserData({this.userName, this.email, this.phone});

  UserData.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    phone = (json['phone'] ?? "Not provide").toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}

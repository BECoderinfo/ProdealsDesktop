class UserModel {
  int? type;
  String? id;
  String? userName;
  String? email;
  String? phone;
  String? password;
  String? address;
  String? status;
  bool? isBusiness;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? businessId;
  bool? isActive;
  bool? isDeleted;
  bool? isAdmin;
  ImageClass? image;

  UserModel({
    this.type,
    this.id,
    this.userName,
    this.email,
    this.phone,
    this.password,
    this.address,
    this.status,
    this.isBusiness,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.businessId,
    this.isActive,
    this.isDeleted,
    this.isAdmin,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        type: json["type"],
        id: json["_id"],
        userName: json["userName"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        address: json["address"],
        status: json["status"],
        isBusiness: json["isBusiness"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        businessId: json["businessId"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        isAdmin: json["isAdmin"],
        image:
            json["image"] == null ? null : ImageClass.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "_id": id,
        "userName": userName,
        "email": email,
        "phone": phone,
        "password": password,
        "address": address,
        "status": status,
        "isBusiness": isBusiness,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "businessId": businessId,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "isAdmin": isAdmin,
        "image": image?.toJson(),
      };
}

class ImageClass {
  String? type;
  List<int>? data;

  ImageClass({this.type, this.data});

  ImageClass.fromJson(Map<String, dynamic> json) {
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

class StaffListModel {
  String? sId;
  String? password;
  String? staffId;
  String? name;
  String? email;
  String? phone;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;

  StaffListModel(
      {this.sId,
      this.password,
      this.staffId,
      this.name,
      this.email,
      this.phone,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.iV});

  StaffListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    password = json['password'].toString();
    staffId = json['StaffId'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    role = json['role'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['password'] = password;
    data['StaffId'] = staffId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

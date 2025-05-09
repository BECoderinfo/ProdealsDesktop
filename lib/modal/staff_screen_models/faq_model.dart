class FAQListModel {
  String? sId;
  String? quotation;
  String? status;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? answer;

  FAQListModel(
      {this.sId,
      this.quotation,
      this.status,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.answer});

  FAQListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    quotation = json['quotation'].toString();
    status = json['status'].toString();
    user = json['user'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
    iV = json['__v'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['quotation'] = quotation;
    data['status'] = status;
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['answer'] = answer;
    return data;
  }
}

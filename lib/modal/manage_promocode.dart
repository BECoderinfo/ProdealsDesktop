class PromoListModel {
  String? sId;
  String? promocode;
  List<String>? usedBy;
  String? neededAmount;
  String? discountType;
  String? discount;
  String? description;
  String? expiryDate;
  int? iV;

  PromoListModel(
      {this.sId,
      this.promocode,
      this.usedBy,
      this.neededAmount,
      this.discountType,
      this.discount,
      this.description,
      this.expiryDate,
      this.iV});

  PromoListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    promocode = json['promocode'].toString();
    usedBy = json['usedBy'].cast<String>();
    neededAmount = json['neededAmount'].toString();
    discountType = json['discountType'].toString();
    discount = json['discount'].toString();
    description = json['description'].toString();
    expiryDate = json['expiryDate'].toString();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['promocode'] = promocode;
    data['usedBy'] = usedBy;
    data['neededAmount'] = neededAmount;
    data['discountType'] = discountType;
    data['discount'] = discount;
    data['description'] = description;
    data['expiryDate'] = expiryDate;
    data['__v'] = iV;
    return data;
  }
}

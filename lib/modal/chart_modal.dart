class ChartModal {
  String? tital;
  int? orders;
  int? revenue;

  ChartModal({this.tital, this.orders, this.revenue});

  ChartModal.fromJsonDay(Map<String, dynamic> json) {
    tital = json['day'];
    orders = json['Orders'];
    revenue = json['revenue'];
  }

  ChartModal.fromJsonMonth(Map<String, dynamic> json) {
    tital = json['month'].toString();
    orders = json['Orders'];
    revenue = json['revenue'];
  }

  ChartModal.fromJsonYear(Map<String, dynamic> json) {
    tital = json['year'].toString();
    orders = json['Orders'];
    revenue = json['revenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tital'] = tital;
    data['Orders'] = orders;
    data['revenue'] = revenue;
    return data;
  }
}

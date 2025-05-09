class DashBoardDataModel {
  int? totalEarning;
  int? totalOrders;
  int? offerData;
  int? activeOffers;
  int? todaysOrders;

  DashBoardDataModel(
      {this.totalEarning,
      this.totalOrders,
      this.offerData,
      this.activeOffers,
      this.todaysOrders});

  DashBoardDataModel.fromJson(Map<String, dynamic> json) {
    totalEarning = json['totalEarning'];
    totalOrders = json['totalOrders'];
    offerData = json['offerData'];
    activeOffers = json['activeOffers'];
    todaysOrders = json['todaysOrders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalEarning'] = totalEarning;
    data['totalOrders'] = totalOrders;
    data['offerData'] = offerData;
    data['activeOffers'] = activeOffers;
    data['todaysOrders'] = todaysOrders;
    return data;
  }
}

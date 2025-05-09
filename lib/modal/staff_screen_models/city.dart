class CityListModel {
  String? sId;
  String? cityname;
  int? iV;

  CityListModel({this.sId, this.cityname, this.iV});

  CityListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    cityname = json['Cityname'].toString();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['Cityname'] = cityname;
    data['__v'] = iV;
    return data;
  }
}

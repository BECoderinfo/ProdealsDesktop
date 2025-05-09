class MembershipPlanModel {
  final String id;
  final String planName;
  final int planPrice;
  final String planDuration;
  final int planCount;
  final List<String> planDescription;
  final String planStatus;
  final String rezorpayPlanId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  MembershipPlanModel({
    required this.id,
    required this.planName,
    required this.planPrice,
    required this.planDuration,
    required this.planCount,
    required this.planDescription,
    required this.planStatus,
    required this.rezorpayPlanId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MembershipPlanModel.fromJson(Map<String, dynamic> json) =>
      MembershipPlanModel(
        id: json["_id"],
        planName: json["planName"],
        planPrice: json["planPrice"],
        planDuration: json["planDuration"],
        planCount: json["planCount"],
        planDescription:
            List<String>.from(json["planDescription"].map((x) => x)),
        planStatus: json["planStatus"],
        rezorpayPlanId: json["rezorpayPlanId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "planName": planName,
        "planPrice": planPrice,
        "planDuration": planDuration,
        "planCount": planCount,
        "planDescription": List<dynamic>.from(planDescription.map((x) => x)),
        "planStatus": planStatus,
        "rezorpayPlanId": rezorpayPlanId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

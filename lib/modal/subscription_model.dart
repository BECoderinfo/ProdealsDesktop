class SubscriptionModel {
  String? id;
  UserId? userId;
  PlanId? planId;
  String? razorpaySubcriptionId;
  String? razorpayPlanId;
  DateTime? startDate;
  DateTime? endDate;
  bool? autoRenew;
  int? renewalPeriod;
  bool? isActive;
  int? v;

  SubscriptionModel({
    this.id,
    this.userId,
    this.planId,
    this.razorpaySubcriptionId,
    this.razorpayPlanId,
    this.startDate,
    this.endDate,
    this.autoRenew,
    this.renewalPeriod,
    this.isActive,
    this.v,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        id: json["_id"],
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
        planId: json["planId"] == null ? null : PlanId.fromJson(json["planId"]),
        razorpaySubcriptionId: json["razorpaySubcriptionId"],
        razorpayPlanId: json["razorpayPlanId"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        autoRenew: json["autoRenew"],
        renewalPeriod: json["renewalPeriod"],
        isActive: json["isActive"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId?.toJson(),
        "planId": planId?.toJson(),
        "razorpaySubcriptionId": razorpaySubcriptionId,
        "razorpayPlanId": razorpayPlanId,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "autoRenew": autoRenew,
        "renewalPeriod": renewalPeriod,
        "isActive": isActive,
        "__v": v,
      };
}

class PlanId {
  String? id;
  String? planName;

  PlanId({
    this.id,
    this.planName,
  });

  factory PlanId.fromJson(Map<String, dynamic> json) => PlanId(
        id: json["_id"],
        planName: json["planName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "planName": planName,
      };
}

class UserId {
  String? id;
  String? userName;

  UserId({
    this.id,
    this.userName,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
      };
}

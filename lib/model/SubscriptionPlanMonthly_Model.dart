import 'dart:convert';

SubscriptionPlanMonthlyModel subscriptionPlanMonthlyModelFromJson(String str) =>
    SubscriptionPlanMonthlyModel.fromJson(json.decode(str));

String subscriptionPlanMonthlyModelToJson(SubscriptionPlanMonthlyModel data) =>
    json.encode(data.toJson());

class SubscriptionPlanMonthlyModel {
  SubscriptionPlanMonthlyModel({
    required this.subscriptionPlanMonthly,
    required this.statusCode,
  });

  List<SubscriptionPlanMonthly> subscriptionPlanMonthly;
  int statusCode;

  factory SubscriptionPlanMonthlyModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlanMonthlyModel(
        subscriptionPlanMonthly: List<SubscriptionPlanMonthly>.from(
            json["Subscription Plan Monthly"]
                .map((x) => SubscriptionPlanMonthly.fromJson(x))),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "Subscription Plan Monthly":
            List<dynamic>.from(subscriptionPlanMonthly.map((x) => x.toJson())),
        "status_code": statusCode,
      };
}

class SubscriptionPlanMonthly {
  SubscriptionPlanMonthly({
    required this.planId,
    required this.planName,
    required this.planDuration,
    required this.planPrice,
    required this.currencyCode,
  });

  int planId;
  String planName;
  String planDuration;
  String planPrice;
  String currencyCode;

  factory SubscriptionPlanMonthly.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlanMonthly(
        planId: json["plan_id"],
        planName: json["plan_name"],
        planDuration: json["plan_duration"],
        planPrice: json["plan_price"],
        currencyCode: json["currency_code"],
      );

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "plan_name": planName,
        "plan_duration": planDuration,
        "plan_price": planPrice,
        "currency_code": currencyCode,
      };
}

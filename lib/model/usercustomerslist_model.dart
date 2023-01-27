import 'dart:convert';

List<UsercustomerslistModel> usercustomerslistModelFromJson(String str) => List<UsercustomerslistModel>.from(json.decode(str).map((x) => UsercustomerslistModel.fromJson(x)));

String usercustomerslistModelToJson(List<UsercustomerslistModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsercustomerslistModel {
    UsercustomerslistModel({
        required this.userId,
        required this.username,
        required this.customerId,
        required this.customerName,
    });

    int userId;
    String username;
    int customerId;
    String customerName;

    factory UsercustomerslistModel.fromJson(Map<String, dynamic> json) => UsercustomerslistModel(
        userId: json["UserId"],
        username: json["Username"],
        customerId: json["CustomerId"],
        customerName: json["CustomerName"],
    );

    Map<String, dynamic> toJson() => {
        "UserId": userId,
        "Username": username,
        "CustomerId": customerId,
        "CustomerName": customerName,
    };
}

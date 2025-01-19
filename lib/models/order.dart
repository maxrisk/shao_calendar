import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderResponse {
  final int code;
  final String? msg;
  final OrderData? data;

  OrderResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}

@JsonSerializable()
class OrderData {
  final String orderId;
  final String payUrl;
  final int amount;
  final String productName;
  final int days;
  final String payType;

  OrderData({
    required this.orderId,
    required this.payUrl,
    required this.amount,
    required this.productName,
    required this.days,
    required this.payType,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) =>
      _$OrderDataFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDataToJson(this);
}

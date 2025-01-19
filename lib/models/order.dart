import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderResponse {
  final int code;
  final String? msg;
  @JsonKey(name: 'data')
  final String? payUrl;

  OrderResponse({
    required this.code,
    this.msg,
    this.payUrl,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}

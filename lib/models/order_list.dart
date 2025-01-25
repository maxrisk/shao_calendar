import 'package:json_annotation/json_annotation.dart';

part 'order_list.g.dart';

@JsonSerializable()
class OrderItem {
  final int id;
  final int userId;
  final String payType;
  final String orderNo;
  final double total;
  final String status;
  final String createTime;
  final String? expireTime;
  final String? payedTime;
  final String? title;
  final double firstAmount;
  final double secondAmount;
  final int? firstUserId;
  final int? secondUserId;
  final int? productId;

  /// 格式化的创建时间
  String get formattedCreateTime {
    final dateTime = DateTime.parse(createTime).toLocal();
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  const OrderItem({
    required this.id,
    required this.userId,
    required this.payType,
    required this.orderNo,
    required this.total,
    required this.status,
    required this.createTime,
    this.expireTime,
    this.payedTime,
    this.title,
    required this.firstAmount,
    required this.secondAmount,
    this.firstUserId,
    this.secondUserId,
    this.productId,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class OrderListResponse {
  final int code;
  final String? msg;
  final List<OrderItem>? data;

  const OrderListResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderListResponseToJson(this);
}

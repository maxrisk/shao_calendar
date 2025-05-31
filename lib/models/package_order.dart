import 'package:json_annotation/json_annotation.dart';

part 'package_order.g.dart';

/// 服务包订单详情项
@JsonSerializable()
class PackageOrderDetailItem {
  final int id;
  final String serviceName;
  final double price;
  final String description;
  final String detailImage;
  final int packageOrderId;
  final String createTime;

  PackageOrderDetailItem({
    required this.id,
    required this.serviceName,
    required this.price,
    required this.description,
    required this.detailImage,
    required this.packageOrderId,
    required this.createTime,
  });

  factory PackageOrderDetailItem.fromJson(Map<String, dynamic> json) =>
      _$PackageOrderDetailItemFromJson(json);
  Map<String, dynamic> toJson() => _$PackageOrderDetailItemToJson(this);
}

/// 服务包订单项
@JsonSerializable()
class PackageOrderItem {
  final int id;
  final int userId;
  final String payType;
  final String orderNo;
  final String createTime;
  final String updateTime;
  final String status;
  final String type;
  final int packageId;
  final String name;
  final double total;
  final String description;
  final String detailImage;
  final List<PackageOrderDetailItem> details;

  /// 格式化的创建时间
  String get formattedCreateTime {
    final dateTime = DateTime.parse(createTime).toLocal();
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  PackageOrderItem({
    required this.id,
    required this.userId,
    required this.payType,
    required this.orderNo,
    required this.createTime,
    required this.updateTime,
    required this.status,
    required this.type,
    required this.packageId,
    required this.name,
    required this.total,
    required this.description,
    required this.detailImage,
    required this.details,
  });

  factory PackageOrderItem.fromJson(Map<String, dynamic> json) =>
      _$PackageOrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$PackageOrderItemToJson(this);
}

/// 服务包订单列表响应
@JsonSerializable()
class PackageOrderListResponse {
  final int code;
  final String? msg;
  final List<PackageOrderItem>? data;

  PackageOrderListResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory PackageOrderListResponse.fromJson(Map<String, dynamic> json) =>
      _$PackageOrderListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PackageOrderListResponseToJson(this);
}
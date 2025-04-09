import 'package:json_annotation/json_annotation.dart';

part 'single_package_order.g.dart';

/// 单项服务订单项
@JsonSerializable()
class SinglePackageOrderItem {
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

  /// 格式化的创建时间
  String get formattedCreateTime {
    final dateTime = DateTime.parse(createTime).toLocal();
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  SinglePackageOrderItem({
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
  });

  factory SinglePackageOrderItem.fromJson(Map<String, dynamic> json) =>
      _$SinglePackageOrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$SinglePackageOrderItemToJson(this);
}

/// 单项服务订单列表响应
@JsonSerializable()
class SinglePackageOrderListResponse {
  final int code;
  final String? msg;
  final List<SinglePackageOrderItem>? data;

  SinglePackageOrderListResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory SinglePackageOrderListResponse.fromJson(Map<String, dynamic> json) =>
      _$SinglePackageOrderListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SinglePackageOrderListResponseToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'order_list.g.dart';

/// 支付类型枚举
enum PayType {
  /// 微信支付
  @JsonValue('WECHAT')
  wechat,

  /// 支付宝支付
  @JsonValue('ALIPAY')
  alipay,
}

/// 支付类型的扩展方法
extension PayTypeExtension on PayType {
  /// 获取支付类型的显示名称
  String get displayName {
    switch (this) {
      case PayType.wechat:
        return '微信支付';
      case PayType.alipay:
        return '支付宝支付';
    }
  }

  /// 获取原始字符串值
  String get value {
    switch (this) {
      case PayType.wechat:
        return 'WECHAT';
      case PayType.alipay:
        return 'ALIPAY';
    }
  }
}

@JsonSerializable()
class OrderItem {
  final int id;
  final int userId;
  final PayType payType;
  final String orderNo;
  final double? total;
  final String status;
  final String createTime;
  final String? expireTime;
  final String? payedTime;
  final String? title;
  final double? firstAmount;
  final double? secondAmount;
  final double? provinceAmount;
  final double? cityAmount;
  final double? districtAmount;
  final double? areaAgent;
  final int? firstUserId;
  final int? secondUserId;
  final int? productId;
  final String? createBy;
  final String? updateBy;
  final String? updateTime;
  final String? remark;

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
    this.total,
    required this.status,
    required this.createTime,
    this.expireTime,
    this.payedTime,
    this.title,
    this.firstAmount,
    this.secondAmount,
    this.provinceAmount,
    this.cityAmount,
    this.districtAmount,
    this.areaAgent,
    this.firstUserId,
    this.secondUserId,
    this.productId,
    this.createBy,
    this.updateBy,
    this.updateTime,
    this.remark,
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

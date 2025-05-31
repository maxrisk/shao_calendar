import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

/// 微信支付参数
@JsonSerializable()
class WechatPayParams {
  final String appid;
  final String timestamp;
  final String partnerId;
  final String prepayId;
  final String noncestr;
  final String packageValue;
  final String sign;

  WechatPayParams({
    required this.appid,
    required this.timestamp,
    required this.partnerId,
    required this.prepayId,
    required this.noncestr,
    required this.packageValue,
    required this.sign,
  });

  factory WechatPayParams.fromJson(Map<String, dynamic> json) =>
      _$WechatPayParamsFromJson(json);
  Map<String, dynamic> toJson() => _$WechatPayParamsToJson(this);
}

/// 微信支付订单数据
@JsonSerializable()
class WechatOrderData {
  final String orderNo;
  final WechatPayParams pay;

  WechatOrderData({
    required this.orderNo,
    required this.pay,
  });

  factory WechatOrderData.fromJson(Map<String, dynamic> json) =>
      _$WechatOrderDataFromJson(json);
  Map<String, dynamic> toJson() => _$WechatOrderDataToJson(this);
}

/// 订单响应
@JsonSerializable()
class OrderResponse {
  final int code;
  final String? msg;
  final dynamic data;

  OrderResponse({
    required this.code,
    this.msg,
    this.data,
  });

  /// 支付宝支付链接
  String? get alipayUrl => data is String ? data : null;

  /// 支付宝支付H5表单
  String? get alipayH5PayForm => data is String ? data : null;

  /// 微信支付数据
  WechatOrderData? get wechatData =>
      data is Map<String, dynamic> ? WechatOrderData.fromJson(data) : null;

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}

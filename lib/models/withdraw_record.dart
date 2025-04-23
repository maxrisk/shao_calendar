import 'package:json_annotation/json_annotation.dart';

part 'withdraw_record.g.dart';

/// 提现记录
@JsonSerializable()
class WithdrawRecord {
  /// 提现记录ID
  final int id;

  /// 创建者
  final String? createBy;

  /// 创建时间
  final String createTime;

  /// 更新者
  final String? updateBy;

  /// 更新时间
  final String? updateTime;

  /// 备注
  final String? remark;

  /// 当前金额
  final double nowAmount;

  /// 之前金额
  final double preAmount;

  /// 变动金额
  final double changeAmount;

  /// 用户ID
  final int userId;

  /// 关联用户ID
  final int? linkUserId;

  /// 订单号
  final String orderNo;

  /// 推广
  final int promotion;

  /// 级别
  final int level;

  /// 类型 1:提现
  final int type;

  /// 名称
  final String? name;

  /// 创建提现记录
  const WithdrawRecord({
    required this.id,
    this.createBy,
    required this.createTime,
    this.updateBy,
    this.updateTime,
    this.remark,
    required this.nowAmount,
    required this.preAmount,
    required this.changeAmount,
    required this.userId,
    this.linkUserId,
    required this.orderNo,
    required this.promotion,
    required this.level,
    required this.type,
    this.name,
  });

  /// 从JSON创建提现记录
  factory WithdrawRecord.fromJson(Map<String, dynamic> json) =>
      _$WithdrawRecordFromJson(json);

  /// 转换为JSON
  Map<String, dynamic> toJson() => _$WithdrawRecordToJson(this);

  /// 获取提现金额（取变动金额的绝对值）
  String get money =>
      (changeAmount < 0 ? -changeAmount : changeAmount).toStringAsFixed(2);
}

/// 提现记录列表响应
@JsonSerializable()
class WithdrawRecordListResponse {
  /// 响应代码
  final int code;

  /// 响应消息
  final String? msg;

  /// 提现记录列表
  final List<WithdrawRecord>? data;

  /// 创建提现记录列表响应
  const WithdrawRecordListResponse({
    required this.code,
    this.msg,
    this.data,
  });

  /// 从JSON创建提现记录列表响应
  factory WithdrawRecordListResponse.fromJson(Map<String, dynamic> json) =>
      _$WithdrawRecordListResponseFromJson(json);

  /// 转换为JSON
  Map<String, dynamic> toJson() => _$WithdrawRecordListResponseToJson(this);
}

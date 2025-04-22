import 'package:json_annotation/json_annotation.dart';

part 'commission_record.g.dart';

/// 佣金记录类型
enum CommissionRecordType {
  /// 提现
  @JsonValue(0)
  withdraw(label: '提现'),

  /// 直接推荐
  @JsonValue(1)
  direct(label: '直接推荐奖励'),

  /// 间接推荐
  @JsonValue(2)
  indirect(label: '间接推荐奖励');

  const CommissionRecordType({
    required this.label,
  });

  /// 显示标签
  final String label;
}

@JsonSerializable()
class CommissionRecord {
  final int id;
  final String? createTime;
  final String? remark;
  final double nowAmount;
  final double preAmount;
  final double changeAmount;
  final int userId;
  final int linkUserId;
  final String orderNo;
  final int promotion;
  @JsonKey(unknownEnumValue: CommissionRecordType.direct)
  final CommissionRecordType level;
  final int type;

  const CommissionRecord({
    required this.id,
    this.createTime,
    this.remark,
    required this.nowAmount,
    required this.preAmount,
    required this.changeAmount,
    required this.userId,
    required this.linkUserId,
    required this.orderNo,
    required this.promotion,
    required this.level,
    required this.type,
  });

  factory CommissionRecord.fromJson(Map<String, dynamic> json) =>
      _$CommissionRecordFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionRecordToJson(this);
}

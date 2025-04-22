import 'package:json_annotation/json_annotation.dart';

part 'invite_record.g.dart';

/// 邀请记录模型
@JsonSerializable()
class InviteRecord {
  /// 用户ID
  final int id;

  /// 手机号
  final String? phone;

  /// 是否是直接邀请 (true=直接推荐, false=间接推荐)
  final bool? dir;

  /// 推广级别 (大于0表示已付费)
  final int? promotion;

  /// 创建时间 (保留字段，实际API未返回)
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? createTime;

  /// 用户ID (与id相同)
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int userId;

  const InviteRecord({
    required this.id,
    this.phone,
    this.dir,
    this.promotion,
    this.createTime,
    int? userId,
  }) : userId = userId ?? id;

  /// 是否是直接邀请
  bool get isDirectInvite => dir == true;

  /// 是否是间接邀请
  bool get isIndirectInvite => dir == false;

  /// 是否已付费
  bool get isPaid => promotion != null && promotion! > 0;

  /// 获取邀请类型显示文本
  String get inviteTypeLabel => isDirectInvite ? '直接邀请' : '间接邀请';

  /// 获取付费状态显示文本
  String get paymentStatusLabel => isPaid ? '已付费' : '未付费';

  factory InviteRecord.fromJson(Map<String, dynamic> json) =>
      _$InviteRecordFromJson(json);

  Map<String, dynamic> toJson() => _$InviteRecordToJson(this);
}

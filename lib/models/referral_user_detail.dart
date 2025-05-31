import 'package:json_annotation/json_annotation.dart';

part 'referral_user_detail.g.dart';

/// 推荐用户详情模型
@JsonSerializable()
class ReferralUserDetail {
  /// 用户ID
  final int id;

  /// 是否是付费用户
  @JsonKey(name: 'payUser')
  final bool isVip;

  /// 手机号
  final String phone;

  /// 推荐总人数
  final int referralCount;

  /// 直接推荐人数
  final int firstCount;

  /// 间接推荐人数
  final int secondCount;

  /// 推广等级
  final int promotion;

  /// 区域代理
  final int areaAgent;

  /// 昵称
  final String? nickName;

  /// 构造函数
  const ReferralUserDetail({
    required this.id,
    required this.isVip,
    required this.phone,
    required this.referralCount,
    required this.firstCount,
    required this.secondCount,
    required this.promotion,
    required this.areaAgent,
    this.nickName,
  });

  /// 从JSON创建实例
  factory ReferralUserDetail.fromJson(Map<String, dynamic> json) =>
      _$ReferralUserDetailFromJson(json);

  /// 转换为JSON
  Map<String, dynamic> toJson() => _$ReferralUserDetailToJson(this);
}

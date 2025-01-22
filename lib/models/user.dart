import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  @JsonKey(name: 'openId')
  final String? openId;
  @JsonKey(name: 'unionId')
  final String? unionId;
  final String? weatherDivination;
  final String? terrainDivination;
  final String? birthDivination;
  final String? knotDivination;
  final String? fortuneDivination;
  final String? birthDate;
  final int? birthTime;
  @JsonKey(name: 'expirationTime')
  final String? expirationTime;
  @JsonKey(name: 'createTime')
  final String? createTime;
  @JsonKey(name: 'payUser')
  final bool? isVip;
  final String? phone;
  final String? wxSessionKey;
  final int referralCount;
  final String? referralCode;
  final String? nickName;
  final String? firstCode;
  final String? secondCode;
  final int? firstUserId;
  final int? secondUserId;
  final int? promotion;
  final double? amount;

  const User({
    this.id,
    this.openId,
    this.unionId,
    this.weatherDivination,
    this.terrainDivination,
    this.birthDivination,
    this.knotDivination,
    this.fortuneDivination,
    this.birthDate,
    this.birthTime,
    this.expirationTime,
    this.createTime,
    this.isVip,
    this.phone,
    this.wxSessionKey,
    this.referralCount = 0,
    this.referralCode,
    this.nickName,
    this.firstCode,
    this.secondCode,
    this.firstUserId,
    this.secondUserId,
    this.promotion,
    this.amount,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    int? id,
    String? openId,
    String? unionId,
    String? weatherDivination,
    String? terrainDivination,
    String? birthDivination,
    String? knotDivination,
    String? fortuneDivination,
    String? birthDate,
    int? birthTime,
    String? expirationTime,
    String? createTime,
    bool? isVip,
    String? phone,
    String? wxSessionKey,
    int? referralCount,
    String? referralCode,
    String? nickName,
    String? firstCode,
    String? secondCode,
    int? firstUserId,
    int? secondUserId,
    int? promotion,
    double? amount,
  }) {
    return User(
      id: id ?? this.id,
      openId: openId ?? this.openId,
      unionId: unionId ?? this.unionId,
      weatherDivination: weatherDivination ?? this.weatherDivination,
      terrainDivination: terrainDivination ?? this.terrainDivination,
      birthDivination: birthDivination ?? this.birthDivination,
      knotDivination: knotDivination ?? this.knotDivination,
      fortuneDivination: fortuneDivination ?? this.fortuneDivination,
      birthDate: birthDate ?? this.birthDate,
      birthTime: birthTime ?? this.birthTime,
      expirationTime: expirationTime ?? this.expirationTime,
      createTime: createTime ?? this.createTime,
      isVip: isVip ?? this.isVip,
      phone: phone ?? this.phone,
      wxSessionKey: wxSessionKey ?? this.wxSessionKey,
      nickName: nickName ?? this.nickName,
      firstCode: firstCode ?? this.firstCode,
      secondCode: secondCode ?? this.secondCode,
      firstUserId: firstUserId ?? this.firstUserId,
      secondUserId: secondUserId ?? this.secondUserId,
      promotion: promotion ?? this.promotion,
      amount: amount ?? this.amount,
    );
  }
}

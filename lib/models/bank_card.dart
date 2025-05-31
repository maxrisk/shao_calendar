import 'package:json_annotation/json_annotation.dart';

part 'bank_card.g.dart';

@JsonSerializable()
class BankCard {
  final String name;
  final String cardNo;
  final String bankName;
  final String subBranchBankName;
  final String idCard;
  final int userId;
  final String createTime;
  final String updateTime;
  final bool isDefault;

  const BankCard({
    required this.name,
    required this.cardNo,
    required this.bankName,
    this.subBranchBankName = '',
    required this.idCard,
    required this.userId,
    required this.createTime,
    required this.updateTime,
    required this.isDefault,
  });

  factory BankCard.fromJson(Map<String, dynamic> json) =>
      _$BankCardFromJson(json);
  Map<String, dynamic> toJson() => _$BankCardToJson(this);
}

@JsonSerializable()
class BankCardResponse {
  final int code;
  final String? msg;
  final BankCard? data;

  const BankCardResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory BankCardResponse.fromJson(Map<String, dynamic> json) =>
      _$BankCardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BankCardResponseToJson(this);
}

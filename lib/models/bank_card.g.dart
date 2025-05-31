// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankCard _$BankCardFromJson(Map<String, dynamic> json) => BankCard(
      name: json['name'] as String,
      cardNo: json['cardNo'] as String,
      bankName: json['bankName'] as String,
      subBranchBankName: json['subBranchBankName'] as String? ?? '',
      idCard: json['idCard'] as String,
      userId: (json['userId'] as num).toInt(),
      createTime: json['createTime'] as String,
      updateTime: json['updateTime'] as String,
      isDefault: json['isDefault'] as bool,
    );

Map<String, dynamic> _$BankCardToJson(BankCard instance) => <String, dynamic>{
      'name': instance.name,
      'cardNo': instance.cardNo,
      'bankName': instance.bankName,
      'subBranchBankName': instance.subBranchBankName,
      'idCard': instance.idCard,
      'userId': instance.userId,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'isDefault': instance.isDefault,
    };

BankCardResponse _$BankCardResponseFromJson(Map<String, dynamic> json) =>
    BankCardResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : BankCard.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BankCardResponseToJson(BankCardResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankModel _$BankModelFromJson(Map<String, dynamic> json) => BankModel(
      id: json['id'] as String?,
      accountId: json['accountId'] as String?,
      accountName: json['accountName'] as String?,
      accountNumber: json['accountNumber'] as String?,
      accountType: json['accountType'] as String?,
      bankName: json['bankName'] as String?,
      bankCode: json['bankCode'] as String?,
      bankLogo: json['bankLogo'] as String?,
      bvn: json['bvn'] as String?,
      userReference: json['userReference'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BankModelToJson(BankModel instance) => <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'accountName': instance.accountName,
      'accountNumber': instance.accountNumber,
      'accountType': instance.accountType,
      'bankName': instance.bankName,
      'bankCode': instance.bankCode,
      'bankLogo': instance.bankLogo,
      'bvn': instance.bvn,
      'userReference': instance.userReference,
      'balance': instance.balance,
    };

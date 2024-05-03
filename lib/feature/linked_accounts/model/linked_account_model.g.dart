// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linked_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkedAccountModel _$LinkedAccountModelFromJson(Map<String, dynamic> json) =>
    LinkedAccountModel(
      numberOfBanks: json['number_of_banks'] as int?,
      banks: (json['banks'] as List<dynamic>?)
          ?.map((e) => BankModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LinkedAccountModelToJson(LinkedAccountModel instance) =>
    <String, dynamic>{
      'number_of_banks': instance.numberOfBanks,
      'banks': instance.banks,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facial_verify_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacialVerify _$FacialVerifyFromJson(Map<String, dynamic> json) => FacialVerify(
      id: json['id'] as String?,
      number: json['number'] as String?,
      verified: json['verified'] as bool?,
      submitted: json['submitted'] as bool?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$FacialVerifyToJson(FacialVerify instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'verified': instance.verified,
      'submitted': instance.submitted,
      'userId': instance.userId,
    };

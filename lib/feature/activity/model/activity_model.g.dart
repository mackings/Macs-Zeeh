// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      id: json['id'] as String?,
      type: json['type'] as String?,
      claimId: json['claimId'] as String?,
      message: json['message'] as String?,
      serviceId: json['serviceId'] as String?,
      offerId: json['offerId'] as String?,
      serviceLogo: json['serviceLogo'] as String?,
      serviceName: json['serviceName'] as String?,
      scopeName: json['scopeName'] as String?,
      createdAt: json['created_at'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      status: (json['status'] as num?)?.toDouble(),
      userReference: json['userReference'] as String?,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'claimId': instance.claimId,
      'message': instance.message,
      'serviceId': instance.serviceId,
      'offerId': instance.offerId,
      'serviceLogo': instance.serviceLogo,
      'serviceName': instance.serviceName,
      'scopeName': instance.scopeName,
      'created_at': instance.createdAt,
      'amount': instance.amount,
      'status': instance.status,
      'userReference': instance.userReference,
    };

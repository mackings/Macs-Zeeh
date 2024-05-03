// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimModel _$ClaimModelFromJson(Map<String, dynamic> json) => ClaimModel(
      userId: json['userId'] as String?,
      serviceId: json['serviceId'] as String?,
      offerId: json['offerId'] as String?,
      approved: json['approved'] as bool?,
      status: json['status'] as String?,
      loanAmount: (json['loanAmount'] as num?)?.toDouble(),
      amountDue: (json['amountDue'] as num?)?.toDouble(),
      amountPaid: (json['amountPaid'] as num?)?.toDouble(),
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ClaimModelToJson(ClaimModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'serviceId': instance.serviceId,
      'offerId': instance.offerId,
      'approved': instance.approved,
      'status': instance.status,
      'loanAmount': instance.loanAmount,
      'amountDue': instance.amountDue,
      'amountPaid': instance.amountPaid,
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

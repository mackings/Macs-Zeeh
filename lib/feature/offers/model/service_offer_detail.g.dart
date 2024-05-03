// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_offer_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceOfferDetail _$ServiceOfferDetailFromJson(Map<String, dynamic> json) =>
    ServiceOfferDetail(
      loanAmount: json['loanAmount'],
      creditWorthiness: json['creditWorthiness'],
      status: json['status'] as String?,
      id: json['_id'] as String?,
      serviceTypeId: json['serviceTypeId'] as String?,
      merchantId: json['merchantId'] as String?,
      serviceId: json['serviceId'] as String?,
      name: json['name'] as String?,
      interest: (json['interest'] as num?)?.toDouble(),
      repaymentPlan: json['repaymentPlan'] as String?,
      duration: (json['duration'] as num?)?.toDouble(),
      cleseDate: json['closeDate'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      version: json['__v'] as int?,
      merchantName: json['merchantName'] as String?,
      merchantLogo: json['merchantLogo'] as String?,
    );

Map<String, dynamic> _$ServiceOfferDetailToJson(ServiceOfferDetail instance) =>
    <String, dynamic>{
      'loanAmount': instance.loanAmount,
      'creditWorthiness': instance.creditWorthiness,
      'status': instance.status,
      '_id': instance.id,
      'serviceTypeId': instance.serviceTypeId,
      'merchantId': instance.merchantId,
      'serviceId': instance.serviceId,
      'name': instance.name,
      'interest': instance.interest,
      'repaymentPlan': instance.repaymentPlan,
      'duration': instance.duration,
      'closeDate': instance.cleseDate,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.version,
      'merchantName': instance.merchantName,
      'merchantLogo': instance.merchantLogo,
    };

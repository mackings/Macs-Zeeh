// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_claim_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveClaimModel _$ActiveClaimModelFromJson(Map<String, dynamic> json) =>
    ActiveClaimModel(
      id: json['id'] as String?,
      claimId: json['claimId'] as String?,
      offerId: json['offerId'] as String?,
      serviceType: json['serviceType'] as String?,
      offerName: json['offerName'] as String?,
      offerImage: json['offerImage'] as String?,
      merchantName: json['merchantName'] as String?,
      serviceLogo: json['serviceLogo'] as String?,
      loanAmount: (json['loanAmount'] as num?)?.toDouble(),
      amountDue: (json['amountDue'] as num?)?.toDouble(),
      amountPaid: (json['amountPaid'] as num?)?.toDouble(),
      duration: json['duration'] as int?,
      dateExpire: json['dateExpire'] as String?,
      approved: json['approved'] as bool?,
      status: json['status'] as int?,
      repaid: json['repaid'] as bool?,
      userId: json['userId'] as String?,
      statusValue: json['statusValue'] as String?,
      interest: (json['interest'] as num?)?.toDouble(),
      repaymentPlan: json['repaymentPlan'] as String?,
      repaymentAmount: (json['repaymentAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ActiveClaimModelToJson(ActiveClaimModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'claimId': instance.claimId,
      'offerId': instance.offerId,
      'serviceType': instance.serviceType,
      'offerName': instance.offerName,
      'offerImage': instance.offerImage,
      'merchantName': instance.merchantName,
      'serviceLogo': instance.serviceLogo,
      'loanAmount': instance.loanAmount,
      'interest': instance.interest,
      'amountDue': instance.amountDue,
      'amountPaid': instance.amountPaid,
      'duration': instance.duration,
      'dateExpire': instance.dateExpire,
      'approved': instance.approved,
      'status': instance.status,
      'repaid': instance.repaid,
      'userId': instance.userId,
      'statusValue': instance.statusValue,
      'repaymentPlan': instance.repaymentPlan,
      'repaymentAmount': instance.repaymentAmount,
    };

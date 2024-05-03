import 'package:json_annotation/json_annotation.dart';

part 'active_claim_model.g.dart';

@JsonSerializable()
class ActiveClaimModel {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "claimId")
  final String? claimId;
  @JsonKey(name: "offerId")
  final String? offerId;
  @JsonKey(name: "serviceType")
  final String? serviceType;
  @JsonKey(name: "offerName")
  final String? offerName;
  @JsonKey(name: "offerImage")
  final String? offerImage;
  @JsonKey(name: "merchantName")
  final String? merchantName;
  @JsonKey(name: "serviceLogo")
  final String? serviceLogo;
  @JsonKey(name: "loanAmount")
  final double? loanAmount;
  @JsonKey(name: "interest")
  final double? interest;
  @JsonKey(name: "amountDue")
  final double? amountDue;
  @JsonKey(name: "amountPaid")
  final double? amountPaid;
  @JsonKey(name: "duration")
  final int? duration;
  @JsonKey(name: "dateExpire")
  final String? dateExpire;
  @JsonKey(name: "approved")
  final bool? approved;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "repaid")
  final bool? repaid;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "statusValue")
  final String? statusValue;
  @JsonKey(name: "repaymentPlan")
  final String? repaymentPlan;
  @JsonKey(name: "repaymentAmount")
  final double? repaymentAmount;

  ActiveClaimModel({
    this.id,
    this.claimId,
    this.offerId,
    this.serviceType,
    this.offerName,
    this.offerImage,
    this.merchantName,
    this.serviceLogo,
    this.loanAmount,
    this.amountDue,
    this.amountPaid,
    this.duration,
    this.dateExpire,
    this.approved,
    this.status,
    this.repaid,
    this.userId,
    this.statusValue,
    this.interest,
    this.repaymentPlan,
    this.repaymentAmount,
  });

  factory ActiveClaimModel.fromJson(Map<String, dynamic> json) => _$ActiveClaimModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveClaimModelToJson(this);
}

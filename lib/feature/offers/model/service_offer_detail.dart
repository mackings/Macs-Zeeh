import 'package:json_annotation/json_annotation.dart';

part 'service_offer_detail.g.dart';

@JsonSerializable()
class ServiceOfferDetail {
  @JsonKey(name: "loanAmount")
  final dynamic loanAmount;

  @JsonKey(name: "creditWorthiness")
  final dynamic creditWorthiness;

  @JsonKey(name: "status")
  final String? status;

  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "serviceTypeId")
  final String? serviceTypeId;

  @JsonKey(name: "merchantId")
  final String? merchantId;

  @JsonKey(name: "serviceId")
  final String? serviceId;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "interest")
  final double? interest;

  @JsonKey(name: "repaymentPlan")
  final String? repaymentPlan;

  @JsonKey(name: "duration")
  final double? duration;

  @JsonKey(name: "closeDate")
  final String? cleseDate;

  @JsonKey(name: "image")
  final String? image;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  @JsonKey(name: "__v")
  final int? version;

  @JsonKey(name: "merchantName")
  final String? merchantName;

  @JsonKey(name: "merchantLogo")
  final String? merchantLogo;



  ServiceOfferDetail({
    this.loanAmount,
    this.creditWorthiness,
    this.status,
    this.id,
    this.serviceTypeId,
    this.merchantId,
    this.serviceId,
    this.name,
    this.interest,
    this.repaymentPlan,
    this.duration,
    this.cleseDate,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.merchantName,
    this.merchantLogo,
  
  });

  factory ServiceOfferDetail.fromJson(Map<String, dynamic> json) =>
      _$ServiceOfferDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceOfferDetailToJson(this);
}

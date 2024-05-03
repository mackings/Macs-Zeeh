import 'package:json_annotation/json_annotation.dart';

part 'claim_response_model.g.dart';

@JsonSerializable()
class ClaimModel {
  

  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "serviceId")
  final String? serviceId;
  @JsonKey(name: "offerId")
  final String? offerId;
  @JsonKey(name: "approved")
  final bool? approved;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "loanAmount")
  final double? loanAmount;
  @JsonKey(name: "amountDue")
  final double? amountDue;
  @JsonKey(name: "amountPaid")
  final double? amountPaid;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final double? v;
  

  ClaimModel({
    this.userId,
    this.serviceId,
    this.offerId,
    this.approved,
    this.status,
    this.loanAmount,
    this.amountDue,
    this.amountPaid,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ClaimModel.fromJson(Map<String, dynamic> json) =>
      _$ClaimModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimModelToJson(this);
}

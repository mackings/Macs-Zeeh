import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "claimId")
  final String? claimId;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "serviceId")
  final String? serviceId;
  @JsonKey(name: "offerId")
  final String? offerId;
  @JsonKey(name: "serviceLogo")
  final String? serviceLogo;
  @JsonKey(name: "serviceName")
  final String? serviceName;
  @JsonKey(name: "scopeName")
  final String? scopeName;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "amount")
  final double? amount;
  @JsonKey(name: "status")
  final double? status;
  @JsonKey(name: "userReference")
  final String? userReference;

  ActivityModel({
    this.id,
    this.type,
    this.claimId,
    this.message,
    this.serviceId,
    this.offerId,
    this.serviceLogo,
    this.serviceName,
    this.scopeName,
    this.createdAt,
    this.amount,
    this.status,
    this.userReference,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) => 
    _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}

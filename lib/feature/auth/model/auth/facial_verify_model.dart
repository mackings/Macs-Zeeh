import 'package:json_annotation/json_annotation.dart';

part 'facial_verify_model.g.dart';

@JsonSerializable()
class FacialVerify {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "number")
  final String? number;

  @JsonKey(name: "verified")
  final bool? verified;

  @JsonKey(name: "submitted")
  final bool? submitted;

  @JsonKey(name: "userId")
  final String? userId;

  FacialVerify({
    this.id,
    this.number,
    this.verified,
    this.submitted,
    this.userId,
  });

  factory FacialVerify.fromJson(Map<String, dynamic> json) =>
      _$FacialVerifyFromJson(json);

  Map<String, dynamic> toJson() => _$FacialVerifyToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'user_details.g.dart';

@JsonSerializable()
class UserDetails {
  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "first_name")
  final String? firstName;

  @JsonKey(name: "last_name")
  final String? lastName;

  @JsonKey(name: "phone_num")
  final String? phoneNumber;

  @JsonKey(name: "verified")
  final bool? verified;

  @JsonKey(name: "biometrics")
  final bool? biometrics;

  @JsonKey(name: "address")
  final String? address;

  @JsonKey(name: "state")
  final String? state;

  @JsonKey(name: "country")
  final String? country;

  @JsonKey(name: "dob")
  final String? dob;

  @JsonKey(name: "gender")
  final String? gender;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  @JsonKey(name: "bvnAttached")
  final bool? bvnAttached;

  @JsonKey(name: "bvnVerified")
  final bool? bvnVerified;

  @JsonKey(name: "image_url")
  final String? imageUrl;

  @JsonKey(name: "bvn")
  final String? bvn;

  @JsonKey(name: "numberOfBanks")
  final int? numberOfBanks;

  UserDetails({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.verified,
    this.biometrics,
    this.address,
    this.state,
    this.country,
    this.dob,
    this.gender,
    this.createdAt,
    this.bvnAttached,
    this.bvnVerified,
    this.imageUrl,
    this.bvn,
    this.numberOfBanks,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:zeeh_mobile/constants/hive_constants.dart';

part 'authenticated_user.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveConstants.authCredentialHiveId)
class AuthenticatedUser {
  @JsonKey(name: 'id')
  @HiveField(0)
  final String? userId;

  @JsonKey(name: 'first_name')
  @HiveField(1)
  final String? firstName;

  @JsonKey(name: 'last_name')
  @HiveField(2)
  final String? lastName;

  @JsonKey(name: 'phone_num')
  @HiveField(3)
  final String? phoneNumber;

  @JsonKey(name: 'email')
  @HiveField(4)
  final String? email;

  @JsonKey(name: 'access_token')
  final String? token;

  @JsonKey(name: 'verified')
  final bool? verified;

  AuthenticatedUser({
    this.firstName,
    this.lastName, 
    this.userId,
     this.email,
    this.token,
    this.phoneNumber,
    this.verified,
  });

  

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatedUserToJson(this);
}

enum SignInProvider {
  google,
  facebook,
  twitter,
  apple,
}

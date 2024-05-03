import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:zeeh_mobile/constants/hive_constants.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/authenticated_user.dart';

part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveConstants.userHiveId)
class User {
  @HiveField(0)
  @JsonKey(name: 'token')
  final String? token;

  @HiveField(1)
  @JsonKey(name: 'access_token')
  final String? accessToken;

  @HiveField(2)
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  @HiveField(3)
  @JsonKey(name: 'user')
  final AuthenticatedUser? user;

 

  

  User({
    this.token,
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

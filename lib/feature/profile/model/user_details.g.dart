// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      id: json['id'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_num'] as String?,
      verified: json['verified'] as bool?,
      biometrics: json['biometrics'] as bool?,
      address: json['address'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      dob: json['dob'] as String?,
      gender: json['gender'] as String?,
      createdAt: json['createdAt'] as String?,
      bvnAttached: json['bvnAttached'] as bool?,
      bvnVerified: json['bvnVerified'] as bool?,
      imageUrl: json['image_url'] as String?,
      bvn: json['bvn'] as String?,
      numberOfBanks: json['numberOfBanks'] as int?,
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_num': instance.phoneNumber,
      'verified': instance.verified,
      'biometrics': instance.biometrics,
      'address': instance.address,
      'state': instance.state,
      'country': instance.country,
      'dob': instance.dob,
      'gender': instance.gender,
      'createdAt': instance.createdAt,
      'bvnAttached': instance.bvnAttached,
      'bvnVerified': instance.bvnVerified,
      'image_url': instance.imageUrl,
      'bvn': instance.bvn,
      'numberOfBanks': instance.numberOfBanks,
    };

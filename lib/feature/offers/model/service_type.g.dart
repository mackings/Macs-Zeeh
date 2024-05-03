// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceType _$ServiceTypeFromJson(Map<String, dynamic> json) => ServiceType(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      scopes: json['scopes'] as List<dynamic>?,
      version: json['__v'] as int?,
    );

Map<String, dynamic> _$ServiceTypeToJson(ServiceType instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'scopes': instance.scopes,
      '__v': instance.version,
    };

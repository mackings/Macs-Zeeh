import 'package:json_annotation/json_annotation.dart';

part 'service_type.g.dart';

@JsonSerializable()
class ServiceType {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "scopes")
  final List? scopes;
  @JsonKey(name: "__v")
  final int? version;

  ServiceType({
    this.id,
    this.name,
    this.description,
    this.scopes,
    this.version,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) => _$ServiceTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceTypeToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:zeeh_mobile/feature/linked_accounts/model/bank_model.dart';

part 'linked_account_model.g.dart';

@JsonSerializable()
class LinkedAccountModel {
  @JsonKey(name: "number_of_banks")
  final int? numberOfBanks;

  @JsonKey(name: "banks")
  final List<BankModel>? banks;

  LinkedAccountModel({
    this.numberOfBanks,
    this.banks,
  });

  factory LinkedAccountModel.fromJson(Map<String, dynamic> json) => _$LinkedAccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinkedAccountModelToJson(this);
}

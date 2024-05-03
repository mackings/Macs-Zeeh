import 'package:json_annotation/json_annotation.dart';

part 'bank_model.g.dart';

@JsonSerializable()
class BankModel {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "accountId")
  final String? accountId;
  @JsonKey(name: "accountName")
  final String? accountName;
  @JsonKey(name: "accountNumber")
  final String? accountNumber;
  @JsonKey(name: "accountType")
  final String? accountType;
  @JsonKey(name: "bankName")
  final String? bankName;
  @JsonKey(name: "bankCode")
  final String? bankCode;
  @JsonKey(name: "bankLogo")
  final String? bankLogo;
  @JsonKey(name: "bvn")
  final String? bvn;
  @JsonKey(name: "userReference")
  final String? userReference;
  @JsonKey(name: "balance")
  final double? balance;

  BankModel({
    this.id,
    this.accountId,
    this.accountName,
    this.accountNumber,
    this.accountType,
    this.bankName,
    this.bankCode,
    this.bankLogo,
    this.bvn,
    this.userReference,
    this.balance,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => _$BankModelFromJson(json);

  Map<String, dynamic> toJson() => _$BankModelToJson(this);
}

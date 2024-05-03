import 'package:json_annotation/json_annotation.dart';

part 'credit_report_model.g.dart';

@JsonSerializable()
class CreditReportModel {
  @JsonKey(name: "salaryConfidenceLevel")
  final double? salaryConfidenceLevel;
  @JsonKey(name: "salaryEarner")
  final bool? salaryEarner;
  @JsonKey(name: "medianIncome")
  final double? medianIncome;
  @JsonKey(name: "averageOfOtherIncome")
  final double? averageOfOtherIncome;
  @JsonKey(name: "expectedSalaryDay")
  final double? expectedSalaryDay;
  @JsonKey(name: "lastSalaryDate")
  final String? lastSalaryDate;
  @JsonKey(name: "averageSalary")
  final double? averageSalary;
  @JsonKey(name: "salaryFrequencyInDays")
  final int? salaryFrequencyInDays;
  @JsonKey(name: "numberOfSalaryPayments")
  final int? numberOfSalaryPayments;
  @JsonKey(name: "numberOfOtherIncomePayments")
  final int? numberOfOtherIncomePayments;

  CreditReportModel({
    this.salaryConfidenceLevel,
    this.salaryEarner,
    this.medianIncome,
    this.averageOfOtherIncome,
    this.expectedSalaryDay,
    this.lastSalaryDate,
    this.averageSalary,
    this.salaryFrequencyInDays,
    this.numberOfSalaryPayments,
    this.numberOfOtherIncomePayments,
  });

  factory CreditReportModel.fromJson(Map<String, dynamic> json) =>
      _$CreditReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreditReportModelToJson(this);
}

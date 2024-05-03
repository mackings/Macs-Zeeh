// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditReportModel _$CreditReportModelFromJson(Map<String, dynamic> json) =>
    CreditReportModel(
      salaryConfidenceLevel:
          (json['salaryConfidenceLevel'] as num?)?.toDouble(),
      salaryEarner: json['salaryEarner'] as bool?,
      medianIncome: (json['medianIncome'] as num?)?.toDouble(),
      averageOfOtherIncome: (json['averageOfOtherIncome'] as num?)?.toDouble(),
      expectedSalaryDay: (json['expectedSalaryDay'] as num?)?.toDouble(),
      lastSalaryDate: json['lastSalaryDate'] as String?,
      averageSalary: (json['averageSalary'] as num?)?.toDouble(),
      salaryFrequencyInDays: json['salaryFrequencyInDays'] as int?,
      numberOfSalaryPayments: json['numberOfSalaryPayments'] as int?,
      numberOfOtherIncomePayments: json['numberOfOtherIncomePayments'] as int?,
    );

Map<String, dynamic> _$CreditReportModelToJson(CreditReportModel instance) =>
    <String, dynamic>{
      'salaryConfidenceLevel': instance.salaryConfidenceLevel,
      'salaryEarner': instance.salaryEarner,
      'medianIncome': instance.medianIncome,
      'averageOfOtherIncome': instance.averageOfOtherIncome,
      'expectedSalaryDay': instance.expectedSalaryDay,
      'lastSalaryDate': instance.lastSalaryDate,
      'averageSalary': instance.averageSalary,
      'salaryFrequencyInDays': instance.salaryFrequencyInDays,
      'numberOfSalaryPayments': instance.numberOfSalaryPayments,
      'numberOfOtherIncomePayments': instance.numberOfOtherIncomePayments,
    };

part of 'credit_state_notifier.dart';

class CreditState {}

class CreditInitial extends CreditState {}

class GetCreditScoreLoading extends CreditState {}

class GetCreditScoreFailure extends CreditState {
  final Failure failure;

  GetCreditScoreFailure(this.failure);
}

class GetCreditScoreSuccess extends CreditState {
  final ResponseModel responseModel;

  GetCreditScoreSuccess(this.responseModel);
}

class GetCreditReportLoading extends CreditState {}

class GetCreditReportFailure extends CreditState {
  final Failure failure;

  GetCreditReportFailure(this.failure);
}

class GetCreditReportSuccess extends CreditState {
  final CreditReportModel creditReportModel;

  GetCreditReportSuccess(this.creditReportModel);
}

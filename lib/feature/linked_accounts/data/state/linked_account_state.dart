part of 'linked_account_state_notifier.dart';

class LinkedAccountState {}

class LinkedAccountInitial extends LinkedAccountState {}

// Unlink Bank States
class UnlinkBankLoading extends LinkedAccountState {}

class UnlinkBankFailure extends LinkedAccountState {
  final Failure failure;

  UnlinkBankFailure(this.failure);
}

class UnlinkBankSuccess extends LinkedAccountState {
  final ResponseModel responseModel;

  UnlinkBankSuccess(this.responseModel);
}

// Bank Details States
class BankDetailsLoading extends LinkedAccountState {}

class BankDetailsFailure extends LinkedAccountState {
  final Failure failure;

  BankDetailsFailure(this.failure);
}

class BankDetailsSuccess extends LinkedAccountState {
  final ResponseModel responseModel;

  BankDetailsSuccess(this.responseModel);
}

// All Bank States
class AllBankLoading extends LinkedAccountState {}

class AllBankFailure extends LinkedAccountState {
  final Failure failure;

  AllBankFailure(this.failure);
}

class AllBankSuccess extends LinkedAccountState {
  final LinkedAccountModel linkedAccount;

  AllBankSuccess(this.linkedAccount);
}

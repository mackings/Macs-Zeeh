part of 'profile_state_notifier.dart';

class ProfileState {}

class ProfileInitial extends ProfileState {}

// Log In States
class UserDetailsLoading extends ProfileState {}

class UserDetailsFailure extends ProfileState {
  final Failure failure;

  UserDetailsFailure(this.failure);
}

class UserDetailsSuccess extends ProfileState {
  final UserDetails userDetails;

  UserDetailsSuccess(this.userDetails);
}

// Delete Account State
class DeleteAccountLoading extends ProfileState {}

class DeleteAccountFailure extends ProfileState {
  final Failure failure;

  DeleteAccountFailure(this.failure);
}

class DeleteAccountSuccess extends ProfileState {
  final ResponseModel responseModel;

  DeleteAccountSuccess(this.responseModel);

}
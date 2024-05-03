part of 'auth_notifier.dart';

class AuthState {}

class AuthInitial extends AuthState {}

// Log In States
class LogInLoadingState extends AuthState {}

class LogInFailureState extends AuthState {
  final Failure failure;

  LogInFailureState(this.failure);
}

class LogInSuccessState extends AuthState {
  final User user;

  LogInSuccessState(this.user);
}

// Register State
class RegisterLoadingState extends AuthState {}

class RegisterFailureState extends AuthState {
  final Failure failure;

  RegisterFailureState(this.failure);
}

class RegisterSuccessState extends AuthState {
  final User user;

  RegisterSuccessState(this.user);
}

// Account Verification
class AccountVerificationLoading extends AuthState {}

class AccountVerificationFailure extends AuthState {
  final Failure failure;

  AccountVerificationFailure(this.failure);
}

class AccountVerificationSuccess extends AuthState {
  final AuthenticatedUser authUser;

  AccountVerificationSuccess(this.authUser);
}

// Resend Verification State
class ResendVerificationLoading extends AuthState {}

class ResendVerificationFailure extends AuthState {
  final Failure failure;

  ResendVerificationFailure(this.failure);
}

class ResendVerificationSuccess extends AuthState {
  final ResponseModel responseModel;

  ResendVerificationSuccess(this.responseModel);
}

// Check Account State
class CheckAccountLoading extends AuthState {}

class CheckAccountFailure extends AuthState {
  final Failure failure;

  CheckAccountFailure(this.failure);
}

class CheckAccountSuccess extends AuthState {
  final ResponseModel responseModel;

  CheckAccountSuccess(this.responseModel);
}

// Pin State

// Create Pin
class CreatePinLoading extends AuthState {}

class CreatePinFailure extends AuthState {
  final Failure failure;

  CreatePinFailure(this.failure);
}

class CreatePinSuccess extends AuthState {
  final AuthenticatedUser authenticatedUser;

  CreatePinSuccess(this.authenticatedUser);
}

// Reset Pin
class ResetPinLoading extends AuthState {}

class ResetPinFailure extends AuthState {
  final Failure failure;

  ResetPinFailure(this.failure);
}

class ResetPinSuccess extends AuthState {
  final ResponseModel responseModel;

  ResetPinSuccess(this.responseModel);
}

// Forgot Pin
class ForgotPinLoading extends AuthState {}

class ForgotPinFailure extends AuthState {
  final Failure failure;

  ForgotPinFailure(this.failure);
}

class ForgotPinSuccess extends AuthState {
  final ResponseModel responseModel;

  ForgotPinSuccess(this.responseModel);
}

// Resend Verification Pin
class ResendVerificationPinLoading extends AuthState {}

class ResendVerificationPinFailure extends AuthState {
  final Failure failure;

  ResendVerificationPinFailure(this.failure);
}

class ResendVerificationPinSuccess extends AuthState {
  final ResponseModel responseModel;

  ResendVerificationPinSuccess(this.responseModel);
}

// Verify Code
class VerifyCodeLoading extends AuthState {}

class VerifyCodeFailure extends AuthState {
  final Failure failure;

  VerifyCodeFailure(this.failure);
}

class VerifyCodeSuccess extends AuthState {
  final ResponseModel responseModel;

  VerifyCodeSuccess(this.responseModel);
}

// Enable Biometric
class EnableBiometricLoading extends AuthState {}

class EnableBiometricFailure extends AuthState {
  final Failure failure;

  EnableBiometricFailure(this.failure);
}

class EnableBiometricSuccess extends AuthState {
  final ResponseModel responseModel;

  EnableBiometricSuccess(this.responseModel);
}

// Bio Login
class BioLoginLoading extends AuthState {}

class BioLoginFailure extends AuthState {
  final Failure failure;

  BioLoginFailure(this.failure);
}

class BioLoginSuccess extends AuthState {
  final ResponseModel responseModel;

  BioLoginSuccess(this.responseModel);
}

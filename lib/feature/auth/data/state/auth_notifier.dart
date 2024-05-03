import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/feature/auth/data/repository/auth_repository.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/authenticated_user.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/log_in_item.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/user.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/provider.dart';

part 'auth_states.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthStateNotifier(Ref ref)
      : _authRepository = ref.read(authRepositoryProvider),
        super(AuthInitial());

  // Auth

  // Login
  Future<void> login(
    String email,
    String pin,
  ) async {
    state = LogInLoadingState();

    final loginOrError = await _authRepository.login(
      email,
      pin,
    );

    state = loginOrError.fold(
      (l) => LogInFailureState(l),
      (r) => LogInSuccessState(r),
    );
  }

  // Account Verification
  Future<void> accountVerification(
    String code,
  ) async {
    state = AccountVerificationLoading();

    final loginOrError = await _authRepository.accountVerification(
      code,
    );

    state = loginOrError.fold(
      (l) => AccountVerificationFailure(l),
      (r) => AccountVerificationSuccess(r),
    );
  }

  Future<void> resendVerification(
    String email,
  ) async {
    state = ResendVerificationLoading();

    final loginOrError = await _authRepository.resendVerificationCode(
      email,
    );

    state = loginOrError.fold(
      (l) => ResendVerificationFailure(l),
      (r) => ResendVerificationSuccess(r),
    );
  }

  // Create Pin
  Future<void> createPin(String pin, {String? token}) async {
    state = CreatePinLoading();

    final loginOrError = await _authRepository.createPin(
      pin,
      token: token,
    );

    state = loginOrError.fold(
      (l) => CreatePinFailure(l),
      (r) => CreatePinSuccess(r),
    );
  }

  // Reset Pin
  Future<void> resetPin(String pin, String accessToken) async {
    state = ResetPinLoading();

    final loginOrError = await _authRepository.resetPin(pin, accessToken);

    state = loginOrError.fold(
      (l) => ResetPinFailure(l),
      (r) => ResetPinSuccess(r),
    );
  }

  Future<void> forgotPin(
    String email,
  ) async {
    state = ForgotPinLoading();

    final loginOrError = await _authRepository.forgotPin(email);

    state = loginOrError.fold(
      (l) => ForgotPinFailure(l),
      (r) => ForgotPinSuccess(r),
    );
  }

  Future<void> resendForgotPin(
    String email,
  ) async {
    state = ResendVerificationPinLoading();

    final loginOrError = await _authRepository.resendForgotPin(
      email,
    );

    state = loginOrError.fold(
      (l) => ResendVerificationPinFailure(l),
      (r) => ResendVerificationPinSuccess(r),
    );
  }

  // Code
  Future<void> verifyCode(String code) async {
    state = VerifyCodeLoading();

    final loginOrError = await _authRepository.verifyCode(
      code,
    );

    state = loginOrError.fold(
      (l) => VerifyCodeFailure(l),
      (r) => VerifyCodeSuccess(r),
    );
  }

  // Enable Biometric
  Future<void> enableBiometric(bool status) async {
    state = EnableBiometricLoading();

    final loginOrError = await _authRepository.enableBiometric(
      status,
    );

    state = loginOrError.fold(
      (l) => EnableBiometricFailure(l),
      (r) => EnableBiometricSuccess(r),
    );
  }

  // Bio Login
  Future<void> bioLogin(String token) async {
    state = BioLoginLoading();

    final loginOrError = await _authRepository.bioLogin(token);

    state = loginOrError.fold(
      (l) => BioLoginFailure(l),
      (r) => BioLoginSuccess(r),
    );
  }
}

class RegisterUserStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  RegisterUserStateNotifier(Ref ref)
      : _authRepository = ref.read(authRepositoryProvider),
        super(AuthInitial());

  Future<void> setStateInitiate() async {
    state = AuthInitial();
  }

  // Auth

  // Register
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String fcm,
  }) async {
    state = RegisterLoadingState();

    final loginOrError = await _authRepository.register(
      registerItem: RegisterItem(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        fcm: fcm,
      ),
    );

    state = loginOrError.fold(
      (l) => RegisterFailureState(l),
      (r) => RegisterSuccessState(r),
    );
  }
}

class CheckAccountStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  CheckAccountStateNotifier(Ref ref)
      : _authRepository = ref.read(authRepositoryProvider),
        super(AuthInitial());

  Future<void> checkAccount(
    String email,
  ) async {
    state = CheckAccountLoading();

    final loginOrError = await _authRepository.checkAccount(
      email,
    );

    state = loginOrError.fold(
      (l) => CheckAccountFailure(l),
      (r) => CheckAccountSuccess(r),
    );
  }
}

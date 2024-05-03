import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/profile/data/repository/profile_repository.dart';
import 'package:zeeh_mobile/feature/profile/model/user_details.dart';
import 'package:zeeh_mobile/feature/provider.dart';

part 'profile_state.dart';

class ProfileStateNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileStateNotifier(Ref ref)
      : _profileRepository = ref.read(profileRepositoryProvider),
        super(ProfileInitial());

  // Profile

  // User Details
  Future<void> userDetails() async {
    state = UserDetailsLoading();

    final loginOrError = await _profileRepository.userDetails();

    state = loginOrError.fold(
      (l) => UserDetailsFailure(l),
      (r) => UserDetailsSuccess(r),
    );
  }

  // Delete Account
  Future<void> deleteAccount() async {
    state = DeleteAccountLoading();

    final loginOrError = await _profileRepository.deleteAccount();

    state = loginOrError.fold(
      (l) => DeleteAccountFailure(l),
      (r) => DeleteAccountSuccess(r),
    );
  }
}

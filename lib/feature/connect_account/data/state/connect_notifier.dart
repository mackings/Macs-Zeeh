import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/facial_verify_model.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/connect_account/data/repository/connect_repository.dart';
import 'package:zeeh_mobile/feature/provider.dart';

part 'connect_states.dart';

class ConnectStateNotifier extends StateNotifier<ConnectState> {
  final ConnectRepository _connectRepository;

  ConnectStateNotifier(Ref ref)
      : _connectRepository = ref.read(connectRepositoryProvider),
        super(AuthInitial());

  // Connect

  // BVN Lookup
  Future<void> bvnLookup(
    String bvn,
    bool isSignUp,
  ) async {
    state = BVNLookupLoadingState();

    final loginOrError = await _connectRepository.bvnLookup(
      bvn,
      isSignUp,
    );

    state = loginOrError.fold(
      (l) => BVNLookupFailureState(l),
      (r) => BVNLookupSuccessState(r),
    );
  }

 

  Future<void> uploadImage(
    String bvn,
    File image,
    bool isSignUp,
  ) async {
    state = ImageUploadLoading();

    final loginOrError = await _connectRepository.uploadImage(bvn, image, isSignUp);

    state = loginOrError.fold(
      (l) => ImageUploadFailure(l),
      (r) => ImageUploadSuccess(r),
    );
  }


}

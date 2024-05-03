import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/linked_accounts/data/repository/linked_account_repository.dart';
import 'package:zeeh_mobile/feature/linked_accounts/model/linked_account_model.dart';
import 'package:zeeh_mobile/feature/provider.dart';

part 'linked_account_state.dart';

class LinkedAccountStateNotifier extends StateNotifier<LinkedAccountState> {
  final LinkedAccountRepository _linkedAccountRepository;

  LinkedAccountStateNotifier(Ref ref)
      : _linkedAccountRepository = ref.read(linkedAccountRepositoryProvider),
        super(LinkedAccountInitial());

  // Bank Details
  Future<void> bankDetails(
    String bankId,
  ) async {
    state = BankDetailsLoading();

    final loginOrError = await _linkedAccountRepository.bankDetails(bankId);

    state = loginOrError.fold(
      (l) => BankDetailsFailure(l),
      (r) => BankDetailsSuccess(r),
    );
  }

  // All Bank
  Future<void> allBanks() async {
    state = AllBankLoading();

    final loginOrError = await _linkedAccountRepository.allBanks();

    state = loginOrError.fold(
      (l) => AllBankFailure(l),
      (r) => AllBankSuccess(r),
    );
  }
}

class UnlinkAccountStateNotifier extends StateNotifier<LinkedAccountState> {
  final LinkedAccountRepository _linkedAccountRepository;

  UnlinkAccountStateNotifier(Ref ref)
      : _linkedAccountRepository = ref.read(linkedAccountRepositoryProvider),
        super(LinkedAccountInitial());

  // Auth

  // Unlinl Bank
  Future<void> unlinkBank(
    String bankId,
  ) async {
    state = UnlinkBankLoading();

    final loginOrError = await _linkedAccountRepository.unlinkBank(bankId);

    state = loginOrError.fold(
      (l) => UnlinkBankFailure(l),
      (r) => UnlinkBankSuccess(r),
    );
  }
}

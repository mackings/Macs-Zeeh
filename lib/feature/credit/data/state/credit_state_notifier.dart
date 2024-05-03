import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/credit/data/repository/credit_repository.dart';
import 'package:zeeh_mobile/feature/credit/model/credit_report_model.dart';
import 'package:zeeh_mobile/feature/provider.dart';

part 'credit_state.dart';

class CreditStateNotifier extends StateNotifier<CreditState> {
  final CreditRepository _creditRepository;

  CreditStateNotifier(Ref ref)
      : _creditRepository = ref.read(creditRepositoryProvider),
        super(CreditInitial());

  Future<void> getCreditScore() async {
    state = GetCreditScoreLoading();

    final getCreditOrError = await _creditRepository.getCreditScore();

    state = getCreditOrError.fold(
      (l) => GetCreditScoreFailure(l),
      (r) => GetCreditScoreSuccess(r),
    );
  }
}

class CreditReportStateNotifier extends StateNotifier<CreditState> {
  final CreditRepository _creditRepository;

  CreditReportStateNotifier(Ref ref)
      : _creditRepository = ref.read(creditRepositoryProvider),
        super(CreditInitial());

  Future<void> getCreditReport() async {
    state = GetCreditReportLoading();

    final getCreditOrError = await _creditRepository.getCreditReport();

    state = getCreditOrError.fold(
      (l) => GetCreditReportFailure(l),
      (r) => GetCreditReportSuccess(r),
    );
  }
}

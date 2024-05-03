import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/constants/error_strings.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/core/network_info/network_info.dart';
import 'package:zeeh_mobile/core/runner/service.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/linked_accounts/data/source/linked_account_remote_source.dart';
import 'package:zeeh_mobile/feature/linked_accounts/model/linked_account_model.dart';
import 'package:zeeh_mobile/feature/provider.dart';

abstract class LinkedAccountRepository {
  // Linked Account
  Future<Either<Failure, ResponseModel>> unlinkBank(String bankId);
  Future<Either<Failure, ResponseModel>> bankDetails(String bankId);
  Future<Either<Failure, LinkedAccountModel>> allBanks();
}

class LinkedAccountRepositoryImpl implements LinkedAccountRepository {
  final NetworkInfo _networkInfo;
  final LinkedAccountRemoteDataSource _linkedAccountRemoteDataSource;

  LinkedAccountRepositoryImpl({required Ref ref})
      : _linkedAccountRemoteDataSource =
            ref.read(linkedAccountRemoteSourceProvider),
        _networkInfo = ref.read(networkInfoProvider);

  // Unlink Bank
  @override
  Future<Either<Failure, ResponseModel>> unlinkBank(String bankId) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _linkedAccountRemoteDataSource.unlinkBank(bankId),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, ResponseModel>> bankDetails(String bankId) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _linkedAccountRemoteDataSource.bankDetails(bankId),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, LinkedAccountModel>> allBanks() async {
    ServiceRunner<Failure, LinkedAccountModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _linkedAccountRemoteDataSource.allBanks(),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }
}

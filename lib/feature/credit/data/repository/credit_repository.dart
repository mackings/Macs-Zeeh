import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/constants/error_strings.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/core/network_info/network_info.dart';
import 'package:zeeh_mobile/core/runner/service.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/credit/data/source/credit_remote_source.dart';
import 'package:zeeh_mobile/feature/provider.dart';

import '../../model/credit_report_model.dart';

abstract class CreditRepository {
  Future<Either<Failure, ResponseModel>> getCreditScore();
  Future<Either<Failure, CreditReportModel>> getCreditReport();
}

class CreditRepositoryImpl implements CreditRepository {
  final NetworkInfo _networkInfo;
  final CreditRemoteSource _creditRemoteSource;

  CreditRepositoryImpl({required Ref ref})
      : _creditRemoteSource = ref.read(creditRemoteSourceProvider),
        _networkInfo = ref.read(networkInfoProvider);

  @override
  Future<Either<Failure, ResponseModel>> getCreditScore() async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _creditRemoteSource.getCreditScore(),
      errorTitle: ErrorStrings.TIMEOUT_ERROR,
    );
  }

  @override
  Future<Either<Failure, CreditReportModel>> getCreditReport() async {
    ServiceRunner<Failure, CreditReportModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _creditRemoteSource.getCreditReport(),
      errorTitle: ErrorStrings.TIMEOUT_ERROR,
    );
  }
}

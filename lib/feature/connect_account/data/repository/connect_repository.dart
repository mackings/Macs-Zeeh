import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/constants/error_strings.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/core/network_info/network_info.dart';
import 'package:zeeh_mobile/core/runner/service.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/facial_verify_model.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/connect_account/data/source/remote_source.dart';
import 'package:zeeh_mobile/feature/provider.dart';

abstract class ConnectRepository {
  // BVN
  Future<Either<Failure, ResponseModel>> bvnLookup(String bvn, bool isSignUp);
  Future<Either<Failure, ResponseModel>> facialVerify(String bvn, String image);
  Future<Either<Failure, FacialVerify>> uploadImage(String bvn, File file, bool isSignUp);

  // Banks
  Future<Either<Failure, ResponseModel>> unlinkBank(String bankId);
  Future<Either<Failure, ResponseModel>> bankDetails(String bankId);
  Future<Either<Failure, ResponseModel>> allbanks();
}

class ConnectRepositoryImpl implements ConnectRepository {
  final NetworkInfo _networkInfo;
  final ConnectRemoteDataSource _connectRemoteDataSource;

  ConnectRepositoryImpl({required Ref ref})
      : _connectRemoteDataSource = ref.read(connectRemoteSourceProvider),
        _networkInfo = ref.read(networkInfoProvider);

  // BVN Lookup
  @override
  Future<Either<Failure, ResponseModel>> bvnLookup(String bvn, bool isSignUp) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _connectRemoteDataSource.bvnLookup(bvn, isSignUp),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  // Facial Verification
  @override
  Future<Either<Failure, ResponseModel>> facialVerify(
      String bvn, String image) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _connectRemoteDataSource.facialVerify(image, bvn),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, FacialVerify>> uploadImage(
      String bvn, File file, bool isSignUp) async {
    ServiceRunner<Failure, FacialVerify> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _connectRemoteDataSource.uploadImage(bvn, file, isSignUp),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  // Banks
  @override
  Future<Either<Failure, ResponseModel>> unlinkBank(String bankId) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _connectRemoteDataSource.unlinkBank(bankId),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, ResponseModel>> bankDetails(String bankId) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _connectRemoteDataSource.bankDetails(bankId),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, ResponseModel>> allbanks() async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _connectRemoteDataSource.allbanks(),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }
}

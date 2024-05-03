import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/constants/error_strings.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/core/network_info/network_info.dart';
import 'package:zeeh_mobile/core/runner/service.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/profile/data/source/profile_remote_source.dart';
import 'package:zeeh_mobile/feature/profile/model/user_details.dart';
import 'package:zeeh_mobile/feature/provider.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserDetails>> userDetails();
  Future<Either<Failure, ResponseModel>> deleteAccount();

}

class ProfileRepositoryImpl implements ProfileRepository {
  final NetworkInfo _networkInfo;
  final ProfileRemoteDataSource _profileRemoteDataSource;

  ProfileRepositoryImpl({required Ref ref})
      : _profileRemoteDataSource = ref.read(profileRemoteSourceProvider),
        _networkInfo = ref.read(networkInfoProvider);

  // Auth
  @override
  Future<Either<Failure, UserDetails>> userDetails() async {
    ServiceRunner<Failure, UserDetails> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _profileRemoteDataSource.userDetails(),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, ResponseModel>> deleteAccount() async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _profileRemoteDataSource.deleteAccount(),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }
}

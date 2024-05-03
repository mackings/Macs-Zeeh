import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/constants/error_strings.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/core/network_info/network_info.dart';
import 'package:zeeh_mobile/core/runner/service.dart';
import 'package:zeeh_mobile/feature/activity/data/source/activity_remote_source.dart';
import 'package:zeeh_mobile/feature/activity/model/activity_model.dart';
import 'package:zeeh_mobile/feature/provider.dart';

abstract class ActivitiesRepository {
  // BVN
  Future<Either<Failure, List<ActivityModel>>> userActivities();
}

class ActivitiesRepositoryImpl implements ActivitiesRepository {
  final NetworkInfo _networkInfo;
  final ActivitiesRemoteDataSource _activitiesRemoteDataSource;

  ActivitiesRepositoryImpl({required Ref ref})
      : _activitiesRemoteDataSource = ref.read(activitiesRemoteSourceProvider),
        _networkInfo = ref.read(networkInfoProvider);

  // BVN Lookup
  @override
  Future<Either<Failure, List<ActivityModel>>> userActivities() async {
    ServiceRunner<Failure, List<ActivityModel>> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _activitiesRemoteDataSource.userActivities(),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }
}

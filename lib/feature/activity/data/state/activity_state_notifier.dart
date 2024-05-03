import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/feature/activity/data/repository/activity_repository.dart';
import 'package:zeeh_mobile/feature/activity/model/activity_model.dart';
import 'package:zeeh_mobile/feature/provider.dart';

part 'activity_state.dart';

class ActivitiesStateNotifier extends StateNotifier<ActivitiesState> {
  final ActivitiesRepository _activitiesRepository;

  ActivitiesStateNotifier(Ref ref)
      : _activitiesRepository = ref.read(activitiesRepositoryProvider),
        super(ActivitiesInitial());

  Future<void> userActivities() async {
    state = ActivitiesLoading();

    final activitiesOrError = await _activitiesRepository.userActivities();

    state = activitiesOrError.fold(
      (l) => ActivitiesFailure(l),
      (r) => ActivitiesSuccess(r),
    );
  }
}

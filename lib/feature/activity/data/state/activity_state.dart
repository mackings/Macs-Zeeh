part of 'activity_state_notifier.dart';

class ActivitiesState {}

class ActivitiesInitial extends ActivitiesState {}

class ActivitiesLoading extends ActivitiesState {}

class ActivitiesFailure extends ActivitiesState {
  final Failure failure;

  ActivitiesFailure(this.failure);
}

class ActivitiesSuccess extends ActivitiesState {
  final List<ActivityModel> listOfActivities;

  ActivitiesSuccess(this.listOfActivities);

}
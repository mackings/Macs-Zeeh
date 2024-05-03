part of 'connect_notifier.dart';

class ConnectState {}

class AuthInitial extends ConnectState {}

// BVN Lookup States
class BVNLookupLoadingState extends ConnectState {}

class BVNLookupFailureState extends ConnectState {
  final Failure failure;

  BVNLookupFailureState(this.failure);
}

class BVNLookupSuccessState extends ConnectState {
  final ResponseModel responseModel;

  BVNLookupSuccessState(this.responseModel);
}

// Facial Verification States
class FacialVerifyLoadingState extends ConnectState {}

class FacialVerifyFailureState extends ConnectState {
  final Failure failure;

  FacialVerifyFailureState(this.failure);
}

class FacialVerifySuccessState extends ConnectState {
  final ResponseModel responseModel;

  FacialVerifySuccessState(this.responseModel);
}

// Image Upload
class ImageUploadLoading extends ConnectState {}

class ImageUploadFailure extends ConnectState {
  final Failure failure;

  ImageUploadFailure(this.failure);
}

class ImageUploadSuccess extends ConnectState {
  final FacialVerify facialVerify;

  ImageUploadSuccess(this.facialVerify);
}


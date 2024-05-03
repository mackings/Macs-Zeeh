part of 'offer_state_notifier.dart';

class OfferState {}

class OfferInitial extends OfferState {}

// Get Service Type
class GetServiceTypeLoading extends OfferState {}

class GetServiceTypeFailure extends OfferState {
  final Failure failure;

  GetServiceTypeFailure(this.failure);
}

class GetServiceTypeSuccess extends OfferState {
  final List<ServiceType> serviceTypes;

  GetServiceTypeSuccess(this.serviceTypes);
}

// Active Offers
class ActiveOfferLoading extends OfferState {}

class ActiveOfferFailure extends OfferState {
  final Failure failure;

  ActiveOfferFailure(this.failure);
}

class ActiveOfferSuccess extends OfferState {
  final List<ActiveClaimModel> listOfActiveOffers;

  ActiveOfferSuccess(this.listOfActiveOffers);
}

// Claim Offers
class ClaimOfferLoading extends OfferState {}

class ClaimOfferFailure extends OfferState {
  final Failure failure;

  ClaimOfferFailure(this.failure);
}

// Claim Offer Success
class ClaimOfferSuccess extends OfferState {
  final ClaimModel claimModel;

  ClaimOfferSuccess(this.claimModel);
}

// Claim Status
class ClaimStatusLoading extends OfferState {}

class ClaimStatusFailure extends OfferState {
  final Failure failure;

  ClaimStatusFailure(this.failure);
}

class ClaimStatusSuccess extends OfferState {
  final ResponseModel responseModel;

  ClaimStatusSuccess(this.responseModel);
}

// All Offers
class AllOffersLoading extends OfferState {}

class AllOffersFailure extends OfferState {
  final Failure failure;

  AllOffersFailure(this.failure);
}

class AllOffersSuccess extends OfferState {
  final ResponseModel responseModel;

  AllOffersSuccess(this.responseModel);
}

// Get Offers By Service Type
class GetOffersByServiceTypeLoading extends OfferState {}

class GetOffersByServiceTypeFailure extends OfferState {
  final Failure failure;

  GetOffersByServiceTypeFailure(this.failure);
}

class GetOffersByServiceTypeSuccess extends OfferState {
  final List<ServiceOfferDetail> listOfServiceOffers;

  GetOffersByServiceTypeSuccess(this.listOfServiceOffers);
}

// Get Offer Details
class GetOfferDetailsLoading extends OfferState {}

class GetOfferDetailsFailure extends OfferState {
  final Failure failure;

  GetOfferDetailsFailure(this.failure);
}

class GetOfferDetailsSuccess extends OfferState {
  final ResponseModel responseModel;

  GetOfferDetailsSuccess(this.responseModel);
}

// All Claims
class AllClaimsLoading extends OfferState {}

class AllClaimsFailure extends OfferState {
  final Failure failure;

  AllClaimsFailure(this.failure);
}

class AllClaimsSuccess extends OfferState {
  final List<ActiveClaimModel> listOfClaims;

  AllClaimsSuccess(this.listOfClaims);
}

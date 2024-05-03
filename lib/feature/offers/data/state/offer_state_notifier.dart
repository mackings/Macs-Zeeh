import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/offers/data/repository/offer_repository.dart';
import 'package:zeeh_mobile/feature/offers/model/active_claim_model.dart';
import 'package:zeeh_mobile/feature/offers/model/claim_offer_body.dart';
import 'package:zeeh_mobile/feature/offers/model/claim_response_model.dart';
import 'package:zeeh_mobile/feature/offers/model/service_offer_detail.dart';
import 'package:zeeh_mobile/feature/offers/model/service_type.dart';
import 'package:zeeh_mobile/feature/provider.dart';

part 'offer_state.dart';

class OfferStateNotifier extends StateNotifier<OfferState> {
  final OfferRepository _offerRepository;

  OfferStateNotifier(Ref ref)
      : _offerRepository = ref.read(offerRepositoryProvider),
        super(OfferInitial());

  // Get Service Type
  Future<void> getServiceType() async {
    state = GetServiceTypeLoading();

    final getServiceOrError = await _offerRepository.getServiceType();

    state = getServiceOrError.fold(
      (l) => GetServiceTypeFailure(l),
      (r) => GetServiceTypeSuccess(r),
    );
  }

  // Claim Offers
  Future<void> claimOffers(ClaimOfferBody claimOfferBody) async {
    state = ClaimOfferLoading();

    final claimOffersOrError =
        await _offerRepository.claimOffers(claimOfferBody);

    state = claimOffersOrError.fold(
      (l) => ClaimOfferFailure(l),
      (r) => ClaimOfferSuccess(r),
    );
  }

  // Claim Status
  Future<void> claimStatus(String claimId) async {
    state = ClaimStatusLoading();

    final claimStatusOrError = await _offerRepository.claimStatus(claimId);

    state = claimStatusOrError.fold(
      (l) => ClaimStatusFailure(l),
      (r) => ClaimStatusSuccess(r),
    );
  }

  // All Offers
  Future<void> allOffers() async {
    state = AllOffersLoading();

    final allOffersOrError = await _offerRepository.allOffers();

    state = allOffersOrError.fold(
      (l) => AllOffersFailure(l),
      (r) => AllOffersSuccess(r),
    );
  }

  // Get Offer Details
  Future<void> getOfferDetails(String serviceTyeId, String offerId) async {
    state = GetOfferDetailsLoading();

    final getOfferDetailsOrError =
        await _offerRepository.getOfferDetails(serviceTyeId, offerId);

    state = getOfferDetailsOrError.fold(
      (l) => GetOfferDetailsFailure(l),
      (r) => GetOfferDetailsSuccess(r),
    );
  }
}

class ServiceOfferStateNotifier extends StateNotifier<OfferState> {
  final OfferRepository _offerRepository;

  ServiceOfferStateNotifier(Ref ref)
      : _offerRepository = ref.read(offerRepositoryProvider),
        super(OfferInitial());

  // Get All Offers By Service Type
  Future<void> getAllOffersByServiceType(String serviceTypeId) async {
    state = GetOffersByServiceTypeLoading();

    final getAllOffersByServiceTypeOrError =
        await _offerRepository.getAllOffersByServiceType(serviceTypeId);

    state = getAllOffersByServiceTypeOrError.fold(
      (l) => GetOffersByServiceTypeFailure(l),
      (r) => GetOffersByServiceTypeSuccess(r),
    );
  }
}

class ActiveOfferStateNotifier extends StateNotifier<OfferState> {
  final OfferRepository _offerRepository;

  ActiveOfferStateNotifier(Ref ref)
      : _offerRepository = ref.read(offerRepositoryProvider),
        super(OfferInitial());

  // Active Offers
  Future<void> activeOffers() async {
    state = ActiveOfferLoading();

    final activeOffersOrError = await _offerRepository.activeOffers();

    state = activeOffersOrError.fold(
      (l) => ActiveOfferFailure(l),
      (r) => ActiveOfferSuccess(r),
    );
  }
}

class ActiveClaimsStateNotifier extends StateNotifier<OfferState> {
  final OfferRepository _offerRepository;

  ActiveClaimsStateNotifier(Ref ref)
      : _offerRepository = ref.read(offerRepositoryProvider),
        super(OfferInitial());

  // All Claims By Service Type
  Future<void> allClaimsByServiceTypes(String serviceTypeId) async {
    state = AllClaimsLoading();

    final allClaimsByServiceTypesOrError =
        await _offerRepository.allClaimsByServiceTypes(serviceTypeId);

    state = allClaimsByServiceTypesOrError.fold(
      (l) => AllClaimsFailure(l),
      (r) => AllClaimsSuccess(r),
    );
  }

  Future<void> allClaims() async {
    state = AllClaimsLoading();

    final allClaimsByServiceTypesOrError = await _offerRepository.allClaims();

    state = allClaimsByServiceTypesOrError.fold(
      (l) => AllClaimsFailure(l),
      (r) => AllClaimsSuccess(r),
    );
  }
}

class ClaimsByServiceTypeStateNotifier extends StateNotifier<OfferState> {
  final OfferRepository _offerRepository;

  ClaimsByServiceTypeStateNotifier(Ref ref)
      : _offerRepository = ref.read(offerRepositoryProvider),
        super(OfferInitial());

  // All Claims By Service Type
  Future<void> allClaimsByServiceTypes(String serviceTypeId) async {
    state = AllClaimsLoading();

    final allClaimsByServiceTypesOrError =
        await _offerRepository.allClaimsByServiceTypes(serviceTypeId);

    state = allClaimsByServiceTypesOrError.fold(
      (l) => AllClaimsFailure(l),
      (r) => AllClaimsSuccess(r),
    );
  }
}

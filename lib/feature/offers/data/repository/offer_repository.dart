import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/constants/error_strings.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/core/network_info/network_info.dart';
import 'package:zeeh_mobile/core/runner/service.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/offers/data/source/offer_remote_source.dart';
import 'package:zeeh_mobile/feature/offers/model/active_claim_model.dart';
import 'package:zeeh_mobile/feature/offers/model/claim_offer_body.dart';
import 'package:zeeh_mobile/feature/offers/model/claim_response_model.dart';
import 'package:zeeh_mobile/feature/offers/model/service_offer_detail.dart';
import 'package:zeeh_mobile/feature/offers/model/service_type.dart';
import 'package:zeeh_mobile/feature/provider.dart';

abstract class OfferRepository {
  // Service
  Future<Either<Failure, List<ServiceType>>> getServiceType();

  // Active Offers
  Future<Either<Failure, List<ActiveClaimModel>>> allClaimsByServiceTypes(
      String serviceTypeId);
  Future<Either<Failure, List<ActiveClaimModel>>> allClaims();

  // Offers
  Future<Either<Failure, List<ActiveClaimModel>>> activeOffers();
  
  Future<Either<Failure, ClaimModel>> claimOffers(
    ClaimOfferBody claimOfferBody,
  );
  Future<Either<Failure, ResponseModel>> claimStatus(String claimId);
  Future<Either<Failure, ResponseModel>> allOffers();
  Future<Either<Failure, List<ServiceOfferDetail>>> getAllOffersByServiceType(
      String serviceTypeId);
  Future<Either<Failure, ResponseModel>> getOfferDetails(
      String serviceTyeId, String offerId);
}

class OfferRepositoryImpl implements OfferRepository {
  final NetworkInfo _networkInfo;
  final OfferRemoteSource _offerRemoteSource;

  OfferRepositoryImpl({required Ref ref})
      : _offerRemoteSource = ref.read(offerRemoteSourceProvider),
        _networkInfo = ref.read(networkInfoProvider);

  // Service
  @override
  Future<Either<Failure, List<ServiceType>>> getServiceType() async {
    ServiceRunner<Failure, List<ServiceType>> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
        call: _offerRemoteSource.getServiceType(),
        errorTitle: ErrorStrings.UNKNOWN_ERROR_TITLE);
  }

  // All Claims By Service Type
  @override
  Future<Either<Failure, List<ActiveClaimModel>>> allClaimsByServiceTypes(
      String serviceTypeId) async {
    ServiceRunner<Failure, List<ActiveClaimModel>> sR =
        ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _offerRemoteSource.allClaimsByServiceTypes(serviceTypeId),
      errorTitle: ErrorStrings.UNKNOWN_ERROR_TITLE,
    );
  }

  // All Claims
  @override
  Future<Either<Failure, List<ActiveClaimModel>>> allClaims() async {
    ServiceRunner<Failure, List<ActiveClaimModel>> sR =
        ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _offerRemoteSource.allClaims(),
      errorTitle: ErrorStrings.UNKNOWN_ERROR_TITLE,
    );
  }

  @override
  Future<Either<Failure, List<ActiveClaimModel>>> activeOffers() async {
    ServiceRunner<Failure, List<ActiveClaimModel>> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
        call: _offerRemoteSource.activeOffers(),
        errorTitle: ErrorStrings.UNKNOWN_ERROR_TITLE);
  }

  @override
  Future<Either<Failure, ClaimModel>> claimOffers(
    ClaimOfferBody claimOfferBody,
  ) async {
    ServiceRunner<Failure, ClaimModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
        call: _offerRemoteSource.claimOffers(claimOfferBody),
        errorTitle: ErrorStrings.UNKNOWN_ERROR_TITLE);
  }

  @override
  Future<Either<Failure, ResponseModel>> claimStatus(String claimId) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _offerRemoteSource.claimStatus(claimId),
      errorTitle: ErrorStrings.UNKNOWN_ERROR_TITLE,
    );
  }

  @override
  Future<Either<Failure, ResponseModel>> allOffers() async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _offerRemoteSource.allOffers(),
      errorTitle: ErrorStrings.UNKNOWN_ERROR_TITLE,
    );
  }

  @override
  Future<Either<Failure, List<ServiceOfferDetail>>> getAllOffersByServiceType(
      String serviceTypeId) async {
    ServiceRunner<Failure, List<ServiceOfferDetail>> sR =
        ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _offerRemoteSource.getAllOffersByServiceType(serviceTypeId),
      errorTitle: ErrorStrings.UNKNOWN_ERROR_TITLE,
    );
  }

  @override
  Future<Either<Failure, ResponseModel>> getOfferDetails(
      String serviceTyeId, String offerId) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _offerRemoteSource.getOfferDetails(serviceTyeId, offerId),
      errorTitle: ErrorStrings.UNKNOWN_ERROR_TITLE,
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:zeeh_mobile/core/api/api_endpoints.dart';
import 'package:zeeh_mobile/core/network_request/network_request.dart';
import 'package:zeeh_mobile/core/network_retry/network_retry.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/offers/model/active_claim_model.dart';
import 'package:zeeh_mobile/feature/offers/model/claim_offer_body.dart';
import 'package:zeeh_mobile/feature/offers/model/claim_response_model.dart';
import 'package:zeeh_mobile/feature/offers/model/service_offer_detail.dart';
import 'package:zeeh_mobile/feature/offers/model/service_type.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';

abstract class OfferRemoteSource {
  // Service
  Future<List<ServiceType>> getServiceType();

  // Offers

  Future<List<ActiveClaimModel>> allClaimsByServiceTypes(String serviceTypeId);
  Future<List<ActiveClaimModel>> allClaims();

  Future<List<ActiveClaimModel>> activeOffers();
  Future<ClaimModel> claimOffers(
    ClaimOfferBody claimOfferBody,
  );
  Future<ResponseModel> claimStatus(String claimId);
  Future<ResponseModel> allOffers();
  Future<List<ServiceOfferDetail>> getAllOffersByServiceType(
      String serviceTypeId);
  Future<ResponseModel> getOfferDetails(String serviceTyeId, String offerId);
}

class OfferRemoteSourceImpl implements OfferRemoteSource {
  final NetworkRequest networkRequest;
  final NetworkRetry networkRetry;

  OfferRemoteSourceImpl({
    required this.networkRequest,
    required this.networkRetry,
  });

  // Service

  // All Claims By Service Types
  @override
  Future<List<ActiveClaimModel>> allClaimsByServiceTypes(
      String serviceTypeId) async {
    String url = "${Endpoint.allClaims}/$serviceTypeId";

    final String accessToken = AuthManager.instance.user?.token ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        List listActiveClaims = data["data"]["claimList"];

        List<ActiveClaimModel> activeClaims =
            listActiveClaims.map((e) => ActiveClaimModel.fromJson(e)).toList();

        return activeClaims;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      final ResponseModel responseModel = ResponseModel.fromJson(data);

      try {
        if (responseModel.status == false) {
          throw Exception(data['message']);
        } else {
          final errorMessage = data['message'];
          throw Exception(errorMessage);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }

  // Get All Claims
  @override
  Future<List<ActiveClaimModel>> allClaims() async {
    String url = "${Endpoint.allClaims}?status=0";

    final String accessToken = AuthManager.instance.user?.token ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        if (data['status'] == false) {
          return [];
        }

        List listActiveClaims = data["data"]["claimList"];

        List<ActiveClaimModel> activeClaims =
            listActiveClaims.map((e) => ActiveClaimModel.fromJson(e)).toList();

        return activeClaims;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      final ResponseModel responseModel = ResponseModel.fromJson(data);

      try {
        if (responseModel.status == false) {
          throw Exception(data['message']);
        } else {
          final errorMessage = data['message'];
          throw Exception(errorMessage);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }

  // Get Servie Type
  @override
  Future<List<ServiceType>> getServiceType() async {
    String url = Endpoint.getServiceType;

    final String accessToken = AuthManager.instance.user?.accessToken ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        List listOfServiceTypes = data["data"]["types"];

        List<ServiceType> serviceTypes =
            listOfServiceTypes.map((e) => ServiceType.fromJson(e)).toList();

        return serviceTypes;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      final ResponseModel responseModel = ResponseModel.fromJson(data);

      try {
        if (responseModel.status == false) {
          throw Exception(data['message']);
        } else {
          final errorMessage = data['message'];
          throw Exception(errorMessage);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }

  // Active Offers
  @override
  Future<List<ActiveClaimModel>> activeOffers() async {
    String url = Endpoint.activeOffers;

    final String accessToken = AuthManager.instance.user?.token ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        if (data["status"] == false) {
          return [];
        } else {
          List listOfActiveOffer = data["data"];

          List<ActiveClaimModel> activeOffers = listOfActiveOffer
              .map((e) => ActiveClaimModel.fromJson(e))
              .toList();

          return activeOffers;
        }
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      final ResponseModel responseModel = ResponseModel.fromJson(data);

      try {
        if (responseModel.status == false) {
          throw Exception(data['message']);
        } else {
          final errorMessage = data['message'];
          throw Exception(errorMessage);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }

  @override
  Future<ClaimModel> claimOffers(ClaimOfferBody claimOfferBody) async {
    String url = Endpoint.claimOffers;

    final body = {
      "service": claimOfferBody.service,
      "offer": claimOfferBody.offer,
      "loanAmount": "${claimOfferBody.loanAmount}",
    };

    final String accessToken = AuthManager.instance.user?.token ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
        body: body,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    debugPrint(response.body);

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final ClaimModel claimModel =
            ClaimModel.fromJson(data["data"]["offer"]);

        return claimModel;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      final ResponseModel responseModel = ResponseModel.fromJson(data);

      try {
        if (responseModel.status == false) {
          throw Exception(data['message']);
        } else {
          final errorMessage = data['message'];
          throw Exception(errorMessage);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }

  @override
  Future<ResponseModel> claimStatus(String claimId) async {
    String url = "${Endpoint.offers}/claim-status/$claimId";

    final String accessToken = AuthManager.instance.user?.token ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final ResponseModel responseModel = ResponseModel.fromJson(data);

        return responseModel;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      final ResponseModel responseModel = ResponseModel.fromJson(data);

      try {
        if (responseModel.status == false) {
          throw Exception(data['message']);
        } else {
          final errorMessage = data['message'];
          throw Exception(errorMessage);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }

  @override
  Future<ResponseModel> allOffers() async {
    String url = Endpoint.offers;

    final String accessToken = AuthManager.instance.user?.token ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final ResponseModel responseModel = ResponseModel.fromJson(data);

        return responseModel;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      final ResponseModel responseModel = ResponseModel.fromJson(data);

      try {
        if (responseModel.status == false) {
          throw Exception(data['message']);
        } else {
          final errorMessage = data['message'];
          throw Exception(errorMessage);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }

  @override
  Future<List<ServiceOfferDetail>> getAllOffersByServiceType(
      String serviceTypeId) async {
    String url = "${Endpoint.offers}/$serviceTypeId/offers";

    final String accessToken = AuthManager.instance.user?.token ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        List listOfServiceTypes = data["data"]["offers"];

        List<ServiceOfferDetail> serviceTypes = listOfServiceTypes
            .map((e) => ServiceOfferDetail.fromJson(e))
            .toList();

        return serviceTypes;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      final ResponseModel responseModel = ResponseModel.fromJson(data);

      try {
        if (responseModel.status == false) {
          throw Exception(data['message']);
        } else {
          final errorMessage = data['message'];
          throw Exception(errorMessage);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }

  @override
  Future<ResponseModel> getOfferDetails(
      String serviceTyeId, String offerId) async {
    String url = Endpoint.getServiceType;

    final String accessToken = AuthManager.instance.user?.token ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final ResponseModel responseModel = ResponseModel.fromJson(data);

        return responseModel;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      final ResponseModel responseModel = ResponseModel.fromJson(data);

      try {
        if (responseModel.status == false) {
          throw Exception(data['message']);
        } else {
          final errorMessage = data['message'];
          throw Exception(errorMessage);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/core/network_request/network_request.dart';
import 'package:zeeh_mobile/core/network_retry/network_retry.dart';
import 'package:zeeh_mobile/feature/activity/data/repository/activity_repository.dart';
import 'package:zeeh_mobile/feature/activity/data/source/activity_remote_source.dart';
import 'package:zeeh_mobile/feature/activity/data/state/activity_state_notifier.dart';
import 'package:zeeh_mobile/feature/auth/data/repository/auth_repository.dart';
import 'package:zeeh_mobile/feature/auth/data/source/remote_source.dart';
import 'package:zeeh_mobile/feature/auth/data/state/auth_notifier.dart';
import 'package:zeeh_mobile/feature/connect_account/data/repository/connect_repository.dart';
import 'package:zeeh_mobile/feature/connect_account/data/source/remote_source.dart';
import 'package:zeeh_mobile/feature/connect_account/data/state/connect_notifier.dart';
import 'package:zeeh_mobile/feature/credit/data/repository/credit_repository.dart';
import 'package:zeeh_mobile/feature/credit/data/source/credit_remote_source.dart';
import 'package:zeeh_mobile/feature/credit/data/state/credit_state_notifier.dart';
import 'package:zeeh_mobile/feature/linked_accounts/data/repository/linked_account_repository.dart';
import 'package:zeeh_mobile/feature/linked_accounts/data/state/linked_account_state_notifier.dart';
import 'package:zeeh_mobile/feature/offers/data/repository/offer_repository.dart';
import 'package:zeeh_mobile/feature/offers/data/source/offer_remote_source.dart';
import 'package:zeeh_mobile/feature/offers/data/state/offer_state_notifier.dart';
import 'linked_accounts/data/source/linked_account_remote_source.dart';
import 'profile/data/repository/profile_repository.dart';
import 'profile/data/source/profile_remote_source.dart';
import 'profile/data/state/profile_state_notifier.dart';

final authRemoteSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(
    networkRequest: ref.read(networkRequestProvider),
    networkRetry: ref.read(networkRetryProvider),
  ),
);

// Auth Repository and State Provider

// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref: ref),
);

// State Notifier Provider
final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(ref),
);

final registerUserStateNotifierProvider =
    StateNotifierProvider<RegisterUserStateNotifier, AuthState>(
  (ref) => RegisterUserStateNotifier(ref),
);

final checkAccountStateNotifierProvider =
    StateNotifierProvider.autoDispose<CheckAccountStateNotifier, AuthState>(
  (ref) => CheckAccountStateNotifier(ref),
);

// Account Activites

// Activities
final activitiesRemoteSourceProvider = Provider<ActivitiesRemoteDataSource>(
  (ref) => ActivitiesRemoteDataSourceImpl(
    networkRequest: ref.read(networkRequestProvider),
    networkRetry: ref.read(networkRetryProvider),
  ),
);

final activitiesRepositoryProvider = Provider<ActivitiesRepository>(
  (ref) => ActivitiesRepositoryImpl(ref: ref),
);

final activitiesStateNotifierProvider =
    StateNotifierProvider<ActivitiesStateNotifier, ActivitiesState>(
  (ref) => ActivitiesStateNotifier(ref),
);

// Connect Bank
// Connect User Account

// BVN
final connectRemoteSourceProvider = Provider<ConnectRemoteDataSource>(
  (ref) => ConnectRemoteDataSourceImpl(
    networkRequest: ref.read(networkRequestProvider),
    networkRetry: ref.read(networkRetryProvider),
  ),
);

// Connect Account
final connectRepositoryProvider = Provider<ConnectRepository>(
  (ref) => ConnectRepositoryImpl(ref: ref),
);

// Connect User BVN and Facial Verification State Notifier
final connectStateNotifierProvider =
    StateNotifierProvider<ConnectStateNotifier, ConnectState>(
  (ref) => ConnectStateNotifier(ref),
);

// Link Account
// Link User Account

// Bank
final linkedAccountRemoteSourceProvider =
    Provider<LinkedAccountRemoteDataSource>(
  (ref) => LinkedAccountRemoteDataSourceImpl(
    networkRequest: ref.read(networkRequestProvider),
    networkRetry: ref.read(networkRetryProvider),
  ),
);

// Linked Account
final linkedAccountRepositoryProvider = Provider<LinkedAccountRepository>(
  (ref) => LinkedAccountRepositoryImpl(ref: ref),
);

final linkedAccountStateNotifierProvider =
    StateNotifierProvider<LinkedAccountStateNotifier, LinkedAccountState>(
  (ref) => LinkedAccountStateNotifier(ref),
);

final unlinkAccountStateNotifierProvider =
    StateNotifierProvider<UnlinkAccountStateNotifier, LinkedAccountState>(
  (ref) => UnlinkAccountStateNotifier(ref),
);

// User Details

// User Detail Remote Source
final profileRemoteSourceProvider = Provider<ProfileRemoteDataSource>(
  (ref) => ProfileRemoteDataSourceImpl(
    networkRequest: ref.read(networkRequestProvider),
    networkRetry: ref.read(networkRetryProvider),
  ),
);

//
// Linked Account
final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(ref: ref),
);

final profileStateNotifierProvider =
    StateNotifierProvider<ProfileStateNotifier, ProfileState>(
  (ref) => ProfileStateNotifier(ref),
);

// Credit
final creditRemoteSourceProvider = Provider<CreditRemoteSource>(
  (ref) => CreditRemoteSourceImpl(
    networkRequest: ref.read(networkRequestProvider),
    networkRetry: ref.read(networkRetryProvider),
  ),
);

// Credit Repository Provider
final creditRepositoryProvider = Provider<CreditRepository>(
  (ref) => CreditRepositoryImpl(ref: ref),
);

// Credit State Notifier
final creditStateNotifierProvider =
    StateNotifierProvider<CreditStateNotifier, CreditState>(
  (ref) => CreditStateNotifier(ref),
);

// Credit Report State Notifier
final creditReportStateNotifierProvider =
    StateNotifierProvider<CreditReportStateNotifier, CreditState>(
  (ref) => CreditReportStateNotifier(ref),
);

// Offer Provider
final offerRemoteSourceProvider = Provider<OfferRemoteSource>(
  (ref) => OfferRemoteSourceImpl(
    networkRequest: ref.read(networkRequestProvider),
    networkRetry: ref.read(networkRetryProvider),
  ),
);

final offerRepositoryProvider = Provider<OfferRepository>(
  (ref) => OfferRepositoryImpl(ref: ref),
);

// Offer State Notifier
final offerStateNotifierProvider =
    StateNotifierProvider<OfferStateNotifier, OfferState>(
  (ref) => OfferStateNotifier(ref),
);

// Service Offer State Notifier
final serviceOfferStateNotifierProvider =
    StateNotifierProvider<ServiceOfferStateNotifier, OfferState>(
  (ref) => ServiceOfferStateNotifier(ref),
);

// Active Offer State Notifier
final activeOfferStateNotifierProvider =
    StateNotifierProvider<ActiveOfferStateNotifier, OfferState>(
  (ref) => ActiveOfferStateNotifier(ref),
);

final activeClaimsStateNotifierProvider =
    StateNotifierProvider<ActiveClaimsStateNotifier, OfferState>(
  (ref) => ActiveClaimsStateNotifier(ref),
);

// Claims By Service Type
final claimsByServiceTypeStateNotifierProvider =
    StateNotifierProvider<ClaimsByServiceTypeStateNotifier, OfferState>(
  (ref) => ClaimsByServiceTypeStateNotifier(ref),
);

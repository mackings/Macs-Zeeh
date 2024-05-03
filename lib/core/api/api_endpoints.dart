// API Base URL == 'https://app.cardify.co/api//'

class Endpoint {
  static const _base = 'https://dev.api.usezeeh.com/api';

  ////////////////////////////////////

  // Authentication Endpoint

  // Auth
  static const register = '$_base/auth/register';

  static const login = '$_base/auth/login';

  static const accountVerification = '$_base/auth/account/verification';

  static const resendVerificationCode = '$_base/auth/resend-verification-code';

  static const checkAccount = '$_base/auth/check-account';

    static const bioLogin = "$_base/auth/bio-login";


  // Pin
  static const pinCreate = '$_base/auth/pin/create';

  static const pinReset = '$_base/auth/pin/reset';

  static const forgotPin = '$_base/auth/forgot-pin';

  static const resendForgotPin = '$_base/auth/resend-forgot-pin';

  // Code
  static const verifyCode = '$_base/auth/code/verify';

  // Account
  static const accountLogout = "$_base/account/logout";

  static const deleteAccount = "$_base/account/delete";

  static const userDetails = "$_base/account/user-details";

  static const creditScore = '$_base/account/credit-score';

  static const enableBiometrics = '$_base/account/enable-biometrics';

  static const userActivities = "$_base/account/user-activities";

  static const nations = "$_base/account/nations";

  static const creditReport = "$_base/account/credit-report";


  // BVN
  static const bvnLookup = "$_base/bvn/lookup";

  static const facialVerify = "$_base/bvn/facial-verify";

  static const facialVerify2 = "$_base/bvn/facial-verify2";

  // Banks
  static const unlinkBank = "$_base/banks/unlink-bank/";

  static const bankDetail = "$_base/banks/bankDetails/";

  static const allbanks = "$_base/banks/allBanks";

  // Services
  static const getServiceType = "$_base/merchant/get-service-type";

  // Offers
  static const offers = "$_base/offers/";

  static const claimStatus = "$_base/offers/claim-status";

  static const claimOffers = "$_base/offers/claimOffer";

  static const activeOffers = "$_base/offers/active-offers";

  static const allOffers = "$_base/offers/all-offers";

  static const allClaims = "$_base/offers/all-claims";

  // Support
  static const userSendIssue = "$_base/support/send-issue";
}

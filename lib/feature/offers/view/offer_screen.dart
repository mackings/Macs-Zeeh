import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/credit/view/widgets/header_widget.dart';
import 'package:zeeh_mobile/feature/home/view/service_offer/active_offer_page.dart';
import 'package:zeeh_mobile/feature/home/view/service_offer/pending_offers_page.dart';
import 'package:zeeh_mobile/feature/offers/data/state/offer_state_notifier.dart';
import 'package:zeeh_mobile/feature/offers/model/active_claim_model.dart';
import 'package:zeeh_mobile/feature/offers/model/service_type.dart';
import 'package:zeeh_mobile/feature/offers/view/loan/Macs/allloans.dart';
import 'package:zeeh_mobile/feature/offers/view/loan/loan_offer_page.dart';
import 'package:zeeh_mobile/feature/provider.dart';

class OfferScreen extends ConsumerStatefulWidget {
  const OfferScreen({
    super.key,
    this.showBackButton = false,
  });

  final bool showBackButton;

  @override
  ConsumerState<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends ConsumerState<OfferScreen> {
  List<ServiceType> serviceTypes = [];

  List<ActiveClaimModel> listOfActiveOffers = [];

  List<ActiveClaimModel> listOfClaims = [];

  // Get Service Types
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(activeClaimsStateNotifierProvider.notifier).allClaims();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final offerState = ref.watch(offerStateNotifierProvider);

    if (offerState is GetServiceTypeSuccess) {
      serviceTypes = offerState.serviceTypes;
    }

    final activeOffersState = ref.watch(activeOfferStateNotifierProvider);

    if (activeOffersState is ActiveOfferSuccess) {
      listOfActiveOffers = activeOffersState.listOfActiveOffers;
    }

    final allClaimsState = ref.watch(activeClaimsStateNotifierProvider);

    if (allClaimsState is AllClaimsSuccess) {
      listOfClaims = allClaimsState.listOfClaims;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: 375.w,
          decoration: const BoxDecoration(color: ZeehColors.scaffoldBackground),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuHeaderWidget(
                title: "Service offers",
                showBackButton: widget.showBackButton,
              ),

              //Active Accounts
              if (listOfActiveOffers.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: InkWell(
                    onTap: () => navigate(context, const ActiveOffers()),
                    child: DMSanText(
                      text: "Active Offers (${listOfActiveOffers.length})",
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      textColor: ZeehColors.buttonPurple,
                    ),
                  ),
                ),

              SizedBox(
                height: 1.h,
              ),

              // Pending Offers
              if (listOfClaims.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: InkWell(
                    onTap: () => navigate(
                      context,
                      PendingOffers(
                        listOfServiceTypes: serviceTypes,
                      ),
                    ),
                    child: DMSanText(
                      text: "Pending Offers (${listOfClaims.length})",
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      textColor: ZeehColors.buttonPurple,
                    ),
                  ),
                ),

              SizedBox(
                height: 3.h,
              ),

              // New Service Offers

              // Service Offers
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 15.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DMSanText(
                      text: "Available service offers",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),

                    if (offerState is GetServiceTypeLoading)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 100.h),
                          Center(
                              child: LoadingIndicatorWidget(
                            height: 40.h,
                            width: 40.w,
                          )),
                          SizedBox(height: 100.h),
                        ],
                      )
                    else if (offerState is GetServiceTypeSuccess)
                      ...List.generate(
                        serviceTypes.length,
                        (index) => Column(
                          children: [
                            HomeFeatureWidget(
                              comingSoon: true,
                              onTap: () {
                                if (serviceTypes[index].name == "Loan") {
                                  navigate(context, AllLoans());
                                  // navigate(
                                  //   context,
                                  //    LoanOffersPage(
                                  //        serviceTypeId:
                                  //           serviceTypes[0].id.toString(),
                                  //       ),
                                  // );
                                } else {}
                              },
                              description:
                                  serviceTypes[index].description.toString(),
                              imageAsset: serviceTypes[index].name == "Loan"
                                  ? ZeehAssets.dollarBankNotesIcon
                                  : serviceTypes[index].name == "Investment"
                                      ? ZeehAssets.growingMoneyIcon
                                      : serviceTypes[index].name == "Insurance"
                                          ? ZeehAssets.insuranceProtectIcon
                                          : serviceTypes[index].name ==
                                                  "Buy Now Pay Later"
                                              ? ZeehAssets.buyingIcon
                                              : serviceTypes[index].name ==
                                                      "Credit Card"
                                                  ? ZeehAssets.bankCardIcon
                                                  : ZeehAssets.personalIcon,
                              title: serviceTypes[index].name.toString(),
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color(0xffD7D7D7),
                            ),
                          ],
                        ),
                      ),
                    // HomeFeatureWidget(
                    //   onTap: () {
                    //     navigate(context, const LoanOffersPage());
                    //   },
                    //   description: 'Your way top emergency funds',
                    //   imageAsset: ZeehAssets.dollarBankNotesIcon,
                    //   title: 'Loan',
                    // ),
                    // const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    // HomeFeatureWidget(
                    //   onTap: () {
                    //     //  navigate(context, const InsuranceOptionScreen());
                    //   },
                    //   description: 'Easy way to safer life',
                    //   imageAsset: ZeehAssets.insuranceProtectIcon,
                    //   title: 'Insurance (Coming Soon)',
                    // ),
                    // const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    // HomeFeatureWidget(
                    //   onTap: () {
                    //     // navigate(context, const BnplOffersPage());
                    //   },
                    //   description: 'Buy now and pay by installments',
                    //   imageAsset: ZeehAssets.buyingIcon,
                    //   title: 'Buy Now Pay Later (Coming Soon)',
                    // ),
                    // const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    // const HomeFeatureWidget(
                    //   description: 'Secure high credit score',
                    //   imageAsset: ZeehAssets.growingMoneyIcon,
                    //   title: 'Investment  (Coming Soon)',
                    // ),
                    // const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    // SizedBox(height: 10.h),
                    // const HomeFeatureWidget(
                    //   description: 'Access to financial stability',
                    //   imageAsset: ZeehAssets.bankCardIcon,
                    //   title: 'Credit cards  (Coming Soon)',
                    // ),
                    SizedBox(
                      height: 100.h,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                      decoration: const BoxDecoration(
                          color: Color(0xffF8F9FD),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Row(children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xffEBEAEE),
                          radius: 10.sp,
                          child: CircleAvatar(
                            backgroundColor: ZeehColors.buttonPurple,
                            radius: 6.sp,
                            child: GroteskText(
                              text: "?",
                              textColor: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: SizedBox(
                            width: 270.w,
                            child: GroteskText(
                              text:
                                  "New interesting service offers will keep coming to you as long as your credit goals and creditworthiness improves.",
                              fontSize: 10.sp,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeFeatureWidget extends StatelessWidget {
  const HomeFeatureWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageAsset,
    this.onTap,
    required this.comingSoon,
  });

  final String title;
  final String description;
  final String imageAsset;
  final Function()? onTap;
  final bool comingSoon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 60.h,
        child: Padding(
          padding: EdgeInsets.only(top: 4.0.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imageAsset,
                height: 40.h,
                width: 40.w,
              ),
              SizedBox(width: 16.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GroteskText(
                        text: title,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                      if (comingSoon == true)
                        DMSanText(
                          text: " (Coming Soon)",
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          textColor: Colors.green,
                        ),
                    ],
                  ),
                  SizedBox(
                    width: 206.w,
                    child: DMSanText(
                      text: description,
                      fontSize: 13.sp,
                      maxLines: 4,
                      fontWeight: FontWeight.w400,
                      textColor: ZeehColors.grayColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right_rounded,
                color: ZeehColors.grayColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

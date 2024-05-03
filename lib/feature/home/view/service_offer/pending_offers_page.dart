import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/currency_function.dart';
import 'package:zeeh_mobile/common/components/empty_state_widget.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/feature/home/view/service_offer/loan/loan_offer_details.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';
import 'package:zeeh_mobile/feature/offers/data/state/offer_state_notifier.dart';
import 'package:zeeh_mobile/feature/offers/model/active_claim_model.dart';
import 'package:zeeh_mobile/feature/offers/model/service_type.dart';
import 'package:zeeh_mobile/feature/provider.dart';

import '../../../../common/utils/navigator.dart';
import '../../../../constants/colors.dart';

class PendingOffers extends ConsumerStatefulWidget {
  const PendingOffers({super.key, required this.listOfServiceTypes});

  final List<ServiceType> listOfServiceTypes;

  @override
  ConsumerState<PendingOffers> createState() => _PendingOffersState();
}

class _PendingOffersState extends ConsumerState<PendingOffers> {
  int tabToggleValue = 1;

  List<ActiveClaimModel> listOfActiveClaimModel = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref
            .read(claimsByServiceTypeStateNotifierProvider.notifier)
            .allClaimsByServiceTypes(
                widget.listOfServiceTypes[0].id.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final claimState = ref.watch(claimsByServiceTypeStateNotifierProvider);

    if (claimState is AllClaimsSuccess) {
      listOfActiveClaimModel = claimState.listOfClaims;
    }

    final allClaimsState = ref.watch(activeClaimsStateNotifierProvider);

    if (allClaimsState is AllClaimsSuccess) {
      listOfActiveClaimModel = allClaimsState.listOfClaims;
    }

    return Scaffold(
      body: Container(
        height: 812.h,
        width: 375.w,
        decoration: const BoxDecoration(
          color: ZeehColors.scaffoldBackground,
        ),

        // Active Offers
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeaderWidgetTwo(
              title: "Pending Offers",
            ),
            SizedBox(height: 17.h),

            // Offers Toggle
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter Tabs
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8, color: const Color(0xffD7D7D7)),
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                    ),

                    // Row of Tabs
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            toggleTabs("loan");
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.w, vertical: 12.h),
                            decoration: BoxDecoration(
                                color:
                                    tabToggleValue == 1 ? Colors.black : null),
                            child: GroteskText(
                                text: "Loan",
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                                textColor:
                                    tabToggleValue == 1 ? Colors.white : null),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            toggleTabs("insurance");
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 12.h),
                            decoration: BoxDecoration(
                                color:
                                    tabToggleValue == 2 ? Colors.black : null),
                            child: GroteskText(
                                text: "Insurance",
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                                textColor: tabToggleValue == 2
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            toggleTabs("bnpl");
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.w, vertical: 12.h),
                            decoration: BoxDecoration(
                                color:
                                    tabToggleValue == 3 ? Colors.black : null),
                            child: GroteskText(
                                text: "BNPL",
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                                textColor: tabToggleValue == 3
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h),

                  SizedBox(
                    height: 550.h,
                    child: SingleChildScrollView(
                      // Loans
                      child: Column(
                        children: [
                          // Loan Offers
                          if (tabToggleValue == 1)
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GroteskText(
                                    text:
                                        "Total Loan Offers (${listOfActiveClaimModel.length})",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ),
                                  SizedBox(height: 9.h),

                                  // Loading Indicator
                                  if (claimState is AllClaimsLoading)
                                    Padding(
                                      padding: EdgeInsets.only(top: 200.0.h),
                                      child: Center(
                                        child: LoadingIndicatorWidget(
                                          height: 40.h,
                                          width: 40.w,
                                        ),
                                      ),
                                    )

                                  // List of Offers
                                  else if (claimState is AllClaimsSuccess)
                                    ListView(
                                      shrinkWrap: true,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      children: [
                                        ...List.generate(
                                          listOfActiveClaimModel.length,
                                          (index) => Column(
                                            children: [
                                              ActiveOffersFeatureWidget(
                                                title: listOfActiveClaimModel[
                                                                index]
                                                            .offerName
                                                            .toString()
                                                            .length >
                                                        20
                                                    ? "${listOfActiveClaimModel[index].offerName.toString().substring(0, 20)}..."
                                                    : listOfActiveClaimModel[
                                                            index]
                                                        .offerName
                                                        .toString(),
                                                description:
                                                    "${listOfActiveClaimModel[index].duration} ${listOfActiveClaimModel[index].repaymentPlan == "weekly" && listOfActiveClaimModel[index].duration!.toInt() > 1 ? "weeks" : listOfActiveClaimModel[index].duration!.toInt() == 1 && listOfActiveClaimModel[index].repaymentPlan == "weekly" ? "week" : listOfActiveClaimModel[index].repaymentPlan == "monthly" && listOfActiveClaimModel[index].duration!.toInt() == 1 ? "months" : "month"} term",
                                                moreDetails:
                                                    "${listOfActiveClaimModel[index].interest}% Interest Rate",
                                                titleRight:
                                                    "₦${amountFormatter(listOfActiveClaimModel[index].repaymentAmount!)}",
                                                descriptionRight:
                                                    "Payback ${listOfActiveClaimModel[index].repaymentPlan == "weekly" ? "weekly" : "monthly"}",
                                                onTap: () => navigate(
                                                  context,
                                                  LoanOffersDetailsPage(
                                                    activeClaimModel:
                                                        listOfActiveClaimModel[
                                                            index],
                                                  ),
                                                ),
                                              ),
                                              const Divider(
                                                thickness: 1,
                                                color: Color(0xffD7D7D7),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            )

                          // Insurance
                          else if (tabToggleValue == 2)
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GroteskText(
                                    text: "Total Insurance offers (0)",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ),
                                  SizedBox(height: 9.h),
                                  const EmptyStateWidget(
                                    description: "No Offers Yet",
                                  ),
                                  // ListView(
                                  //   shrinkWrap: true,
                                  //   physics:
                                  //       const AlwaysScrollableScrollPhysics(),
                                  //   padding: EdgeInsets.only(bottom: 10.h),
                                  //   children: [
                                  //     ActiveOffersFeatureWidget(
                                  //       onTap: () => navigate(context,
                                  //           const InvestmentOfferPage()),
                                  //       title: "Alico Insurance",
                                  //       description: "6 months term",
                                  //       moreDetails: "Vehicle Insurance",
                                  //       moreDetailsIcon: ZeehAssets.carIcon,
                                  //       titleRight: "N300,000.00",
                                  //       descriptionRight: "Basic",
                                  //     ),
                                  //     const Divider(
                                  //         thickness: 1,
                                  //         color: Color(0xffD7D7D7)),
                                  //     const ActiveOffersFeatureWidget(
                                  //       title: "Alico Insurance",
                                  //       description: "6 months term",
                                  //       moreDetails: "Life Insurance",
                                  //       moreDetailsIcon:
                                  //           ZeehAssets.umbrellaIcon,
                                  //       titleRight: "N20,000.00",
                                  //       descriptionRight: "Payback weekly",
                                  //     ),
                                  //     const Divider(
                                  //         thickness: 1,
                                  //         color: Color(0xffD7D7D7)),
                                  //     const ActiveOffersFeatureWidget(
                                  //       title: "Alico Insurance",
                                  //       description: "6 months term",
                                  //       moreDetails: "Health Insurance",
                                  //       moreDetailsIcon:
                                  //           ZeehAssets.heartPlusIcon,
                                  //       titleRight: "N300,000.00",
                                  //       descriptionRight: "Premuim",
                                  //     ),
                                  //     const Divider(
                                  //         thickness: 1,
                                  //         color: Color(0xffD7D7D7)),
                                  //     const ActiveOffersFeatureWidget(
                                  //       title: "Alico Insurance",
                                  //       description: "3 months term",
                                  //       moreDetailsIcon:
                                  //           ZeehAssets.homeIconTwo,
                                  //       moreDetails: "House Insurance",
                                  //       titleRight: "N100,000.00",
                                  //       descriptionRight: "Payback weekly",
                                  //     ),
                                  //     const Divider(
                                  //         thickness: 1,
                                  //         color: Color(0xffD7D7D7)),
                                  //     const ActiveOffersFeatureWidget(
                                  //       title: "Fairmoney",
                                  //       description: "3 months term",
                                  //       moreDetails: "Car Insurance",
                                  //       moreDetailsIcon: ZeehAssets.carIcon,
                                  //       titleRight: "N100,000.00",
                                  //       descriptionRight: "Basic",
                                  //     ),
                                  //     const Divider(
                                  //       thickness: 1,
                                  //       color: Color(0xffD7D7D7),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                            )

                          // BNPL
                          else if (tabToggleValue == 3)
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GroteskText(
                                    text: "Total Purchase Offers (0)",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ),
                                  SizedBox(height: 9.h),
                                  const EmptyStateWidget(
                                    description: "No Offers Yet",
                                  ),
                                  // ListView(
                                  //   shrinkWrap: true,
                                  //   physics:
                                  //       const AlwaysScrollableScrollPhysics(),
                                  //   padding: EdgeInsets.only(bottom: 10.h),
                                  //   children: [
                                  //     ActiveOffersFeatureWidget(
                                  //         onTap: () => navigate(
                                  //             context, const BnplOfferPage()),
                                  //         title: "CredPal",
                                  //         description: "Item : Laptop",
                                  //         moreDetails:
                                  //             "6 months purchase plan",
                                  //         titleRight: "N300,000.00",
                                  //         descriptionRight: "Weekly payback"),
                                  //     const Divider(
                                  //         thickness: 1,
                                  //         color: Color(0xffD7D7D7)),
                                  //     const ActiveOffersFeatureWidget(
                                  //         title: "CredPal",
                                  //         description: "Item : Laptop",
                                  //         moreDetails:
                                  //             "6 months purchase plan",
                                  //         titleRight: "N20,000.00",
                                  //         descriptionRight: "Weekly payback"),
                                  //     const Divider(
                                  //         thickness: 1,
                                  //         color: Color(0xffD7D7D7)),
                                  //     const ActiveOffersFeatureWidget(
                                  //         title: "CredPal",
                                  //         description: "Item : Laptop",
                                  //         moreDetails:
                                  //             "6 months purchase plan",
                                  //         titleRight: "N300,000.00",
                                  //         descriptionRight: "Weekly payback"),
                                  //     const Divider(
                                  //         thickness: 1,
                                  //         color: Color(0xffD7D7D7)),
                                  //     const ActiveOffersFeatureWidget(
                                  //         title: "CredPal",
                                  //         description: "Item : Laptop",
                                  //         moreDetails:
                                  //             "6 months purchase plan",
                                  //         titleRight: "N100,000.00",
                                  //         descriptionRight: "Weekly payback"),
                                  //     const Divider(
                                  //         thickness: 1,
                                  //         color: Color(0xffD7D7D7)),
                                  //     const ActiveOffersFeatureWidget(
                                  //         title: "CredPal",
                                  //         description: "Item : Laptop",
                                  //         moreDetails:
                                  //             "6 months purchase plan",
                                  //         titleRight: "N50,000.00",
                                  //         descriptionRight: "Weekly payback"),
                                  //     const Divider(
                                  //         thickness: 1,
                                  //         color: Color(0xffD7D7D7)),
                                  //   ],
                                  // )
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Toggle Tabs
  void toggleTabs(item) {
    if (item == "loan") {
      setState(() {
        tabToggleValue = 1;
      });
    } else if (item == "insurance") {
      setState(() {
        tabToggleValue = 2;
      });
    } else if (item == "bnpl") {
      setState(() {
        tabToggleValue = 3;
      });
    }
  }
}

class ActiveOffersFeatureWidget extends StatelessWidget {
  const ActiveOffersFeatureWidget({
    super.key,
    required this.title,
    required this.description,
    required this.moreDetails,
    this.moreDetailsIcon,
    required this.titleRight,
    required this.descriptionRight,
    this.onTap,
  });

  final String title;
  final String description;
  final String moreDetails;
  final String? moreDetailsIcon;
  final String titleRight;
  final String descriptionRight;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.0.h),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GroteskText(
                    text: title,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 3.h),
                  GroteskText(
                    text: description,
                    fontSize: 14.sp,
                    maxLines: 4,
                    fontWeight: FontWeight.w400,
                    textColor: ZeehColors.grayColor,
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      GroteskText(
                        text: moreDetails,
                        fontWeight: FontWeight.w500,
                        textColor: ZeehColors.buttonPurple,
                        fontSize: 14.sp,
                      ),
                      if (moreDetailsIcon != null)
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Image.asset(
                            moreDetailsIcon!,
                            height: 16.h,
                            width: 14.w,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SpaceGroteskText(
                        text: titleRight,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      SizedBox(height: 4.h),
                      GroteskText(
                        text: descriptionRight,
                        fontSize: 14.sp,
                        maxLines: 4,
                        fontWeight: FontWeight.w400,
                        textColor: ZeehColors.grayColor,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      color: ZeehColors.grayColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

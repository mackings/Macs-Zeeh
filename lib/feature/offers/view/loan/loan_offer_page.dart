import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/currency_function.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/credit/data/state/credit_state_notifier.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';
import 'package:zeeh_mobile/feature/offers/data/state/offer_state_notifier.dart';
import 'package:zeeh_mobile/feature/offers/model/service_offer_detail.dart';
import 'package:zeeh_mobile/feature/offers/view/loan/take_loan_details_page.dart';
import 'package:zeeh_mobile/feature/offers/view/loan/widget/loan_service_offer_widget.dart';
import 'package:zeeh_mobile/feature/provider.dart';

import '../../../../common/utils/navigator.dart';

class LoanOffersPage extends ConsumerStatefulWidget {
  const LoanOffersPage({
    super.key,
  required this.serviceTypeId,
  });

 final String serviceTypeId;

  @override
  ConsumerState<LoanOffersPage> createState() => _LoanOffersPageState();
}

class _LoanOffersPageState extends ConsumerState<LoanOffersPage> {
  List<ServiceOfferDetail> serviceOffers = [];

  dynamic creditScore = 0;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
    //     ref
    //         .read(serviceOfferStateNotifierProvider.notifier)
    //         .getAllOffersByServiceType(widget.serviceTypeId);


    
    //   },
    
   }

  @override
  Widget build(BuildContext context) {
    final offerState = ref.watch(serviceOfferStateNotifierProvider);

    if (offerState is GetOffersByServiceTypeSuccess) {
      serviceOffers = offerState.listOfServiceOffers;
    }

    final creditState = ref.watch(creditStateNotifierProvider);

    if (creditState is GetCreditScoreSuccess) {
      creditScore = creditState.responseModel.data["score"];
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 375.w,
          decoration: const BoxDecoration(color: ZeehColors.scaffoldBackground),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeaderWidgetTwo(title: "Loan Offers"),
              SizedBox(
                height: 17.h,
              ),

              // Offer Loading State
              if (offerState is GetOffersByServiceTypeLoading)
                Padding(
                  padding: EdgeInsets.only(top: 200.0.h),
                  child: Center(
                    child: LoadingIndicatorWidget(
                      height: 50.w,
                      width: 50.w,
                    ),
                  ),
                ),

              // Offer State
              if (offerState is GetOffersByServiceTypeSuccess)
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                        serviceOffers.length,
                        (index) => Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (serviceOffers[index]
                                        .creditWorthiness["minimum"] <=
                                    creditScore) {
                                  navigate(
                                    context,
                                    TakeLoanDetails(
                                      serviceOfferDetail: serviceOffers[index],
                                    ),
                                  );
                                }
                              },
                              child: LoanOffersList(
                                imageAsset: serviceOffers[index]
                                    .merchantLogo
                                    .toString(),
                                textLeft1: serviceOffers[index]
                                            .name
                                            .toString()
                                            .length <
                                        15
                                    ? serviceOffers[index].name.toString()
                                    : "${serviceOffers[index].name.toString().substring(0, 15)}...",
                                textLeft2:
                                    "₦${serviceOffers[index].loanAmount["minimum"]}-₦${serviceOffers[index].loanAmount["maximum"]}",
                                textLeft3:
                                    "${serviceOffers[index].interest}% interest rate",
                                textRight1:
                                    "${amountFormatter(serviceOffers[index].duration!.toDouble())} ${serviceOffers[index].repaymentPlan} term",
                                eligible: serviceOffers[index]
                                            .creditWorthiness["minimum"] <=
                                        creditScore
                                    ? true
                                    : false,
                              ),
                            ),
                            const Divider(
                                thickness: 1, color: Color(0xffD7D7D7)),
                          ],
                        ),
                      ),
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

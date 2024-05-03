import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/credit/data/state/credit_state_notifier.dart';
import 'package:zeeh_mobile/feature/credit/view/credit_report_page.dart';
import 'package:zeeh_mobile/feature/credit/view/score_analysis_page.dart';
import 'package:zeeh_mobile/feature/credit/view/score_history_page.dart';
import 'package:zeeh_mobile/feature/credit/view/widgets/header_widget.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/score_widget.dart';
import 'package:zeeh_mobile/feature/linked_accounts/data/state/linked_account_state_notifier.dart';
import 'package:zeeh_mobile/feature/linked_accounts/model/linked_account_model.dart';
import 'package:zeeh_mobile/feature/provider.dart';

import '../../../common/utils/navigator.dart';

class CreditScreen extends ConsumerStatefulWidget {
  const CreditScreen({super.key, this.action});

  final VoidCallback? action;

  @override
  ConsumerState<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends ConsumerState<CreditScreen> {
  dynamic credit = 0;

  double? networth = 0;

  LinkedAccountModel linkedAccount = LinkedAccountModel();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  String calculateScore(double score) {
    if (score >= 300 && score <= 437) {
      return 'Poor';
    } else if (score >= 438 && score <= 574) {
      return 'Fair';
    } else if (score >= 575 && score <= 711) {
      return 'Good';
    } else if (score >= 712 && score <= 850) {
      return 'Excellent';
    } else {
      return 'No Score';
    }
  }

  @override
  Widget build(BuildContext context) {
    final creditState = ref.watch(creditStateNotifierProvider);

    if (creditState is GetCreditScoreSuccess) {
      credit = creditState.responseModel.data["score"];
    }

    // Bank State
    final bankState = ref.watch(linkedAccountStateNotifierProvider);

    if (bankState is AllBankSuccess) {
      linkedAccount = bankState.linkedAccount;

      if (linkedAccount.numberOfBanks != 0) {
        networth = linkedAccount.banks?[0].balance;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: 812.h,
        width: 375.w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MenuHeaderWidget(),
              const Divider(
                thickness: 1,
                color: ZeehColors.greyColor,
              ),
              Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 5.h),
                      Container(
                        height: 260.h,
                        width: 375.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.h,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            // if (credit != 0)
                            Row(
                              children: [
                                // Credit Score
                                CreditScoreWidget(
                                  score: "$credit",
                                ),
                                const ScoreDivider(),
                                SizedBox(width: 15.w),
                                // Net Worth
                                const NetworthWidget(),
                                SizedBox(width: 30.w),

                                const ScoreDivider(),
                                SizedBox(width: 15.w),
                                const DebtWidget(),
                              ],
                            ),

                            SizedBox(height: 30.h),

                            // Credit Score
                            SizedBox(
                              width: 200.w,
                              height: 148.h,
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: _getRadialGauge(),
                                  ),
                                  Positioned(
                                    bottom: 20.h,
                                    left: 55.w,
                                    child: DMSanText(
                                      text: "Powered by Zeeh",
                                      textColor: const Color(0xFF5F6D7E),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),

                      // Score Analysis
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 16.h,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                navigate(context, const ScoreAnalysis());
                              },
                              child: HomeFeatureWidget(
                                title: "Score Analysis",
                                description:
                                    "Get insight into why your score is $credit",
                                imageAsset: ZeehAssets.barChart,
                              ),
                            ),
                            const Divider(
                                thickness: 1, color: Color(0xffD7D7D7)),
                            InkWell(
                              onTap: () {
                                navigate(context, const ScoreHistory());
                              },
                              child: const HomeFeatureWidget(
                                title: "Score History",
                                description:
                                    "See how your score has changed so far",
                                imageAsset: ZeehAssets.timeMachine,
                              ),
                            ),
                            const Divider(
                                thickness: 1, color: Color(0xffD7D7D7)),
                            InkWell(
                              onTap: () {
                                navigate(context, const CreditReport());
                              },
                              child: const HomeFeatureWidget(
                                title: "Credit Report",
                                description:
                                    "See information lenders see about you",
                                imageAsset: ZeehAssets.businessReport,
                              ),
                            ),
                            const Divider(
                                thickness: 1, color: Color(0xffD7D7D7)),
                            SizedBox(height: 60.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRadialGauge() {
    return SizedBox(
      width: 200.w,
      height: 150.h,
      child: Stack(
        children: [
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                startAngle: 180,
                endAngle: 0,
                minimum: 300,
                maximum: 850,
                radiusFactor: 1,
                showAxisLine: false,
                showLabels: false,
                annotations: [
                  GaugeAnnotation(
                    positionFactor: 0.9,
                    angle: 170,
                    widget: GroteskText(
                      text: "300",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GaugeAnnotation(
                    positionFactor: 0.9,
                    angle: 10,
                    widget: GroteskText(
                      text: "850",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GaugeAnnotation(
                    positionFactor: 0.25,
                    angle: 90,
                    widget: GroteskText(
                      text: "Score",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                ranges: <GaugeRange>[
                  GaugeRange(
                    startValue: 300,
                    endValue: 450.0,
                    color: Colors.red,
                    startWidth: 8,
                    endWidth: 8,
                  ),
                  GaugeRange(
                    startValue: 450,
                    endValue: 580,
                    color: Colors.orange,
                    startWidth: 8,
                    endWidth: 8,
                  ),
                  GaugeRange(
                    startValue: 580,
                    endValue: 715.0,
                    color: Colors.yellow,
                    startWidth: 8,
                    endWidth: 8,
                  ),
                  GaugeRange(
                    startValue: 715,
                    endValue: 850,
                    color: Colors.green,
                    startWidth: 8,
                    endWidth: 8,
                  ),
                ],
                pointers: <GaugePointer>[
                  MarkerPointer(
                    value: double.parse(credit.toString()),
                    markerType: MarkerType.triangle,
                    enableDragging: true,
                    markerWidth: 7,
                    markerHeight: 10,
                    markerOffset: 15,
                    color: const Color(0xff5F6D7E),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 65.w,
            right: 65.w,
            top: 30.h,
            child: SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                children: [
                  Image.asset(ZeehAssets.ellipse1),
                  Positioned(
                    left: 30.w,
                    right: 30.w,
                    top: 20.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GroteskText(
                          text: "$credit",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        GroteskText(
                          text: "-",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
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
  });

  final String title;
  final String description;
  final String imageAsset;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h, top: 8.h),
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
                DMSanText(
                  text: title,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 4.h),
                SizedBox(
                  width: 206.w,
                  child: DMSanText(
                    text: description,
                    fontSize: 10.sp,
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
    );
  }
}

class WorthWidget extends StatelessWidget {
  const WorthWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.description,
    this.descriptionColor,
    this.onDesTap,
  });

  final String? title;
  final String? amount;
  final String? description;
  final Color? descriptionColor;
  final VoidCallback? onDesTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 122.h,
      width: 156.w,
      padding: EdgeInsets.only(left: 16.w, top: 17.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xffD7D7D7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GroteskText(
            text: title ?? "",
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          SizedBox(height: 15.h),
          SpaceGroteskText(
            text: amount ?? "",
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: onDesTap,
            child: GroteskText(
              text: description ?? "",
              fontWeight: FontWeight.w500,
              textColor: descriptionColor ?? ZeehColors.buttonPurple,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

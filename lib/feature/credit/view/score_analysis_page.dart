import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/feature/home/view/service_offer/service_offer_page.dart';

import '../../../constants/asset_paths.dart';
import '../../../constants/colors.dart';
import '../../home/view/widgets/home_header_widget_two.dart';

class ScoreAnalysis extends StatefulWidget {
  const ScoreAnalysis({super.key});

  @override
  State<ScoreAnalysis> createState() => _ScoreAnalysisState();
}

class _ScoreAnalysisState extends State<ScoreAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: 375.w,
          decoration: const BoxDecoration(color: ZeehColors.scaffoldBackground),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeaderWidgetTwo(title: "Score Analysis"),
             // const Divider(),
              SizedBox(
                height: 1.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DMSanText(
                      text:
                          "See how we have analyzed your credit behavior over the last 3 years and how it has affected your credit score now.",
                      fontSize: 14.sp,
                      textColor: ZeehColors.grayColor,
                      maxLines: 4,
                    ),
                    SizedBox(height: 16.h),
                    DMSanText(
                      text: "Your payment history",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 13.h),
                    DMSanText(
                      text: "See how you have faired in paying back loans",
                      fontSize: 13.sp,
                      textColor: ZeehColors.grayColor,
                    ),
                    SizedBox(height: 18.h),
                    // ignore: prefer_const_constructors
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: const ScoreAnalysisCard(
                              mainText: "Missed Payments",
                              subText: "Over the past 3 years",
                              data: [
                                "0",
                                "0",
                                "0",
                                "0",
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: const ScoreAnalysisCard(
                              mainText: "Failed Payments",
                              subText: "Over the past 3 years",
                              data: [
                                "0",
                                "0",
                                "0",
                                "0",
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 38.h),
                    const NoteWidget(
                        text:
                            "Paying back your loans on time can help boost your credit score and borrowing power. Avoid loans with high interest rates."),
                    SizedBox(height: 88.h),
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

class ScoreAnalysisCard extends StatelessWidget {
  const ScoreAnalysisCard({
    super.key,
    required this.mainText,
    required this.subText,
    required this.data,
  });

  final String mainText;
  final String subText;
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 242.w,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xffD7D7D7)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DMSanText(
            text: mainText,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 7.h),
          DMSanText(
            text: subText,
            fontSize: 12.sp,
            textColor: ZeehColors.grayColor,
          ),
          SizedBox(height: 7.h),
          Column(
            children: [
              ScoreAnalysisListWidget(
                  textLeft: "0-6 months",
                  textRight: data[0],
                  imageAsset: ZeehAssets.exclamationIcon),
              const Divider(
                thickness: 1,
                color: Color(0xffD7D7D7),
              ),
              ScoreAnalysisListWidget(
                textLeft: "7-12 months",
                textRight: data[1],
              ),
              const Divider(
                thickness: 1,
                color: Color(0xffD7D7D7),
              ),
              ScoreAnalysisListWidget(
                  textLeft: "1-2 Years",
                  textRight: data[2],
                  imageAsset: ZeehAssets.exclamationIcon),
              const Divider(thickness: 1, color: Color(0xffD7D7D7)),
              ScoreAnalysisListWidget(
                textLeft: "2-3 Years",
                textRight: data[3],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ScoreAnalysisListWidget extends StatelessWidget {
  const ScoreAnalysisListWidget({
    super.key,
    required this.textRight,
    required this.textLeft,
    this.imageAsset,
  });

  final String textRight;
  final String textLeft;
  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (imageAsset != null)
                CircleAvatar(
                  backgroundColor: const Color(0xffEA1456),
                  radius: 13.r,
                  child: Image.asset(
                    imageAsset!,
                    height: 18.h,
                    width: 18.w,
                  ),
                )
              else
                CircleAvatar(
                  backgroundColor: const Color(0xff2A9921),
                  radius: 13.r,
                  child: Icon(
                    Icons.check_circle_outline,
                    size: 18.sp,
                    color: Colors.black,
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: DMSanText(
                  text: textLeft,
                  textColor: Colors.black,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          DMSanText(
            text: textRight,
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
          )
        ],
      ),
    );
  }
}

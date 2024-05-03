import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/empty_state_widget.dart';

import '../../../common/components/text_widget.dart';
import '../../../constants/colors.dart';
import '../../home/view/widgets/home_header_widget_two.dart';

class ScoreHistory extends StatefulWidget {
  const ScoreHistory({super.key});

  @override
  State<ScoreHistory> createState() => _ScoreHistoryState();
}

class _ScoreHistoryState extends State<ScoreHistory> {
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
              const HomeHeaderWidgetTwo(title: "Score History"),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Score History and Calendar
                        const DMSanText(
                          text: "12 months history",
                          fontWeight: FontWeight.w500,
                        ),
                        Center(
                          child: Container(
                            width: 90.w,
                            height: 35.h,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: ZeehColors.greyColor),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DMSanText(
                                  text: "2023",
                                  fontSize: 13.sp,
                                  textColor: ZeehColors.buttonPurple,
                                  fontWeight: FontWeight.w500,
                                ),
                                const Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    const EmptyStateWidget(description: "No History Yet"),

                    SizedBox(
                      height: 150.h,
                    ),

                    // Score History List
                    // const ScoreHistoryList(
                    //   imageAsset: ZeehAssets.arrowUpGreen,
                    //   textLeft: "600",
                    //   textLeftSub: "Fair",
                    //   textRight: "As at January",
                    // ),
                    // const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    // const ScoreHistoryList(
                    //   imageAsset: ZeehAssets.arrowUpGreen,
                    //   textLeft: "700",
                    //   textLeftSub: "Good",
                    //   textRight: "As at Febuary",
                    // ),
                    // const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    // const ScoreHistoryList(
                    //   imageAsset: ZeehAssets.arrowDownRed,
                    //   textLeft: "600",
                    //   textLeftSub: "Fair",
                    //   textRight: "As at March",
                    // ),
                    // const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    // const ScoreHistoryList(
                    //   imageAsset: ZeehAssets.arrowDownRed,
                    //   textLeft: "600",
                    //   textLeftSub: "Fair",
                    //   textRight: "As at May",
                    // ),
                    // const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    // const ScoreHistoryList(
                    //   imageAsset: ZeehAssets.arrowUpGreen,
                    //   textLeft: "700",
                    //   textLeftSub: "Good",
                    //   textRight: "As at June",
                    // ),
                    // const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    // const ScoreHistoryList(
                    //   imageAsset: ZeehAssets.arrowUpGreen,
                    //   textLeft: "700",
                    //   textLeftSub: "Good",
                    //   textRight: "As at July",
                    // ),
                    // const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    // const ScoreHistoryList(
                    //   imageAsset: ZeehAssets.arrowDownRed,
                    //   textLeft: "600",
                    //   textLeftSub: "Fair",
                    //   textRight: "As at August",
                    // ),
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

class ScoreHistoryList extends StatelessWidget {
  const ScoreHistoryList({
    super.key,
    required this.imageAsset,
    required this.textLeft,
    required this.textLeftSub,
    required this.textRight,
  });

  final String imageAsset;
  final String textLeft;
  final String textLeftSub;
  final String textRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.h),
      child: SizedBox(
        height: 60.h,
        child: Padding(
          padding: EdgeInsets.only(top: 10.0.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imageAsset,
                height: 24.h,
                width: 24.w,
              ),
              SizedBox(width: 16.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GroteskText(
                    text: textLeft,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 7.h),
                  GroteskText(
                    text: textLeftSub,
                    fontSize: 14.sp,
                    maxLines: 4,
                    textColor: ZeehColors.grayColor,
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GroteskText(
                    text: textRight,
                    fontSize: 14.sp,
                    maxLines: 4,
                    textColor: ZeehColors.grayColor,
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

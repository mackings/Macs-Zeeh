import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/feature/home/view/home_screen.dart';

import '../../../constants/colors.dart';
import '../../home/view/widgets/home_header_widget_two.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage(
      {super.key, required this.contentText, required this.headerText});

  final String contentText;
  final String headerText;
  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 812.h,
            width: 375.w,
            decoration:
                const BoxDecoration(color: ZeehColors.scaffoldBackground),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeaderWidgetTwo(
                  title: widget.headerText,
                  showBackButton: false,
                ),
                SizedBox(
                  height: 17.h,
                ),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 120.h,
                      ),
                      SizedBox(
                        width: 120.w,
                        height: 120.h,
                        child: Image.asset(ZeehAssets.successIcon),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GroteskText(
                        text: "Success!",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 300.sp,
                        child: SpaceGroteskText(
                          text: widget.contentText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          maxLines: 4,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 165.h,
                      ),
                      ZeehButton(
                        onClick: () => {
                          pushUntil(context, const HomeScreen()),
                        },
                        text: "Return Home",
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

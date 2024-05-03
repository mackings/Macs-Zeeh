import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';


class Onboarding2 extends StatelessWidget {
  const Onboarding2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: 500.h,
            width: 327.w,
            child: Image.asset(
              ZeehAssets.onboardingImage2,
              height: 500.h,
              width: 327.w,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: SizedBox(
              width: 327.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GroteskText(
                        text: "Investments got easier",
                        textColor: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                        maxLines: 2,
                      ),
                      SizedBox(height: 10.h),
                      GroteskText(
                        text:
                            "Enjoy commission free stock trading. Online investing has never been easy than it is right now",
                        textColor: const Color(0xffCECECE),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

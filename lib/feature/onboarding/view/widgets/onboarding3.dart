import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: double.infinity,
            height: 345.h,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    ZeehAssets.card2,
                    height: 290.h,
                    width: 305.w,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    ZeehAssets.card1,
                    height: 235.h,
                    width: 305.w,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 327.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GroteskText(
                text: "More credit,",
                textColor: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.w500,
                maxLines: 2,
              ),
              GroteskText(
                text: "More Merit",
                textColor: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.w500,
                maxLines: 2,
              ),
              SizedBox(height: 10.h),
              GroteskText(
                text:
                    "By connecting your bank, your credit score gives you more range to interesting services",
                textColor: const Color(0xffCECECE),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

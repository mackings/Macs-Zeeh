import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';

class AlmosThereTopWidget extends StatelessWidget {
  const AlmosThereTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 365.h,
        child: Stack(
          children: [
            SvgPicture.asset(
              ZeehAssets.getStartedRectangle,
              width: double.infinity,
              height: 365.h,
            ),
            Positioned(
              left: 50.w,
              right: 50.w,
              child: Column(
                children: [
                  SvgPicture.asset(
                    ZeehAssets.zeehVectorImage,
                    width: 180.w,
                    height: 180.h,
                  ),
                  Column(
                    children: [
                      GroteskText(
                        text: "Almost there!",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        textColor: const Color(0xff242739),
                      ),
                      SizedBox(height: 16.h),
                      GroteskText(
                        text: "Sign up or login to continue",
                        fontSize: 16.sp,
                        textColor: const Color(0xff242739),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

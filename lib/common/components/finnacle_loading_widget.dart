import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';

class FinnacleLoadingWidget extends StatelessWidget {
  const FinnacleLoadingWidget({
    super.key,
    this.loadingText,
  });

  final String? loadingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 812.h,
      width: 375.w,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                const SizedBox(
                  height: 130,
                  width: 130,
                  child: CircularProgressIndicator(
                    color: Color(0xff6936F5),
                    strokeWidth: 4,
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 38.5,
                  child: SvgPicture.asset(
                    ZeehAssets.zeehVectorImage,
                    color: ZeehColors.buttonPurple,
                    height: 40,
                    width: 45,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            GroteskText(
              text: loadingText ?? "Creating your account...",
              fontSize: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}



class FinnacleLoadingWidget2 extends StatelessWidget {
  const FinnacleLoadingWidget2({
    super.key,
    this.loadingText,
  });

  final String? loadingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 812.h,
      width: 375.w,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                const SizedBox(
                  height: 130,
                  width: 130,
                  child: CircularProgressIndicator(
                    color: Color(0xff6936F5),
                    strokeWidth: 4,
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 38.5,
                  child: SvgPicture.asset(
                    ZeehAssets.zeehVectorImage,
                    color: ZeehColors.buttonPurple,
                    height: 40,
                    width: 45,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            GroteskText(
              text: loadingText ?? "Personalizing your view",
              fontSize: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}

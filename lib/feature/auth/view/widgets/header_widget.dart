import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    this.screenTitle,
    this.showCancelButton = false,
    this.showBackButton = true,
    this.showSignUpBars = false,
    this.step,
  });

  final String? screenTitle;
  final bool? showCancelButton;
  final bool? showBackButton;
  final bool? showSignUpBars;
  final int? step;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 14.0.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Row(
              children: [
                if (showBackButton == true)
                  SizedBox(
                    width: 24.w,
                    child: const BackButton(),
                  )
                else
                  SizedBox(
                    width: 24.w,
                  ),
                const Spacer(),
                DMSanText(
                  text: screenTitle ?? "Create account",
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),
                const Spacer(),
                if (showCancelButton == true)
                  InkWell(
                    onTap: () => popView(context),
                    child: SvgPicture.asset(
                      ZeehAssets.cancelIcon,
                      height: 24.h,
                      width: 24.w,
                    ),
                  )
                else
                  SizedBox(
                    width: 24.w,
                  )
              ],
            ),
          ),
          SizedBox(height: 5.h),
          if (showSignUpBars == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 2.h,
                  width: 100.w,
                  color: const Color(0xFF6936F5),
                ),
                SizedBox(width: 10.w),
                Container(
                  height: 2.h,
                  width: 100.w,
                  color: step! >= 2
                      ? const Color(0xFF6936F5)
                      : const Color(0xFFF8F9FD),
                ),
                SizedBox(width: 10.w),
                Container(
                  height: 2.h,
                  width: 100.w,
                  color: step == 3
                      ? const Color(0xFF6936F5)
                      : const Color(0xFFF8F9FD),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

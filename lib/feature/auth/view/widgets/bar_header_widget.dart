import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';

class BarHeaderWidget extends StatelessWidget {
  const BarHeaderWidget({
    super.key,
    this.screenTitle,
    this.showCancelButton = false,
    required this.blackBars,
    required this.greyBars,
    this.showBackButton,
  });

  final String? screenTitle;
  final bool? showCancelButton;

  final bool? showBackButton;

  final int blackBars;
  final int greyBars;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 18.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 26.0.w,
            ),
            child: Row(
              children: [
                showBackButton == true
                    ? SizedBox(
                        width: 24.w,
                        child: const BackButton(),
                      )
                    : SizedBox(
                        width: 24.w,
                      ),
                const Spacer(),
                Row(
                  children: [
                    ...List.generate(
                      blackBars,
                      (index) => Container(
                        width: 40.w,
                        height: 4.h,
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: ZeehColors.blackColor,
                        ),
                      ),
                    ),
                    ...List.generate(
                      greyBars,
                      (index) => Container(
                        width: 40.w,
                        height: 4.h,
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: ZeehColors.greyColor,
                        ),
                      ),
                    ),
                  ],
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
        ],
      ),
    );
  }
}

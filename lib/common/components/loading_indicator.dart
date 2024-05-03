import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:zeeh_mobile/constants/colors.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({
    super.key,
    this.height,
    this.width,
    this.color,
  });

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40.h,
      width: width ?? 40.w,
      child: const LoadingIndicator(
        indicatorType: Indicator.ballScaleRippleMultiple,
        colors: [
          ZeehColors.buttonPurple,
        ],
      ),
    );
  }
}

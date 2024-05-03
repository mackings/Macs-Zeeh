import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';

import '../../constants/colors.dart';

class ZeehButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Function onClick;
  final String text;
  final double? radius;
  final Color? buttonColor;
  final Color? textColor;
  final Color? progressColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final bool isOutline;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;

  const ZeehButton(
      {super.key,
      required this.onClick,
      required this.text,
      this.height,
      this.width,
      this.radius,
      this.buttonColor,
      this.textColor,
      this.progressColor,
      this.textSize,
      this.fontWeight,
      this.isOutline = false,
      this.borderColor,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 327.w,
      height: height ?? 48.h,
      child: Container(
        height: height ?? 56.h,
        width: width ?? 330.w,
        decoration: BoxDecoration(
          color:
              isOutline ? Colors.white : buttonColor ?? ZeehColors.buttonPurple,
          borderRadius: radius != null
              ? BorderRadius.circular(radius!)
              : BorderRadius.circular(8.0.r),
          border: isOutline
              ? Border.all(
                  color: borderColor ?? ZeehColors.buttonPurple,
                )
              : null,
        ),
        child: InkWell(
          onTap: () {
            onClick();
          },
          borderRadius: radius != null
              ? BorderRadius.circular(radius!)
              : BorderRadius.circular(8.0.r),
          child: Center(
            child: DMSanText(
              text: text,
              textColor: isOutline
                  ? ZeehColors.buttonPurple
                  : textColor ?? Colors.white,
              fontSize: textSize ?? 16.h,
              fontWeight: fontWeight ?? FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class AppLoadingButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;

  const AppLoadingButton({
    Key? key,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 327.w,
      height: height ?? 48.h,
      child: Container(
        height: height ?? 56.h,
        width: width ?? 330.w,
        decoration: BoxDecoration(
          color: ZeehColors.buttonPurple,
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8.0.r),
          child: Center(
            child: SizedBox(
              height: 30.h,
              width: 30.w,
              child: const LoadingIndicator(
                indicatorType: Indicator.semiCircleSpin,
                colors: [
                  Colors.white,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final Widget? child;

  ///If child is null the child is assumed to be a text widget
  final String text;
  const AppOutlinedButton({
    super.key,
    this.onPressed,
    this.child,
    required this.text,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 320.w,
      height: height ?? 50.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          // border Radius 8.r
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onPressed: onPressed,
        child: child ??
            DMSanText(
              text: text,
              fontWeight: FontWeight.w500,
              textColor: const Color(0xff242739),
            ),
      ),
    );
  }
}

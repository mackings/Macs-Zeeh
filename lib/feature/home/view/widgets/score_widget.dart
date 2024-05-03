import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';

class ScoreDivider extends StatelessWidget {
  const ScoreDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      width: 2.w,
      color: const Color(0xFFEBEBEB),
    );
  }
}

class CreditScoreWidget extends StatelessWidget {
  const CreditScoreWidget({
    super.key,
    this.score,
  });

  final String? score;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 111.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DMSanText(
            text: "Credit score",
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textColor: const Color(0xff5F6D7E),
          ),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DMSanText(
                text: score ?? "0",
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(width: 5),
              // Icon(
              //   Icons.arrow_upward_outlined,
              //   color: const Color(0xff2A9921),
              //   size: 15.sp,
              // ),
              // DMSanText(
              //   text: "5pts",
              //   textColor: const Color(0xff2A9921),
              //   fontSize: 12.sp,
              // ),
            ],
          )
        ],
      ),
    );
  }
}

class NetworthWidget extends StatelessWidget {
  const NetworthWidget({
    super.key,
    this.networth,
  });

  final String? networth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DMSanText(
          text: "Net Worth",
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          textColor: const Color(0xff5F6D7E),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            SpaceGroteskText(
              text: "₦",
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
            DMSanText(
              text: networth ?? "0.00",
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ],
    );
  }
}

class DebtWidget extends StatelessWidget {
  const DebtWidget({
    super.key,
    this.debt,
    this.debtColor,
    this.label,
    this.showNumber = false,
    this.number,
  });

  final String? debt;
  final Color? debtColor;
  final String? label;
  final bool? showNumber;
  final String? number;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DMSanText(
          text: label ?? "Debt",
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          textColor: const Color(0xff5F6D7E),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            if (showNumber == true)
              SpaceGroteskText(
                text: number ?? "0",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            SpaceGroteskText(
              text: debt ?? "₦0.00",
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              textColor: debtColor,
            ),
          ],
        ),
      ],
    );
  }
}

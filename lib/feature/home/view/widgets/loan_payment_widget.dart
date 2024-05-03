import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/components/text_widget.dart';
import '../../../../constants/colors.dart';

class LoanPaymentWidget extends StatelessWidget {
  const LoanPaymentWidget({
    Key? key,
    required this.headerLeft,
    required this.descriptionLeft,
    this.rightWidget,
    this.spacing = 16,
  }) : super(key: key);

  final String headerLeft;
  final String descriptionLeft;
  final Widget? rightWidget;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GroteskText(
            maxLines: 2,
            text: headerLeft,
            textColor: ZeehColors.grayColor,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
          ),
          SizedBox(height: spacing!.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GroteskText(
                maxLines: 2,
                text: descriptionLeft,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
              rightWidget ?? const SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }
}

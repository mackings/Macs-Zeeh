import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';

import '../../../../common/components/currency_function.dart';

class PaybackLoan extends StatelessWidget {
  const PaybackLoan({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 4.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GroteskText(
                      text: 'Pay off outstanding loans',
                      fontWeight: FontWeight.w500,
                    ),
                    Divider(
                      thickness: 1,
                      color: ZeehColors.greyColor,
                      endIndent: 135.w,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          ZeehAssets.receiveDollarIcon,
                          height: 40.h,
                          width: 40.w,
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GroteskText(
                                  text: 'Next Payment Date',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  textColor: ZeehColors.grayColor,
                                ),
                                SizedBox(width: 5.w),
                                GroteskText(
                                  text: ': 17th July, 2023',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GroteskText(
                                  text: 'Amount to be paid',
                                  fontSize: 14.sp,
                                  textColor: ZeehColors.grayColor,
                                ),
                                SizedBox(width: 5.w),
                                GroteskText(
                                  text: ": ₦${amountFormatter(5000)}",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: ZeehColors.grayColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/colors.dart';

class LoanOffersList extends StatelessWidget {
  const LoanOffersList({
    super.key,
    required this.imageAsset,
    required this.textLeft1,
    required this.textLeft2,
    required this.textLeft3,
    required this.textRight1,
    this.eligible = false,
  });

  final String imageAsset;
  final String textLeft1;
  final String textLeft2;
  final String textLeft3;
  final String textRight1;
  final bool? eligible;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 58.w,
                height: 58.h,
                child: Image.network(imageAsset),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GroteskText(
                      text: textLeft1,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    SpaceGroteskText(
                      text: textLeft2,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    GroteskText(
                      text: textLeft3,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      textColor: ZeehColors.buttonPurple,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (eligible == true)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(71, 33, 159, 21),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: GroteskText(
                        text: "Eligible",
                        textColor: const Color(0xff209F15),
                        fontSize: 12.sp,
                      ),
                    )
                  else if (eligible == false)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x1AEA1414),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: GroteskText(
                        text: "Not Eligible",
                        textColor: const Color(0xffEA1414),
                        fontSize: 12.sp,
                      ),
                    ),
                  SizedBox(height: 21.h),
                  GroteskText(
                    text: textRight1,
                    fontSize: 10.sp,
                    maxLines: 4,
                    fontWeight: FontWeight.w400,
                    textColor: ZeehColors.grayColor,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 7.w),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: ZeehColors.grayColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

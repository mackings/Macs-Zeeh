import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/components/text_widget.dart';
import '../../../../constants/colors.dart';

class LoanProgressWidget extends StatelessWidget {
  const LoanProgressWidget({
    super.key,
    this.imageAsset,
    required this.textTop,
    required this.textBottomLeft,
    required this.textBottomRight,
    this.textBottomRightDescription,
    this.textBottomLeftDescription,
    this.description,
  });

  final String? imageAsset;
  final String textTop;
  final String textBottomLeft;
  final String textBottomRight;
  final String? textBottomRightDescription;
  final String? textBottomLeftDescription;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SpaceGroteskText(
              text: textTop,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            if (imageAsset != null)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Image.asset(
                  imageAsset!,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
          ],
        ),
        SizedBox(height: 3.h),
        Stack(
          children: [
            Container(
              width: 330.w,
              height: 15.h,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: ZeehColors.buttonPurple),
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              ),
            ),
            Positioned(
              top: 4.h,
              left: 4.w,
              child: Container(
                width: 10.w,
                height: 7.h,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: ZeehColors.buttonPurple,
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SpaceGroteskText(
              text: textBottomLeft,
              fontSize: 12.sp,
            ),
            SpaceGroteskText(
              text: textBottomRight,
              fontSize: 12.sp,
            )
          ],
        ),
        SizedBox(height: 3.h),
        if (textBottomLeftDescription != null ||
            textBottomRightDescription != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GroteskText(
                text: textBottomLeftDescription!,
                fontSize: 11.sp,
              ),
              GroteskText(
                text: textBottomRightDescription!,
                fontSize: 11.sp,
              )
            ],
          ),
        SizedBox(height: 10.h),
        if (description != null)
          GroteskText(
            text: description!,
            fontSize: 12.sp,
            textColor: ZeehColors.grayColor,
            maxLines: 4,
          ),
      ],
    );
  }
}

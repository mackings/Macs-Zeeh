import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/colors.dart';


class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.buttonName,
  });

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      height: 58.h,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
        border: Border.all(
          color: ZeehColors.greyColor,
        ),
      ),
      child: Row(
        children: [
          GroteskText(
            text: buttonName,
            fontSize: 14.sp,
          ),
          const Spacer(),
          Icon(
            Icons.keyboard_arrow_down,
            size: 28.sp,
            color: ZeehColors.grayColor,
          ),
        ],
      ),
    );
  }
}
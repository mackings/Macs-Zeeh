
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/colors.dart';

class CalendarButtonWidget extends StatelessWidget {
  const CalendarButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffD7D7D7),
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),
      padding: EdgeInsets.only(
        top: 8.h,
        left: 12.h,
        right: 14.w,
      ),
      height: 34.h,
      width: 172.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GroteskText(
            text: "Today - 24/05/23",
            fontSize: 14.sp,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 0.0.h),
            child: SizedBox(
              height: 16.h,
              width: 16.w,
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ZeehColors.grayColor,
                size: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

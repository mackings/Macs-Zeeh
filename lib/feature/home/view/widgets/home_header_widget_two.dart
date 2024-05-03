import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/components/text_widget.dart';

class HomeHeaderWidgetTwo extends StatelessWidget {
  final String? title;
  final bool? showBackButton;
  const HomeHeaderWidgetTwo({
    super.key,
    this.title,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110.h,
      padding: EdgeInsets.symmetric(horizontal: 26.w),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Spacer(),
          Row(
            children: [
              if (showBackButton == true)
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              const Spacer(),
              DMSanText(
                text: title ?? "",
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
              const Spacer(),
              if (showBackButton == true) SizedBox(width: 20.w),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}

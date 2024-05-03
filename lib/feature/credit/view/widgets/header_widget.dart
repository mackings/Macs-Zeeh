import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';

class MenuHeaderWidget extends StatelessWidget {
  const MenuHeaderWidget({
    super.key,
    this.title,
    this.showBackButton = false,
  });

  final String? title;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 95.h,
      padding: EdgeInsets.symmetric(horizontal: 26.w),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Spacer(),
          Row(
            children: [
              showBackButton
                  ? InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    )
                  : const SizedBox.shrink(),
              const Spacer(),
              DMSanText(
                text: title ?? "Credit",
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
              const Spacer(),
              showBackButton ? SizedBox(width: 20.w) : const SizedBox.shrink(),
            ],
          ),
          SizedBox(height: showBackButton ? 12.h : 16.h)
        ],
      ),
    );
  }
}

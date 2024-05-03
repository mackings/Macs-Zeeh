import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.height,
    required this.description,
  });

  final double? height;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120.h,
        ),
        Center(
          child: Image.asset(
            ZeehAssets.emptyBox,
            width: 70.w,
            height: 70.h,
          ),
        ),
        SizedBox(height: 15.h),
        DMSanText(
          text: description ?? "",
        )
      ],
    );
  }
}

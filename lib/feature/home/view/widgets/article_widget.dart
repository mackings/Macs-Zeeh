import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
    this.assetPath,
    this.onTap,
    this.title,
    this.date,
  });

  final String? assetPath;
  final Function()? onTap;
  final String? title;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 210.h,
        width: 220.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xffCBD5E4),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 220.w,
              height: 125.h,
              child: Container(
                width: 220.w,
                height: 125.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      assetPath ?? ZeehAssets.creditImage1,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 210.w,
              height: 75.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DMSanText(
                      text: title ?? 'Improving your credit score',
                      textColor: const Color(0xFF242739),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    DMSanText(
                      text: date ?? 'Aug. 04 | 2 min reads',
                      textColor: const Color(0xFF5F6D7E),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

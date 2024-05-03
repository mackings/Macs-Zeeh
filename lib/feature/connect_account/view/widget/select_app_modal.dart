import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/connect_account/view/enter_credentials.dart';

class SelectAppContainer extends StatefulWidget {
  const SelectAppContainer({
    super.key,
  });

  @override
  State<SelectAppContainer> createState() => _SelectAppContainerState();
}

class _SelectAppContainerState extends State<SelectAppContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            GroteskText(
              text: "Select an app",
              fontSize: 20.sp,
              textColor: ZeehColors.blackColor,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 18.h),
            GroteskText(
              text:
                  "This bank has multiple apps. Which of them do you want to use?",
              fontSize: 16.sp,
              textColor: ZeehColors.grayColor,
              maxLines: 2,
            ),

            SizedBox(height: 18.h),

            // GTWorld and GTBank

            Wrap(
              runSpacing: 16.h,
              children: const [
                BankMethodContainer(
                  methodName: "GTWorld",
                ),
                BankMethodContainer(
                  methodName: "GTBank",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BankMethodContainer extends StatelessWidget {
  const BankMethodContainer({
    super.key,
    this.methodName,
  });

  final String? methodName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigate(context, const EnterCredentialsScreen()),
      child: Container(
        width: 327.w,
        height: 64.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xff5F6D7E).withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(ZeehAssets.gtbankIcon),
            SizedBox(width: 16.w),
            GroteskText(
              text: methodName ?? "GTBank",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: ZeehColors.grayColor,
            ),
          ],
        ),
      ),
    );
  }
}

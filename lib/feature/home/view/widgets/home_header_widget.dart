import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/feature/profile/view/profile_screen.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
    required this.userName,
    required this.userImage,
  });

  final String userName;
  final String userImage;

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
              InkWell(
                onTap: () => navigate(context, const ProfileScreen()),
                child: SvgPicture.asset(
                  ZeehAssets.profileIcon,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
              const Spacer(),
              GroteskText(
                text: "Welcome $userName!",
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
              const Spacer(),
              SizedBox(width: 20.w),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}

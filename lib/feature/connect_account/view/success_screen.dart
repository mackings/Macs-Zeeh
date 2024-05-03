import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh/zeeh.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/background_modal.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/bar_header_widget.dart';
import 'package:zeeh_mobile/feature/home/view/home_screen.dart';

class ConnectAccountSuccessScreen extends StatefulWidget {
  const ConnectAccountSuccessScreen({super.key, required this.userId});

  final String userId;

  @override
  State<ConnectAccountSuccessScreen> createState() =>
      _ConnectAccountSuccessScreenState();
}

class _ConnectAccountSuccessScreenState
    extends State<ConnectAccountSuccessScreen> {
  handleInitialization() async {
    final zeeh = Zeeh.start(
      context: context,
      publicKey: 'pk_v7rBtZlIijh4kn5fWA3F5jPzq',
      orgId:
          'bbe3eaffe73d6263d2779f4913d5d7f19467fdf1419d86cd5e39f2f4aeda64325ead1f8cdd5f15e2',
      userReference: widget.userId,
    );

    // Get response data
    final response = await zeeh.initialize();
    if (response.message != null) {
      // debugPrint(response.message);
    } else {
      // debugPrint("No Response!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZeehColors.onboardingBackground,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Stack(
            children: [
              const BackgroundModal(),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 750.h,
                  width: 375.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffF8F9FD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      const BarHeaderWidget(
                        blackBars: 4,
                        greyBars: 0,
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        width: 375.w,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 140.h),

                            SvgPicture.asset(
                              ZeehAssets.connectVector,
                              height: 111.h,
                              width: 111.w,
                            ),

                            SizedBox(height: 30.h),

                            // Welcome Back!
                            GroteskText(
                              text: "Connection Success!",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 16.h),

                            // Enter your email to sign in
                            SizedBox(
                              width: 313.w,
                              child: GroteskText(
                                text:
                                    "Your account has been successfully connected. Return home to view your credit score",
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                textColor: const Color(0xff242739),
                              ),
                            ),

                            SizedBox(height: 120.h),

                            ZeehButton(
                              onClick: () => navigate(
                                context,
                                const HomeScreen(),
                              ),
                              text: "Return Home",
                            ),

                            SizedBox(height: 16.h),

                            ZeehButton(
                              onClick: () => handleInitialization,
                              text: "Link More Account",
                              textColor: ZeehColors.buttonPurple,
                              buttonColor: Colors.transparent,
                              isOutline: true,
                              borderColor: const Color(0xffD7D7D7),
                            ),

                            SizedBox(height: 30.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

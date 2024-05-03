import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/face_recognition/face_capture_screen.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';

import '../../../../../constants/colors.dart';

class FaceCaptureInfoScreen extends StatefulWidget {
  const FaceCaptureInfoScreen({
    super.key,
    required this.bvn,
    this.isSignUp,
  });

  final String bvn;
  final bool? isSignUp;

  @override
  State<FaceCaptureInfoScreen> createState() => _FaceCaptureInfoScreenState();
}

class _FaceCaptureInfoScreenState extends State<FaceCaptureInfoScreen> {
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
              SizedBox(
                height: 406.h,
                width: double.infinity,
                child: FittedBox(
                  child: Image.asset(
                    ZeehAssets.onboardingImageBgV2,
                  ),
                ),
              ),

              // Login
              Positioned(
                bottom: 0,
                child: Container(
                  height: 700.h,
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
                      // Success
                      const HeaderWidget(
                        showBackButton: false,
                        screenTitle: "Face capture",
                        showCancelButton: true,
                      ),

                      SizedBox(height: 100.h),

                      // Confetti Image
                      Image.asset(
                        ZeehAssets.screenshotIcon,
                        height: 100.h,
                        width: 100.w,
                      ),

                      // Congrats David
                      SizedBox(height: 20.h),

                      SizedBox(
                        width: 260.w,
                        child: DMSanText(
                          text:
                              "Face capture is a convenient method of verifying your identity.",
                          fontSize: 16.sp,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600,
                          maxLines: 3,
                        ),
                      ),

                      SizedBox(height: 40.h),

                      SizedBox(
                        width: 305.w,
                        child: DMSanText(
                          text:
                              "Getting you ready for capture. For smooth capturing, ensure you are in a bright area and place your face directly to the centre of your camera.",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          maxLines: 4,
                        ),
                      ),

                      SizedBox(height: 100.h),

                      Column(
                        children: [
                          ZeehButton(
                            onClick: () => navigate(
                              context,
                              FaceCaptureScreen(
                                bvn: widget.bvn,
                                isSignUp: widget.isSignUp,
                              ),
                            ),
                            text: "Take Selfie",
                          ),
                        ],
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

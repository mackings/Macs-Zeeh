import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh/zeeh.dart';
import 'package:zeeh_mobile/common/components/app_snackbar.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/facial_verify_model.dart';
import 'package:zeeh_mobile/feature/connect_account/data/state/connect_notifier.dart';
import 'package:zeeh_mobile/feature/provider.dart';

class FaceCaptureScreen extends ConsumerStatefulWidget {
  const FaceCaptureScreen({
    super.key,
    required this.bvn,
    this.isSignUp,
  });

  final String bvn;
  final bool? isSignUp;

  @override
  ConsumerState<FaceCaptureScreen> createState() => _FaceCaptureScreenState();
}

class _FaceCaptureScreenState extends ConsumerState<FaceCaptureScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileStateNotifierProvider.notifier).userDetails();
    });
  }

  File? capturedImage;

  FacialVerify facialVerify = FacialVerify();

  // Handle Zeeh package initialization here.
  handleInitialization(String userId) async {
    final zeeh = Zeeh.start(
      context: context,
      publicKey: 'pk_v7rBtZlIijh4kn5fWA3F5jPzq',
      orgId:
          'bbe3eaffe73d6263d2779f4913d5d7f19467fdf1419d86cd5e39f2f4aeda64325ead1f8cdd5f15e2',
      userReference: userId,
    );
    // Get response data
    final response = await zeeh.initialize();
    if (response.message != null) {
      debugPrint(response.message);
    } else {
      debugPrint("No Response!");
    }
  }

  void handleFacialVerification(WidgetRef ref) async {
    ref.read(connectStateNotifierProvider.notifier).uploadImage(
        widget.bvn, File(capturedImage!.path), widget.isSignUp ?? false);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(connectStateNotifierProvider);

    if (state is ImageUploadSuccess) {
      facialVerify = state.facialVerify;
    }

    ref.listen(
      connectStateNotifierProvider,
      (previous, next) {
        if (next is ImageUploadFailure) {
          AppSnackbar(context, isError: true)
              .showToast(text: next.failure.message);
        } else if (next is ImageUploadSuccess) {
          facialVerify = next.facialVerify;

          AppSnackbar(context)
              .showToast(text: "Face Verification Successful...");

          popView(context);
          popView(context);

          handleInitialization(facialVerify.userId.toString());
        }
      },
    );

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: ZeehColors.onboardingBackground,
        body: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    if (capturedImage != null)
                      Column(
                        children: [
                          Center(
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Image.file(
                                  capturedImage!,
                                  width: double.maxFinite,
                                  fit: BoxFit.fitWidth,
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      setState(() => capturedImage = null),
                                  child: const Text(
                                    'Capture Again',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "DM Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 70.h),

                          // const Spacer(),
                          Wrap(
                            runSpacing: 16.h,
                            children: [
                              if (state is ImageUploadLoading)
                                const AppLoadingButton()
                              else
                                ZeehButton(
                                  onClick: () => {
                                    if (capturedImage != null)
                                      {
                                        handleFacialVerification(ref),
                                      }
                                    else
                                      {
                                        AppSnackbar(context).showToast(
                                          text: "No face detected",
                                        )
                                      }
                                  },
                                  text: "Use this picture",
                                ),
                              ZeehButton(
                                onClick: () {
                                  setState(() => capturedImage = null);
                                },
                                text: "Take another photo",
                                textColor: ZeehColors.blackColor,
                                buttonColor: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      )
                    else
                      SmartFaceCamera(
                        autoCapture: true,
                        defaultCameraLens: CameraLens.front,
                        onCapture: (File? image) {
                          setState(() {
                            capturedImage = image;
                          });
                        },
                        onFaceDetected: (Face? face) {
                          // Do Something
                        },
                        messageBuilder: (context, face) {
                          if (face == null) {
                            return _message("Place your face in the camera");
                          }
                          if (!face.wellPositioned) {
                            return _message("Centre your face in the square");
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _message(String message) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 15.0),
        child: GroteskText(
          text: message,
          fontSize: 14.sp,
          textAlign: TextAlign.center,
        ),
      );
}

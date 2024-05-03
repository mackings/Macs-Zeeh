import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/app_snackbar.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/dropdowns/country_dropdown_button.dart';
import 'package:zeeh_mobile/common/components/dropdowns/verification_channel_dropdown.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/components/textfield_box.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/face_recognition/face_capture_info_screen.dart';
import 'package:zeeh_mobile/feature/connect_account/data/state/connect_notifier.dart';
import 'package:zeeh_mobile/feature/provider.dart';

class VerifyIdentityScreen extends ConsumerStatefulWidget {
  const VerifyIdentityScreen({super.key, this.isSignUp});

  final bool? isSignUp;

  @override
  ConsumerState<VerifyIdentityScreen> createState() =>
      _VerifyIdentityScreenState();
}

class _VerifyIdentityScreenState extends ConsumerState<VerifyIdentityScreen> {
  String selectedCountry = "";
  String selectedChannel = "";

  bool isBvnEntered = false;

  TextEditingController bvnController = TextEditingController();

  @override
  void initState() {
    super.initState();

    bvnController.addListener(() {
      setState(() {
        if (bvnController.text.length == 11) {
          isBvnEntered = true;
        } else {
          isBvnEntered = false;
        }
      });
    });
  }

  void handleVerifyIdentity(WidgetRef ref) {
    ref
        .read(connectStateNotifierProvider.notifier)
        .bvnLookup(bvnController.text, widget.isSignUp ?? false);
  }

  @override
  Widget build(BuildContext context) {
    final connectState = ref.watch(connectStateNotifierProvider);

    ref.listen(connectStateNotifierProvider, (previous, next) {
      if (next is BVNLookupFailureState) {
        AppSnackbar(context, isError: true)
            .showToast(text: next.failure.message);
      } else if (next is BVNLookupSuccessState) {
        AppSnackbar(context)
            .showToast(text: next.responseModel.message.toString());
        navigateReplace(
          context,
          FaceCaptureInfoScreen(
            bvn: bvnController.text,
            isSignUp: widget.isSignUp,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: ZeehColors.onboardingBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Credentials
                            SizedBox(height: 16.h),

                            // We've sent a mail
                            Container(
                              width: 375.w,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 16.h),

                                  // Info!
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DMSanText(
                                          text: "Verify your Identity",
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 10.h),
                                        DMSanText(
                                          text:
                                              "Please select and enter the fields below for your verification ",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                ],
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // Your Code
                            Expanded(
                              child: Container(
                                width: 375.w,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                padding:
                                    EdgeInsets.symmetric(horizontal: 24.0.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 24.h),

                                      // Nationality
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DMSanText(
                                            text: "Nationality",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(height: 8.h),
                                          CountryDropdownButton(
                                            onSelectCountry: (country) {
                                              if (country != "") {
                                                selectedCountry = country!;
                                              }
                                            },
                                          )
                                        ],
                                      ),

                                      SizedBox(height: 16.h),

                                      // Nationality
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DMSanText(
                                            text: "Verification Channel",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(height: 8.h),
                                          VerificationChannelDropdownButton(
                                              onSelectChannel: (channel) {
                                            if (channel != "") {
                                              selectedChannel = channel!;
                                            }
                                          })
                                        ],
                                      ),

                                      SizedBox(height: 16.h),

                                      // Nationality
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DMSanText(
                                            text:
                                                "Bank verification number (BVN)",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(height: 8.h),
                                          TextFieldBox(
                                            controller: bvnController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  11),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            height: 56.h,
                                            hintText: "Enter your BVN",
                                          )
                                        ],
                                      ),

                                      // Why we need your BVN?
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 22.h),
                                        child: const BvnExpansionList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.h),
                              child: Container(
                                padding:
                                    EdgeInsets.only(bottom: 31.h, top: 24.h),
                                color: Colors.white,
                                child: Center(
                                  child: connectState is BVNLookupLoadingState
                                      ? const AppLoadingButton()
                                      : ZeehButton(
                                          onClick: () =>
                                              handleVerifyIdentity(ref),
                                          text: "Verify Identity",
                                          buttonColor: isBvnEntered
                                              ? ZeehColors.buttonPurple
                                              : ZeehColors.greyColor,
                                        ),
                                ),
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
          ],
        ),
      ),
    );

    // WillPopScope(
    //   onWillPop: () async {
    //     return true;
    //   },
    //   child: Scaffold(
    //     backgroundColor: ZeehColors.onboardingBackground,
    //     body: SingleChildScrollView(
    //       child: SizedBox(
    //         height: 812.h,
    //         width: 375.w,
    //         child: Stack(
    //           children: [
    //             const BackgroundModal(),

    //             // Login
    //             Positioned(
    //               bottom: 0,
    //               child: Container(
    //                 height: 744.h,
    //                 width: 375.w,
    //                 decoration: BoxDecoration(
    //                   color: const Color(0xffF8F9FD),
    //                   borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(16.r),
    //                     topRight: Radius.circular(16.r),
    //                   ),
    //                 ),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     // Bar Level
    //                     const BarHeaderWidget(
    //                       blackBars: 2,
    //                       greyBars: 2,
    //                     ),

    //                     // Credentials
    //                     SizedBox(height: 16.h),

    //                     // We've sent a mail
    //                     Container(
    //                       width: 375.w,
    //                       decoration: const BoxDecoration(
    //                         color: Colors.white,
    //                       ),
    //                       padding: EdgeInsets.symmetric(horizontal: 24.0.w),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           SizedBox(height: 16.h),

    //                           // Info!
    //                           SizedBox(
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 GroteskText(
    //                                   text: "Verify your Identity",
    //                                   fontSize: 18.sp,
    //                                   fontWeight: FontWeight.w500,
    //                                   maxLines: 2,
    //                                 ),
    //                                 SizedBox(height: 10.h),
    //                                 GroteskText(
    //                                   text:
    //                                       "Please select and enter the fields below for your verification ",
    //                                   fontSize: 14.sp,
    //                                   fontWeight: FontWeight.w400,
    //                                   maxLines: 2,
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(height: 16.h),
    //                         ],
    //                       ),
    //                     ),

    //                     SizedBox(height: 16.h),

    //                     // Your Code
    //                     Expanded(
    //                       child: Container(
    //                         width: 375.w,
    //                         decoration: const BoxDecoration(
    //                           color: Colors.white,
    //                         ),
    //                         padding: EdgeInsets.symmetric(horizontal: 24.0.w),
    //                         child: SingleChildScrollView(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               SizedBox(height: 24.h),

    //                               // Nationality
    //                               Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   GroteskText(
    //                                     text: "Nationality",
    //                                     fontSize: 14.sp,
    //                                     fontWeight: FontWeight.w500,
    //                                   ),
    //                                   SizedBox(height: 8.h),
    //                                   CountryDropdownButton(
    //                                     onSelectCountry: (country) {
    //                                       if (country != "") {
    //                                         selectedCountry = country!;
    //                                       }
    //                                     },
    //                                   )
    //                                 ],
    //                               ),

    //                               SizedBox(height: 16.h),

    //                               // Nationality
    //                               Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   GroteskText(
    //                                     text: "Verification Channel",
    //                                     fontSize: 14.sp,
    //                                     fontWeight: FontWeight.w500,
    //                                   ),
    //                                   SizedBox(height: 8.h),
    //                                   VerificationChannelDropdownButton(
    //                                       onSelectChannel: (channel) {
    //                                     if (channel != "") {
    //                                       selectedChannel = channel!;
    //                                     }
    //                                   })
    //                                 ],
    //                               ),

    //                               SizedBox(height: 16.h),

    //                               // Nationality
    //                               Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   GroteskText(
    //                                     text: "Bank verification number (BVN)",
    //                                     fontSize: 14.sp,
    //                                     fontWeight: FontWeight.w500,
    //                                   ),
    //                                   SizedBox(height: 8.h),
    //                                   TextFieldBox(
    //                                     controller: bvnController,
    //                                     keyboardType: TextInputType.number,
    //                                     inputFormatters: [
    //                                       LengthLimitingTextInputFormatter(11),
    //                                       FilteringTextInputFormatter
    //                                           .digitsOnly,
    //                                     ],
    //                                     height: 56.h,
    //                                     hintText: "Enter your BVN",
    //                                   )
    //                                 ],
    //                               ),

    //                               // Why we need your BVN?
    //                               Padding(
    //                                 padding: EdgeInsets.only(bottom: 22.h),
    //                                 child: const BvnExpansionList(),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: EdgeInsets.only(top: 16.h),
    //                       child: Container(
    //                         padding: EdgeInsets.only(bottom: 31.h, top: 24.h),
    //                         color: Colors.white,
    //                         child: Center(
    //                           child: ZeehButton(
    //                             onClick: () => handleVerifyIdentity(ref),
    //                             text: "Verify Identity",
    //                             buttonColor: isBvnEntered
    //                                 ? ZeehColors.buttonPurple
    //                                 : ZeehColors.greyColor,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),

    //             if (connectState is BVNLookupLoadingState)
    //               const FinnacleLoadingWidget(
    //                 loadingText: "Looking Up BVN...",
    //               ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class VerifyIdentity extends StatelessWidget {
  const VerifyIdentity({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Icon(
            Icons.circle,
            size: 4.r,
          ),
        ),
        SizedBox(width: 6.w),
        GroteskText(text: text, fontSize: 13.sp),
      ],
    );
  }
}

class BvnExpansionList extends StatefulWidget {
  const BvnExpansionList({super.key});

  @override
  State<BvnExpansionList> createState() => _BvnExpansionListState();
}

class _BvnExpansionListState extends State<BvnExpansionList> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      expandIconColor: ZeehColors.grayColor,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          backgroundColor: const Color(0xffF8F9FD),
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Container(
                    height: 18.h,
                    width: 18.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEBEAEE),
                    ),
                    child: Center(
                      child: SvgPicture.asset(ZeehAssets.padlockIcon),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  GroteskText(
                    text: "Why we need your BVN?",
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            );
          },
          body: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GroteskText(
                  text: 'To verify your identity',
                  fontSize: 13.sp,
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 43.w,
                  runSpacing: 4.h,
                  children: const [
                    VerifyIdentity(text: 'Full name'),
                    VerifyIdentity(text: 'Phone number'),
                    VerifyIdentity(text: 'Date of birth'),
                    VerifyIdentity(text: 'Address'),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'N.B',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                            color: ZeehColors.blackColor,
                            fontSize: 11.sp,
                            fontFamily: 'ClashGrotesk',
                          ),
                        ),
                        TextSpan(
                          text:
                              '  Your BVN does not give us access to your bank account',
                          style: TextStyle(
                            color: ZeehColors.blackColor,
                            fontSize: 11.sp,
                            fontFamily: 'ClashGrotesk',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          isExpanded: _isExpanded,
        ),
      ],
    );
  }
}

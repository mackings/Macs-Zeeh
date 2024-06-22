import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:zeeh/core/zeeh.dart';
import 'package:zeeh_mobile/common/components/app_snackbar.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/activity/data/state/activity_state_notifier.dart';
import 'package:zeeh_mobile/feature/activity/model/activity_model.dart';
import 'package:zeeh_mobile/feature/activity/view/activity_screen.dart';
import 'package:zeeh_mobile/feature/auth/data/state/auth_notifier.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/authenticated_user.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/verify_identity.dart';
import 'package:zeeh_mobile/feature/connect_account/data/Linkonweb.dart';
import 'package:zeeh_mobile/feature/credit/data/state/credit_state_notifier.dart';
import 'package:zeeh_mobile/feature/credit/view/build_credit/article_screen.dart';
import 'package:zeeh_mobile/feature/credit/view/build_credit/build_credit.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/article_widget.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/score_widget.dart';
import 'package:zeeh_mobile/feature/profile/data/state/profile_state_notifier.dart';
import 'package:zeeh_mobile/feature/profile/model/user_details.dart';
import 'package:zeeh_mobile/feature/provider.dart';

import '../../auth/view/sign_up/face_recognition/face_capture_info_screen.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  dynamic credit = 0;

  UserDetails userDetails = UserDetails();

  AuthenticatedUser authUser = AuthenticatedUser();

  List<ActivityModel> activities = [];

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);

    final creditState = ref.watch(creditStateNotifierProvider);

    final activitiesState = ref.watch(activitiesStateNotifierProvider);

    if (activitiesState is ActivitiesSuccess) {
      activities = activitiesState.listOfActivities;
    }

    final RefreshController refreshController =
        RefreshController(initialRefresh: false);

    if (authState is LogInSuccessState) {
      authUser = authState.user.user!;
    }

    if (creditState is GetCreditScoreSuccess) {
      credit = creditState.responseModel.data["score"];
    }

    final userDetailsState = ref.watch(profileStateNotifierProvider);

    if (userDetailsState is UserDetailsSuccess) {
      userDetails = userDetailsState.userDetails;
    }

    /// Smart Refresher
    // On Refresh Function
    void onRefresh() async {
      ref.read(creditStateNotifierProvider.notifier).getCreditScore();

      // if failed,use refreshFailed()
      refreshController.refreshCompleted();
    }

    // On Loading Function
    void onLoading() async {
      if (mounted) setState(() {});
      refreshController.loadComplete();
    }

    // Handle Zeeh package initialization here.
    handleInitialization() async {
      final zeeh = Zeeh.start(
        context: context,
        publicKey: 'pk_v7rBtZlIijh4kn5fWA3F5jPzq',
        orgId:
            'bbe3eaffe73d6263d2779f4913d5d7f19467fdf1419d86cd5e39f2f4aeda64325ead1f8cdd5f15e2',
        userReference: userDetails.id.toString(),
      );

      // debugPrint(userDetails.id.toString());
      // Get response data
      final response = await zeeh.initialize();
      if (response.message != null) {
        // debugPrint(response.message);
      } else {
        // debugPrint("No Response!");
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: 375.w,
          child: Column(
            children: [
              SizedBox(height: 50.h),
              TopRow(
                name: userDetails.firstName,
                activities: activities.length,
              ),

              SizedBox(height: 2.h),
              if (credit == 0)
                Container(
                  height: 90.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F9FD),
                  ),
                  padding: EdgeInsets.only(left: 16.w, right: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: DMSanText(
                          text:
                              "Connect your account(s) to view your credit score and get access to amazing offers",
                          maxLines: 2,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      InkWell(
                        onTap: () => {
                          if (userDetails.bvnAttached == false)
                            navigate(context, const VerifyIdentityScreen())
                          else if (userDetails.bvnAttached == true &&
                              userDetails.bvnVerified == false)
                            {
                              navigate(
                                context,
                                FaceCaptureInfoScreen(
                                  bvn: userDetails.bvn.toString(),
                                ),
                              )
                            }
                          else if (userDetails.bvnVerified == true)
                            {
                              //handleInitialization(),
                              navigate(context, Connectv2()),
                              AppSnackbar(context).showToast(
                                text: "Connect Account ...",
                              ),
                            }
                        },
                        child: DMSanText(
                          text: "Tap to link your account(s)",
                          underlineText: true,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          textColor: const Color(0xFF6936F5),
                        ),
                      )
                    ],
                  ),
                ),

              // Credit Score
              Container(
                height: 262.h,
                width: 375.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 24.h,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    // if (credit != 0)
                    Row(
                      children: [
                        // Credit Score
                        CreditScoreWidget(
                          score: "$credit",
                        ),
                        const ScoreDivider(),
                        SizedBox(width: 15.w),
                        // Net Worth
                        const NetworthWidget(),
                        SizedBox(width: 30.w),

                        const ScoreDivider(),
                        SizedBox(width: 15.w),
                        const DebtWidget(),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    // Credit Score
                    SizedBox(
                      width: 200.w,
                      height: 150.h,
                      child: Stack(
                        children: [
                          Positioned(
                            child: _getRadialGauge(),
                          ),
                          Positioned(
                            bottom: 20.h,
                            left: 55.w,
                            child: DMSanText(
                              text: "Powered by Zeeh",
                              textColor: const Color(0xFF5F6D7E),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),

              //SizedBox(height: 2.h),

              // Apply For, Articles For You and Personalized Tips

              // Container(
              //   width: 375.w,
              //   decoration: const BoxDecoration(
              //     color: Colors.white,
              //   ),
              //   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           const DMSanText(
              //             text: "Apply for",
              //             fontWeight: FontWeight.w500,
              //           ),
              //           const Spacer(),
              //           InkWell(
              //             onTap: () => navigate(context, LoanOffersPage()),
              //             child: Row(
              //               children: [
              //                 DMSanText(
              //                   text: "View all",
              //                   textColor: const Color(0xFF6936F5),
              //                   fontSize: 12.sp,
              //                   fontWeight: FontWeight.w600,
              //                 ),
              //                 const Icon(
              //                   Icons.chevron_right_outlined,
              //                   color: Color(0xFF6936F5),
              //                 )
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),

              //       SizedBox(height: 10.h),

              //       // Scroll View of Loans
              //       SingleChildScrollView(
              //         scrollDirection: Axis.horizontal,
              //         child: Row(
              //           children: [
              //             const LoanOfferWidget(),
              //             SizedBox(width: 10.w),
              //             const LoanOfferWidget(),
              //             SizedBox(width: 10.w),
              //             const LoanOfferWidget(),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),

              Container(
                width: 375.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        const DMSanText(
                          text: "Articles for you",
                          fontWeight: FontWeight.w500,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => navigate(
                            context,
                            const BuildCreditScreen(),
                          ),
                          child: SizedBox(
                            child: Row(
                              children: [
                                DMSanText(
                                  text: "View all",
                                  textColor: const Color(0xFF6936F5),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                const Icon(
                                  Icons.chevron_right_outlined,
                                  color: Color(0xFF6936F5),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // Scroll View of Loans
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ArticleWidget(
                            onTap: () => navigate(
                              context,
                              const ArticleScreen(
                                selectedArticle: 1,
                              ),
                            ),
                            title: "Financial Literacy",
                            assetPath: ZeehAssets.creditImage1,
                          ),
                          SizedBox(width: 10.w),
                          ArticleWidget(
                            assetPath: ZeehAssets.creditImage2,
                            title: "FICO Explained Simply",
                            onTap: () => navigate(
                              context,
                              const ArticleScreen(
                                selectedArticle: 2,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          ArticleWidget(
                            assetPath: ZeehAssets.creditImage3,
                            title: "Benefits of a Good Credit Score",
                            onTap: () => navigate(
                              context,
                              const ArticleScreen(
                                selectedArticle: 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 15.h),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DMSanText(
                          text: "Personalized tips",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          width: 327,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6936F5),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.r),
                              topRight: Radius.circular(8.r),
                            ),
                          ),
                        ),
                        Container(
                          width: 327,
                          height: 120,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFEBEBEB)),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8.r),
                                bottomLeft: Radius.circular(8.r),
                              ),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 1,
                                offset: Offset(0, 1),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 16,
                                top: 24,
                                child: SizedBox(
                                  width: 273.w,
                                  height: 72.h,
                                  child: Stack(
                                    children: [
                                      const Positioned(
                                        left: 0,
                                        top: 0,
                                        child: DMSanText(
                                          text:
                                              'Pay off outstanding loans to improve your \ncredit score and also get more juicy deals.',
                                          textColor: Color(0xFF242424),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 54.h,
                                        child: DMSanText(
                                          text: 'Link more accounts',
                                          textColor: const Color(0xFF242424),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          underlineText: true,
                                        ),
                                      ),
                                      Positioned(
                                        left: 140.w,
                                        top: 55.h,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          size: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    // Bottom Overflow
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRadialGauge() {
    return SizedBox(
      width: 200.w,
      height: 150.h,
      child: Stack(
        children: [
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                startAngle: 180,
                endAngle: 0,
                minimum: 300,
                maximum: 850,
                radiusFactor: 1,
                showAxisLine: false,
                showLabels: false,
                annotations: [
                  GaugeAnnotation(
                    positionFactor: 0.9,
                    angle: 170,
                    widget: GroteskText(
                      text: "300",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GaugeAnnotation(
                    positionFactor: 0.9,
                    angle: 10,
                    widget: GroteskText(
                      text: "850",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GaugeAnnotation(
                    positionFactor: 0.25,
                    angle: 90,
                    widget: GroteskText(
                      text: "Score",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                ranges: <GaugeRange>[
                  GaugeRange(
                    startValue: 300,
                    endValue: 450.0,
                    color: Colors.red,
                    startWidth: 8,
                    endWidth: 8,
                  ),
                  GaugeRange(
                    startValue: 450,
                    endValue: 580,
                    color: Colors.orange,
                    startWidth: 8,
                    endWidth: 8,
                  ),
                  GaugeRange(
                    startValue: 580,
                    endValue: 715.0,
                    color: Colors.yellow,
                    startWidth: 8,
                    endWidth: 8,
                  ),
                  GaugeRange(
                    startValue: 715,
                    endValue: 850,
                    color: Colors.green,
                    startWidth: 8,
                    endWidth: 8,
                  ),
                ],
                pointers: <GaugePointer>[
                  MarkerPointer(
                    value: double.parse(credit.toString()),
                    markerType: MarkerType.triangle,
                    enableDragging: true,
                    markerWidth: 7,
                    markerHeight: 10,
                    markerOffset: 15,
                    color: const Color(0xff5F6D7E),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 65.w,
            right: 65.w,
            top: 30.h,
            child: SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                children: [
                  Image.asset(ZeehAssets.ellipse1),
                  Positioned(
                    left: 30.w,
                    right: 30.w,
                    top: 20.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GroteskText(
                          text: "$credit",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        GroteskText(
                          text: "-",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopRow extends StatelessWidget {

  String getInitials(String fullName) {
  List<String> nameParts = fullName.split(" ");
  String initials = "";

  if (nameParts.isNotEmpty) {
    initials += nameParts[0][0]; // First name initial

    if (nameParts.length > 1) {
      initials += nameParts.last[0]; // Last name initial
    }
  }

  return initials.toUpperCase();
}
  const TopRow({
    super.key,
    this.name,
    this.activities,
  });

  final String? name;
  final int? activities;

  @override
  Widget build(BuildContext context) {
    String initials = getInitials(name!);
    return Container(
      height: 90.h,
      padding: EdgeInsets.only(
        top: 30.h,
        left: 24.w,
        right: 24.w,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
//               DMSanText(
//   text: "Hello, $initials!",
//   fontSize: 16.sp,
//   fontWeight: FontWeight.w500,
// ),
              DMSanText(
                text: "Hello, ${name ?? ""}!",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              DMSanText(
                text: "",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),

          // Notifications Icon
          InkWell(
            onTap: () => navigate(context, const ActivityScreen()),
            child: SizedBox(
              height: 34.h,
              width: 34.h,
              child: Stack(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      ZeehAssets.notificationsIcon,
                    ),
                  ),
                  // Positioned(
                  //   right: 0,
                  //   child: Container(
                  //     height: 18.h,
                  //     width: 18.w,
                  //     decoration: const BoxDecoration(
                  //       color: Color(0xffD12564),
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: Center(
                  //         child: DMSanText(
                  //       text: "$activities",
                  //       textColor: Colors.white,
                  //       fontSize: 12.sp,
                  //       fontWeight: FontWeight.w600,
                  //     )),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopRow2 extends StatelessWidget {

  String getInitials(String fullName) {
  List<String> nameParts = fullName.split(" ");
  String initials = "";

  if (nameParts.isNotEmpty) {
    initials += nameParts[0][0]; // First name initial

    if (nameParts.length > 1) {
      initials += nameParts.last[0]; // Last name initial
    }
  }

  return initials.toUpperCase();
}
  const TopRow2({
    super.key,
    this.name,
    this.activities, 
  });

  final String? name;
  final int? activities;

  @override
  Widget build(BuildContext context) {
    String initials = getInitials(name!);
    return Container(
      height: 90.h,
      padding: EdgeInsets.only(
        top: 35.h,
        left: 24.w,
        right: 24.w,
      ),
     // color: Colors.white,
     color: Color(0xFFFCFCFC),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  CircleAvatar(
                    child: DMSanText(text: initials,
                     fontSize: 14.sp,
                    fontWeight: FontWeight.w500,),
                    backgroundColor: Color(0xFFF8F9FD),
                  ),
                  SizedBox(width: 5.w,),
                  DMSanText(
                    text: "Hello, ${name ?? ""}!",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),

              // DMSanText(
              //   text: "",
              //   fontSize: 12.sp,
              //   fontWeight: FontWeight.w400,
              // ),
            ],
          ),

          // Notifications Icon
          InkWell(
            onTap: () => navigate(context, const ActivityScreen()),
            child: SizedBox(
              height: 34.h,
              width: 34.h,
              child: Stack(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      ZeehAssets.notificationsIcon,
                    ),
                  ),
                  // Positioned(
                  //   right: 0, 
                  //   child: Container(
                  //     height: 18.h,
                  //     width: 18.w,
                  //     decoration: const BoxDecoration(
                  //       color: Color(0xffD12564),
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: Center(
                  //         child: DMSanText(
                  //       text: "$activities",
                  //       textColor: Colors.white,
                  //       fontSize: 12.sp,
                  //       fontWeight: FontWeight.w600,
                  //     )),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeFeatureWidget extends StatelessWidget {
  const HomeFeatureWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageAsset,
    this.onTap,
  });

  final String title;
  final String description;
  final String imageAsset;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 95.h,
        child: Padding(
          padding: EdgeInsets.only(top: 4.0.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                imageAsset,
                height: 40.h,
                width: 40.w,
              ),
              SizedBox(width: 16.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GroteskText(
                    text: title,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 4.h),
                  SizedBox(
                    width: 206.w,
                    child: GroteskText(
                      text: description,
                      fontSize: 10.sp,
                      maxLines: 4,
                      fontWeight: FontWeight.w400,
                      textColor: ZeehColors.grayColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              
              const Icon(
                Icons.chevron_right_rounded,
                color: ZeehColors.grayColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: 2,
      effect: ExpandingDotsEffect(
        activeDotColor: Colors.black,
        dotColor: ZeehColors.grayColor,
        dotHeight: 4.h,
        dotWidth: 8.h,
      ),
    );
  }
}

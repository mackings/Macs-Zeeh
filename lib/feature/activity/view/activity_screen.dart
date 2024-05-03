import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/currency_function.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/activity/data/state/activity_state_notifier.dart';
import 'package:zeeh_mobile/feature/activity/model/activity_model.dart';
import 'package:zeeh_mobile/feature/credit/view/widgets/header_widget.dart';
import 'package:zeeh_mobile/feature/provider.dart';

class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({super.key});

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {},
    );
  }

  List<ActivityModel> listOfActivities = [];

  @override
  Widget build(BuildContext context) {
    final activitiesState = ref.watch(activitiesStateNotifierProvider);

    if (activitiesState is ActivitiesSuccess) {
      listOfActivities = activitiesState.listOfActivities;
    }

    return Scaffold(
      body: SizedBox(
        width: 375.w,
        height: 812.h,
        child: Column(
          children: [
            const MenuHeaderWidget(
              showBackButton: true,
              title: "Activities",
            ),

            // Recent Activities

            SizedBox(height: 3.h),

            Expanded(
              child: Container(
                width: 375.w,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),

                      if (activitiesState is ActivitiesLoading)
                        Column(
                          children: [
                            SizedBox(height: 200.h),
                            LoadingIndicatorWidget(
                              height: 40.h,
                              width: 40.w,
                            ),
                          ],
                        ),

                      // This is the change you made @Ini
                      // So you can just swap this for the
                      // List of activities column
                      if (activitiesState is ActivitiesFailure)
                        Column(
                          children: [
                            SizedBox(height: 200.h),
                            Image.asset(
                              ZeehAssets.emptyBox,
                              height: 100.h,
                              width: 100.w,
                            ),
                            SizedBox(height: 10.h),
                            const DMSanText(
                              text: "No Activities available",
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      DMSanText(
                        text: "New",
                        fontSize: 14.sp,
                        textColor: const Color(0xFF5F6D7E),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Divider(
                        thickness: 1.h,
                      ),

                      //  List of Activities
                      if (activitiesState is ActivitiesSuccess)
                        if (listOfActivities.isEmpty)
                          Column(
                            children: [
                              DMSanText(
                                text: "New",
                                fontSize: 14.sp,
                                textColor: const Color(0xFF5F6D7E),
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                thickness: 1.h,
                              ),
                              Image.asset(
                                ZeehAssets.emptyBox,
                                height: 100.h,
                                width: 100.w,
                              ),
                              SizedBox(height: 10.h),
                              const GroteskText(
                                text: "No Activities available",
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 100.h),
                            ],
                          )
                        else if (listOfActivities.isNotEmpty)
                          ...List.generate(
                            listOfActivities.length,
                            (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ActivitiesWidget(
                                  imageAsset: ZeehAssets.roundedZeehLogo,
                                  textLeft1: listOfActivities[index]
                                              .message!
                                              .length >
                                          35
                                      ? "${listOfActivities[index].message!.substring(0, 35)}..."
                                      : listOfActivities[index].message!,
                                  textLeft2: listOfActivities[index]
                                      .createdAt
                                      .toString(),
                                  textRight1: listOfActivities[index].amount ==
                                          0
                                      ? ""
                                      : "₦${amountFormatter(listOfActivities[index].amount!.toDouble())}",
                                  amountColor: const Color(0xff209F15),
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Color(0xffD7D7D7),
                                ),
                              ],
                            ),
                          )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ActivitiesWidget extends StatelessWidget {
  const ActivitiesWidget({
    super.key,
    required this.imageAsset,
    required this.textLeft1,
    required this.textLeft2,
    this.textRight1,
    this.amountColor,
  });

  final String imageAsset;
  final String textLeft1;
  final String textLeft2;
  final String? textRight1;
  final Color? amountColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox.square(
                    dimension: 40.w,
                    child: Image.asset(
                      imageAsset,
                      scale: 0.75,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: SizedBox(
                      width: 250.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 250.w,
                            ),
                            child: DMSanText(
                              text: textLeft1,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              DMSanText(
                                text: textLeft2,
                                fontSize: 12.sp,
                                textColor: ZeehColors.grayColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          textRight1 != null
              ? Positioned(
                  bottom: -3,
                  right: 0,
                  child: SpaceGroteskText(
                    text: textRight1!,
                    textColor: amountColor ?? const Color(0xffEA1456),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

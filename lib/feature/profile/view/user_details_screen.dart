import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';
import 'package:zeeh_mobile/feature/profile/data/state/profile_state_notifier.dart';
import 'package:zeeh_mobile/feature/profile/model/user_details.dart';
import 'package:zeeh_mobile/feature/provider.dart';

class UserDetailsScreen extends ConsumerStatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  ConsumerState<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  UserDetails userDetails = UserDetails();

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(profileStateNotifierProvider);

    if (userState is UserDetailsSuccess) {
      userDetails = userState.userDetails;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: 375.w,
          child: Column(
            children: [
              // Header Widget
              const HomeHeaderWidgetTwo(title: "Personal"),

              SizedBox(height: 3.h),

              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 24.h),

                    // User Image and User Details

                    SizedBox(
                      height: 70.h,
                      width: 70.w,
                      child: userDetails.imageUrl != ""
                          ? FittedBox(
                              fit: BoxFit.fill,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userDetails.imageUrl.toString(),
                                ),
                              ),
                            )
                          : SvgPicture.asset(
                              ZeehAssets.profileIcon,
                              height: 70.h,
                              width: 70.w,
                            ),
                    ),

                    SizedBox(
                      height: 24.h,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: Column(
                        children: [
                          // List of User Details Key and Value
                          const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                          ProfileDetailDataWidget(
                            dataKey: "Full Name",
                            dataValue:
                                "${userDetails.firstName} ${userDetails.lastName}",
                          ),
                          ProfileDetailDataWidget(
                            dataKey: "Date of Birth",
                            dataValue: "${userDetails.dob}",
                          ),
                          ProfileDetailDataWidget(
                            dataKey: "Address",
                            dataValue: userDetails.address != ""
                                ? userDetails.address.toString().length < 20
                                    ? ""
                                    : userDetails.address
                                        .toString()
                                        .substring(0, 20)
                                : "",
                          ),
                          ProfileDetailDataWidget(
                            dataKey: "State",
                            dataValue: "${userDetails.state}",
                          ),
                          ProfileDetailDataWidget(
                            dataKey: "Email Address",
                            dataValue: userDetails.email != "" &&
                                    userDetails.email!.length > 25
                                ? "${userDetails.email.toString().substring(0, 20)}..."
                                : userDetails.email == ""
                                    ? ""
                                    : userDetails.email,
                          ),
                          ProfileDetailDataWidget(
                            dataKey: "Phone",
                            dataValue: "${userDetails.phoneNumber}",
                          ),
                          ProfileDetailDataWidget(
                            dataKey: "Gender",
                            dataValue: userDetails.gender ?? "",
                          ),
                          ProfileDetailDataWidget(
                            dataKey: "Country",
                            dataValue: "${userDetails.country}",
                          ),
                          SizedBox(height: 200.h),
                        ],
                      ),
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
}

class ProfileDetailDataWidget extends StatelessWidget {
  const ProfileDetailDataWidget({
    super.key,
    required this.dataKey,
    this.dataValue,
  });

  final String dataKey;
  final String? dataValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0.h),
          child: Row(
            children: [
              DMSanText(
                text: dataKey,
                fontSize: 14.sp,
              ),
              const Spacer(),
              DMSanText(
                text: dataValue ?? "",
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ],
          ),
        ),
        const Divider(thickness: 1, color: Color(0xffD7D7D7)),
      ],
    );
  }
}

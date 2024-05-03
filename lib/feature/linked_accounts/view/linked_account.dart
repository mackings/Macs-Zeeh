import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeeh/zeeh.dart';
import 'package:zeeh_mobile/common/components/app_snackbar.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/currency_function.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/face_recognition/face_capture_info_screen.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/verify_identity.dart';
import 'package:zeeh_mobile/feature/connect_account/data/Linkonweb.dart';
import 'package:zeeh_mobile/feature/credit/view/widgets/header_widget.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/score_widget.dart';
import 'package:zeeh_mobile/feature/linked_accounts/data/state/linked_account_state_notifier.dart';
import 'package:zeeh_mobile/feature/linked_accounts/model/linked_account_model.dart';
import 'package:zeeh_mobile/feature/linked_accounts/view/widget/linked_account_bank_widget.dart';
import 'package:zeeh_mobile/feature/profile/model/user_details.dart';
import 'package:zeeh_mobile/feature/provider.dart';

import '../../profile/data/state/profile_state_notifier.dart';

class LinkedAccount extends ConsumerStatefulWidget {
  const LinkedAccount({this.showBackButton = false, super.key});

  final bool showBackButton;

  @override
  ConsumerState<LinkedAccount> createState() => _LinkedAccountState();
}

class _LinkedAccountState extends ConsumerState<LinkedAccount> {
  int tabToggleValue = 1;

  UserDetails userDetails = UserDetails();

  LinkedAccountModel linkedAccount = LinkedAccountModel();

  double networth = 0;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ref.read(linkedAccountStateNotifierProvider.notifier).allBanks();
    // });
  }

  // Handle Zeeh package initialization here.
  handleInitialization(String userId) async {
    final zeeh = Zeeh.start(
      context: context,
      publicKey: 'pk_v7rBtZlIijh4kn5fWA3F5jPzq',
      orgId:
          'bbe3eaffe73d6263d2779f4913d5d7f19467fdf1419d86cd5e39f2f4aeda64325ead1f8cdd5f15e2',
      userReference: userId,
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

  @override
  Widget build(BuildContext context) {
    final bankState = ref.watch(linkedAccountStateNotifierProvider);

    if (bankState is AllBankSuccess) {
      linkedAccount = bankState.linkedAccount;

      if (linkedAccount.numberOfBanks! > 0) {
        networth = linkedAccount.banks![0].balance ?? 0;
      } else {
        networth = 0;
      }
    }

    final userDetailsState = ref.watch(profileStateNotifierProvider);

    if (userDetailsState is UserDetailsSuccess) {
      userDetails = userDetailsState.userDetails;
    }

    // Refreshers
    void onRefresh() async {
      setState(() {
        networth = 0;
      });

      ref.read(linkedAccountStateNotifierProvider.notifier).allBanks();

      // if failed,use refreshFailed()
      refreshController.refreshCompleted();
    }

    void onLoading() async {
      if (mounted) setState(() {});
      refreshController.loadComplete();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        enablePullUp: true,
        header: const ClassicHeader(
          releaseText: '',
          completeText: '',
          releaseIcon: CircularProgressIndicator(
            color: ZeehColors.buttonPurple,
          ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            width: 375.w,
            child: Column(
              children: [
                MenuHeaderWidget(
                  title: "Connect",
                  showBackButton: widget.showBackButton,
                ),

                const Divider(
                  thickness: 1,
                  color: ZeehColors.greyColor,
                ),

                SizedBox(height: 20.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Credit Score
                      NetworthWidget(
                        networth: "${amountFormatter(networth)}",
                      ),

                      SizedBox(width: 30.w),

                      const ScoreDivider(),

                      SizedBox(width: 15.w),

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
                              handleInitialization(userDetails.id.toString()),
                              AppSnackbar(context).showToast(
                                text: "Connect Account Widget...",
                              ),
                            }
                        },
                        child: DebtWidget(
                          label: "Connected account",
                          showNumber: true,
                          number: "${linkedAccount.numberOfBanks} ",
                          debt: " - link more account(s)",
                          debtColor: const Color(0xFF6936F5),
                        ),
                      ),

                      SizedBox(width: 15.w),
                    ],
                  ),
                ),

                // Net Worth and Number of Accounts

                if (bankState is AllBankLoading)
                  Column(
                    children: [
                      SizedBox(
                        height: 300.h,
                      ),
                      LoadingIndicatorWidget(
                        height: 40.h,
                        width: 40.w,
                      ),
                    ],
                  ),

                if (bankState is AllBankSuccess)
                  if (linkedAccount.numberOfBanks! == 0)
                    Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          height: 154.h,
                          width: double.infinity,
                          child: Center(
                            child: SizedBox(
                              width: 308.w,
                              child: DMSanText(
                                text:
                                    "No financial records yet. We advice you to connect your account for a better experience",
                                textAlign: TextAlign.center,
                                fontSize: 16.sp,
                                maxLines: 4,
                                fontWeight: FontWeight.w400,
                                textColor: const Color(0xff242739),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 3.h),

                        // Banks and Service
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 24.h),
                              Container(
                                height: 54.h,
                                padding:
                                    EdgeInsets.symmetric(horizontal: 8.0.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: ZeehColors.greyColor,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Banks
                                    ZeehButton(
                                      onClick: () {
                                        toggleTabs("banks");
                                      },
                                      text: "Banks",
                                      textColor: tabToggleValue == 2
                                          ? ZeehColors.grayColor
                                          : Colors.white,
                                      height: 38.h,
                                      width: 145.w,
                                      radius: 2.r,
                                      buttonColor: tabToggleValue == 1
                                          ? ZeehColors.blackColor
                                          : Colors.white,
                                    ),
                                    ZeehButton(
                                      onClick: () {
                                        toggleTabs("fintech");
                                      },
                                      text: "Fintech",
                                      textColor: tabToggleValue == 1
                                          ? ZeehColors.grayColor
                                          : Colors.white,
                                      height: 38.h,
                                      width: 145.w,
                                      radius: 2.r,
                                      buttonColor: tabToggleValue == 2
                                          ? ZeehColors.blackColor
                                          : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 10.w,
                                ),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ZeehColors.greyColor),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Column(
                                  children: [
                                    // List of Items
                                    if (tabToggleValue == 1)
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: const DMSanText(
                                              text: "Link an account?",
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () => {
                                              if (userDetails.bvnAttached ==
                                                  false)
                                                navigate(context,
                                                    const VerifyIdentityScreen())
                                              else if (userDetails
                                                          .bvnAttached ==
                                                      true &&
                                                  userDetails.bvnVerified ==
                                                      false)
                                                {
                                                  navigate(
                                                    context,
                                                    FaceCaptureInfoScreen(
                                                      bvn: userDetails.bvn
                                                          .toString(),
                                                    ),
                                                  )
                                                }
                                              else if (userDetails
                                                      .bvnVerified ==
                                                  true)
                                                {
                                                  // handleInitialization(
                                                  //     userDetails.id
                                                  //         .toString()),
                                                  navigate(context, Connectv2()),

                                                  AppSnackbar(context)
                                                      .showToast(
                                                    text:
                                                        "Connect Account Widget...",
                                                  ),
                                                }
                                            },
                                            child: Container(
                                              height: 31.h,
                                              width: 90.w,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffD7D7D7),
                                                ),
                                              ),
                                              child: Center(
                                                child: DMSanText(
                                                  text: "Start",
                                                  fontSize: 12.sp,
                                                  textColor:
                                                      ZeehColors.buttonPurple,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (tabToggleValue == 2)
                                      Row(
                                        children: [
                                          const DMSanText(
                                              text: "Link an account?"),
                                          const Spacer(),
                                          Container(
                                            height: 31.h,
                                            width: 90.w,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(0xffD7D7D7),
                                              ),
                                            ),
                                            child: Center(
                                              child: GroteskText(
                                                text: "Start",
                                                fontSize: 12.sp,
                                                textColor:
                                                    ZeehColors.buttonPurple,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 50.h),
                            ],
                          ),
                        ),
                      ],
                    )
                  else if (linkedAccount.numberOfBanks! > 0)
                    Column(children: [
                      // Container(
                      //   color: Colors.white,
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: 24.0.w, vertical: 16.h),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         WorthWidget(
                      //           title: "NET WORTH",
                      //           description: "Last added in May",
                      //           amount: "₦${amountFormatter(networth)}",
                      //           descriptionColor: ZeehColors.grayColor,
                      //         ),
                      //         WorthWidget(
                      //           title: "LINKED ACCOUNTS",
                      //           description: "Link account",
                      //           amount: "${linkedAccount.numberOfBanks}",
                      //           onDesTap: () {
                      //             if (userDetails.bvnAttached == false) {
                      //               navigate(
                      //                   context, const VerifyIdentityScreen());
                      //             } else {
                      //               if (userDetails.bvnAttached == true &&
                      //                   userDetails.bvnVerified == false) {
                      //                 navigate(
                      //                   context,
                      //                   FaceCaptureInfoScreen(
                      //                     bvn: userDetails.bvn.toString(),
                      //                   ),
                      //                 );
                      //               } else if (userDetails.bvnVerified ==
                      //                   true) {
                      //                 handleInitialization(
                      //                     userDetails.id.toString());
                      //               }
                      //             }
                      //           },
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 30.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 16.h),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: ZeehColors.greyColor),
                          ),
                          child: Column(
                            children: [
                              AccountDataSet(
                                dataKey: "Cash in Bank",
                                value: linkedAccount.banks!.isEmpty
                                    ? '0'
                                    : "₦${amountFormatter(networth)}",
                                valueColor: const Color(0xff209F15),
                              ),
                              const AccountDataSet(
                                dataKey: "What you owe",
                                value: "₦0",
                                valueColor: Color(0xffEA1456),
                              ),
                              const AccountDataSet(
                                dataKey: "Total Investment",
                                value: "₦0",
                              ),
                              const AccountDataSet(
                                dataKey: "Investment Returns",
                                value: "₦0",
                              ),
                              const AccountDataSet(
                                dataKey: "Savings",
                                value: "₦0",
                                showBottomDivider: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 24.h),
                            Container(
                              height: 54.h,
                              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: ZeehColors.greyColor,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Banks
                                  ZeehButton(
                                    onClick: () {
                                      toggleTabs("banks");
                                    },
                                    text: "Banks",
                                    textColor: tabToggleValue == 2
                                        ? ZeehColors.grayColor
                                        : Colors.white,
                                    height: 38.h,
                                    width: 145.w,
                                    radius: 2.r,
                                    buttonColor: tabToggleValue == 1
                                        ? ZeehColors.blackColor
                                        : Colors.white,
                                  ),
                                  ZeehButton(
                                    onClick: () {
                                      toggleTabs("fintech");
                                    },
                                    text: "Fintech",
                                    textColor: tabToggleValue == 1
                                        ? ZeehColors.grayColor
                                        : Colors.white,
                                    height: 38.h,
                                    width: 145.w,
                                    radius: 2.r,
                                    buttonColor: tabToggleValue == 2
                                        ? ZeehColors.blackColor
                                        : Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 10.w,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: ZeehColors.greyColor),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                children: [
                                  // List of Items
                                  if (tabToggleValue == 1)
                                    ...List.generate(
                                      linkedAccount.banks!.length,
                                      (index) => SizedBox(
                                        child: InkWell(
                                          onTap: () => {},
                                          child: Column(
                                            children: [
                                              SizedBox(height: 5.w),
                                              LinkedAccountBankWidget(
                                                index: index,
                                                linkedAccount: linkedAccount,
                                              ),
                                              SizedBox(height: 5.w),
                                              const Divider(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (tabToggleValue == 2)
                                    ...List.generate(
                                      0,
                                      (index) => SizedBox(
                                        child: InkWell(
                                          onTap: () => {},
                                          child: Column(
                                            children: [
                                              SizedBox(height: 5.w),
                                              LinkedAccountBankWidget(
                                                index: index,
                                                linkedAccount: linkedAccount,
                                              ),
                                              SizedBox(height: 5.w),
                                              const Divider(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 20.h),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ]),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Toggle Tabs
  void toggleTabs(item) {
    if (item == "banks") {
      setState(() {
        tabToggleValue = 1;
      });
    } else if (item == "fintech") {
      setState(() {
        tabToggleValue = 2;
      });
    }
  }
}

class AccountDataSet extends StatelessWidget {
  const AccountDataSet({
    super.key,
    this.dataKey,
    this.value,
    this.showBottomDivider = true,
    this.valueColor,
  });

  final String? dataKey;
  final String? value;
  final bool? showBottomDivider;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DMSanText(
              text: dataKey ?? "",
              textColor: ZeehColors.grayColor,
              fontSize: 14.sp,
            ),
            SpaceGroteskText(
              text: value ?? "",
              textColor: valueColor ?? ZeehColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ],
        ),
        SizedBox(height: 5.h),
        if (showBottomDivider == true)
          const Divider(
            color: ZeehColors.grayColor,
          ),
      ],
    );
  }
}

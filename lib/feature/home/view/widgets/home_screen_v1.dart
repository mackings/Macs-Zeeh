 // Scaffold(
    //   body: SmartRefresher(
    //     controller: refreshController,
    //     onRefresh: onRefresh,
    //     onLoading: onLoading,
    //     enablePullUp: true,
    //     header: const ClassicHeader(
    //       releaseText: '',
    //       completeText: '',
    //       releaseIcon: CircularProgressIndicator(
    //         color: ZeehColors.buttonPurple,
    //       ),
    //     ),
    //     child: SingleChildScrollView(
    //       child: SizedBox(
    //         width: 375.w,
    //         child: Column(
    //           children: [
    //             HomeHeaderWidget(
    //               userImage: userDetails.imageUrl ?? "",
    //               userName: userDetails.firstName ?? "",
    //             ),

    //             SizedBox(height: 16.h),

    //             Stack(
    //               children: [
    //                 // Credit Score / Check credit history

    //                 if (creditState is GetCreditScoreLoading)
    //                   SizedBox(
    //                     width: 343.w,
    //                     height: 180.h,
    //                     child: Center(
    //                       child: LoadingIndicatorWidget(
    //                         height: 20.h,
    //                         width: 20.w,
    //                       ),
    //                     ),
    //                   ),

    //                 if (creditState is GetCreditScoreSuccess)
    //                   Container(
    //                     padding: EdgeInsets.symmetric(vertical: 16.h),
    //                     decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       border: Border.all(
    //                         color: ZeehColors.greyColor,
    //                       ),
    //                       borderRadius: BorderRadius.circular(8.r),
    //                     ),
    //                     width: 343.w,
    //                     child: Column(
    //                       children: [
    //                         const GroteskText(
    //                           text: 'Credit Score',
    //                           fontWeight: FontWeight.w500,
    //                         ),
    //                         SizedBox(height: 20.h),
    //                         SizedBox(
    //                           width: 200.w,
    //                           height: 180.h,
    //                           child: Stack(
    //                             children: [
    //                               Positioned(
    //                                 child: _getRadialGauge(),
    //                               ),
    //                               Positioned(
    //                                 bottom: 10.h,
    //                                 left: 20.w,
    //                                 child: Column(
    //                                   children: [
    //                                     // GroteskText(
    //                                     //   text:
    //                                     //       "Last updated: ${creditState.responseModel.data["updated",
    //                                     //   fontSize: 10.sp,
    //                                     //   fontWeight: FontWeight.w500,
    //                                     // ),
    //                                     Row(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.center,
    //                                       children: [
    //                                         InkWell(
    //                                           onTap: () => navigate(
    //                                             context,
    //                                             const ScoreHistory(),
    //                                           ),
    //                                           child: GroteskText(
    //                                             text: 'Check credit History',
    //                                             fontWeight: FontWeight.w500,
    //                                             fontSize: 14.sp,
    //                                             textColor:
    //                                                 ZeehColors.buttonPurple,
    //                                           ),
    //                                         ),
    //                                         Padding(
    //                                           padding:
    //                                               EdgeInsets.only(left: 2.w),
    //                                           child: Icon(
    //                                             Icons.arrow_right_alt_outlined,
    //                                             color: ZeehColors.buttonPurple,
    //                                             size: 26.h,
    //                                           ),
    //                                         )
    //                                       ],
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),

    //                 // Credit Score / Connect my bank

    //                 if (creditState is GetCreditScoreFailure || credit == 0)
    //                   Container(
    //                     padding: EdgeInsets.symmetric(
    //                       vertical: 16.h,
    //                       horizontal: 18.w,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       border: Border.all(
    //                         color: ZeehColors.greyColor,
    //                       ),
    //                       borderRadius: BorderRadius.circular(8.r),
    //                     ),
    //                     width: 343.w,
    //                     height: 255.h,
    //                     child: Column(
    //                       children: [
    //                         const GroteskText(
    //                           text: 'Credit Score',
    //                           fontWeight: FontWeight.w500,
    //                         ),
    //                         SizedBox(height: 65.h),
    //                         Column(
    //                           children: [
    //                             GroteskText(
    //                               text: "You have no credit score yet. "
    //                                   "Try connecting your bank account "
    //                                   "to fetch your credit report "
    //                                   "for a personalized experience",
    //                               fontSize: 10.sp,
    //                               maxLines: 3,
    //                               textAlign: TextAlign.center,
    //                               fontWeight: FontWeight.w500,
    //                             ),
    //                             Padding(
    //                               padding: const EdgeInsets.only(top: 8.0),
    //                               child: InkWell(
    //                                 onTap: () {
    //                                   if (userDetails.bvnAttached == false) {
    //                                     navigate(context,
    //                                         const VerifyIdentityScreen());
    //                                   } else if (userDetails.bvnAttached ==
    //                                           true &&
    //                                       userDetails.bvnVerified == false) {
    //                                     navigate(
    //                                       context,
    //                                       FaceCaptureInfoScreen(
    //                                         bvn: userDetails.bvn.toString(),
    //                                       ),
    //                                     );
    //                                   } else if (userDetails.bvnVerified ==
    //                                       true) {
    //                                     AppSnackbar(context).showToast(
    //                                         text: "Connect Account Widget...");

    //                                     handleInitialization();
    //                                   }
    //                                 },
    //                                 child: Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     GroteskText(
    //                                       text: 'Connect my bank',
    //                                       fontWeight: FontWeight.w500,
    //                                       fontSize: 14.sp,
    //                                       textColor: ZeehColors.buttonPurple,
    //                                     ),
    //                                     Padding(
    //                                       padding: EdgeInsets.only(left: 2.w),
    //                                       child: Icon(
    //                                         Icons.arrow_right_alt_outlined,
    //                                         color: ZeehColors.buttonPurple,
    //                                         size: 26.h,
    //                                       ),
    //                                     )
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),

    //                 // // Borrowing power / Connect my bank
    //                 // Container(
    //                 //   padding: EdgeInsets.symmetric(
    //                 //     vertical: 16.h,
    //                 //     horizontal: 18.w,
    //                 //   ),
    //                 //   decoration: BoxDecoration(
    //                 //     color: Colors.white,
    //                 //     border: Border.all(
    //                 //       color: ZeehColors.greyColor,
    //                 //     ),
    //                 //     borderRadius: BorderRadius.circular(8.r),
    //                 //   ),
    //                 //   width: 343.w,
    //                 //   height: 255.h,
    //                 //   child: Column(
    //                 //     children: [
    //                 //       const GroteskText(
    //                 //         text: 'Borrowing power',
    //                 //         fontWeight: FontWeight.w500,
    //                 //       ),
    //                 //       SizedBox(height: 65.h),
    //                 //       Column(
    //                 //         children: [
    //                 //           GroteskText(
    //                 //             text: "We can’t fetch your financial data "
    //                 //                 "to determine your borrowing power. "
    //                 //                 "Try connecting your bank account "
    //                 //                 "for a personalized experience",
    //                 //             fontSize: 10.sp,
    //                 //             maxLines: 3,
    //                 //             textAlign: TextAlign.center,
    //                 //             fontWeight: FontWeight.w500,
    //                 //           ),
    //                 //           Padding(
    //                 //             padding: const EdgeInsets.only(top: 8.0),
    //                 //             child: Row(
    //                 //               mainAxisAlignment: MainAxisAlignment.center,
    //                 //               children: [
    //                 //                 GroteskText(
    //                 //                   text: 'Connect my bank',
    //                 //                   fontWeight: FontWeight.w500,
    //                 //                   fontSize: 14.sp,
    //                 //                   textColor: ZeehColors.buttonPurple,
    //                 //                 ),
    //                 //                 Padding(
    //                 //                   padding: EdgeInsets.only(left: 2.w),
    //                 //                   child: Icon(
    //                 //                     Icons.arrow_right_alt_outlined,
    //                 //                     color: ZeehColors.buttonPurple,
    //                 //                     size: 26.h,
    //                 //                   ),
    //                 //                 )
    //                 //               ],
    //                 //             ),
    //                 //           ),
    //                 //         ],
    //                 //       ),
    //                 //     ],
    //                 //   ),
    //                 // ),
    //               ],
    //             ),

    //             // IndicatorWidget(controller: controller),

    //             SizedBox(height: 24.h),

    //             // NOTE: Payback Loan
    //             // PaybackLoan(
    //             //   onTap: () => navigate(
    //             //     context,
    //             //     const PaybackLoanPage(),
    //             //   ),
    //             // ),

    //             // Connect Account, Build Credit Score and Get Service Offers
    //             Container(
    //               width: double.infinity,
    //               padding:
    //                   EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
    //               decoration: const BoxDecoration(
    //                 color: Colors.white,
    //               ),
    //               child: Column(
    //                 children: [
    //                   InkWell(
    //                     onTap: () => {
    //                       if (userDetails.bvnAttached == false)
    //                         navigate(context, const VerifyIdentityScreen())
    //                       else if (userDetails.bvnAttached == true &&
    //                           userDetails.bvnVerified == false)
    //                         {
    //                           navigate(
    //                             context,
    //                             FaceCaptureInfoScreen(
    //                               bvn: userDetails.bvn.toString(),
    //                             ),
    //                           )
    //                         }
    //                       else if (userDetails.bvnVerified == true)
    //                         {
    //                           handleInitialization(),
    //                         }
    //                     },
    //                     child: const HomeFeatureWidget(
    //                       title: "Connect your accounts",
    //                       description:
    //                           "Manage all connected bank accounts and financial services to improve your credit worthiness and net worth. Get access to interesting financial service offers.",
    //                       imageAsset: ZeehAssets.bankCardIcon,
    //                     ),
    //                   ),
    //                   const Divider(thickness: 1, color: Color(0xffD7D7D7)),
    //                   InkWell(
    //                     onTap: () => navigate(
    //                       context,
    //                       const BuildCreditScreen(),
    //                     ),
    //                     child: const HomeFeatureWidget(
    //                       title: "Build your credit score",
    //                       description:
    //                           "Creditworthiness is what determines your financial capability. See how we compare your credit and get tips on improving your financial affordability.",
    //                       imageAsset: ZeehAssets.layingBlocksIcon,
    //                     ),
    //                   ),
    //                   const Divider(thickness: 1, color: Color(0xffD7D7D7)),
    //                   InkWell(
    //                     onTap: () {
    //                       navigate(
    //                         context,
    //                         const OfferScreen(
    //                           showBackButton: true,
    //                         ),
    //                       );
    //                     },
    //                     child: const HomeFeatureWidget(
    //                       title: "Get service offers",
    //                       description:
    //                           "Based on your creditworthiness, we push interesting financial service offers that best fit your financial status..",
    //                       imageAsset: ZeehAssets.receiveDollarIcon,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),

    //             SizedBox(height: 17.h),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
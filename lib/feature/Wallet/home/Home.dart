import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeeh_mobile/common/components/finnacle_loading_widget.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/Wallet/Credit/individual.dart';
import 'package:zeeh_mobile/feature/Wallet/Transactions/Sendtransaction.dart';
import 'package:zeeh_mobile/feature/Wallet/Transactions/fundwallet.dart';
import 'package:zeeh_mobile/feature/Wallet/model/wallet.dart';
import 'package:zeeh_mobile/feature/activity/data/state/activity_state_notifier.dart';
import 'package:zeeh_mobile/feature/activity/model/activity_model.dart';
import 'package:zeeh_mobile/feature/auth/data/state/auth_notifier.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/authenticated_user.dart';
import 'package:zeeh_mobile/feature/credit/data/state/credit_state_notifier.dart';
import 'package:zeeh_mobile/feature/credit/view/build_credit/article_screen.dart';
import 'package:zeeh_mobile/feature/credit/view/build_credit/build_credit.dart';
import 'package:zeeh_mobile/feature/home/view/home_page.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/article_widget.dart';
import 'package:zeeh_mobile/feature/profile/data/state/profile_state_notifier.dart';
import 'package:zeeh_mobile/feature/profile/model/user_details.dart';
import 'package:zeeh_mobile/feature/provider.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Wallethome extends ConsumerStatefulWidget {
  const Wallethome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WallethomeState();
}

class _WallethomeState extends ConsumerState<Wallethome> {
  dynamic credit = 0;

  UserDetails userDetails = UserDetails();
  AuthenticatedUser authUser = AuthenticatedUser();

  List<ActivityModel> activities = [];
 
  Future<WalletResponse> walletService() async {
    
    if (userDetails.firstName == null || userDetails.lastName == null) {
      print('User details are not available yet');
      throw Exception('User details are not available yet');
    }

 //https://v2.api.zeeh.africa
//https://dev.api.usezeeh.com

    var accountName = '${userDetails.firstName} ${userDetails.lastName}';
    var url = Uri.parse(
        'https://v2.api.zeeh.africa/wallet/get_or_create_wallet');
    var body =
        json.encode({"userId": userDetails.id, "account_name": accountName});


    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      WalletResponse walletResponse =
          WalletResponse.fromJson(jsonDecode(response.body));
      await saveWalletData(walletResponse);
      return WalletResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load wallet data');
    }
  }

  Future<void> saveWalletData(WalletResponse walletResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String walletResponseJson = jsonEncode(walletResponse.toJson());
    await prefs.setString('walletResponse', walletResponseJson);
    print('Wallet data saved to shared preferences');
  }

  @override
  void initState() {

    // Timer(Duration(seconds: 1), () {
    //   print(userDetails.firstName);
    //  // walletService();
    // });
    
    super.initState();
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor:Colors.white,
        backgroundColor: Color(0xFFFCFCFC),
        title: TopRow2(
                        name: userDetails.firstName ==null?"Zeeh":userDetails.firstName,
                        activities: activities.length,
                      ),
      ),
     backgroundColor: Color(0xFFFCFCFC),
      body: FutureBuilder<WalletResponse>(
        future: walletService(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 812.h,
              width: 375.w,
              color: Colors.transparent,
              child: Center(
                child: LoadingIndicatorWidget(
                  color: ZeehColors.buttonPurple,
                  height: 40.h,
                  width: 40.w,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              height: 812.h,
              width: 375.w,
              color: Colors.transparent,
              child: Center(
                child: LoadingIndicatorWidget(
                  color: ZeehColors.buttonPurple,
                  height: 40.h,
                  width: 40.w,
                ),
              ),
            );
          } else {
            final walletData = snapshot.data!.data;
            final virtualAccount = walletData.virtualAccount;
            final walletbalance = NumberFormat.currency(
              locale: 'en_NG',
              symbol: 'N',
            ).format(double.parse(walletData.availableBalance ?? "0.00"));
            final walletname = virtualAccount.accountName;

            return SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              onRefresh: () async {
                walletService();
                await Future.delayed(
                    Duration(seconds: 1)); // Simulating some async operation
                refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    // GestureDetector( 
                    //   onTap: () {},
                    //   child: TopRow2(
                    //     name: userDetails.firstName,
                    //     activities: activities.length,
                    //   ),
                    // ),
                    const Divider(
                      color: ZeehColors.greyColor,
                      thickness: 1.0,
                      height: 0.0,
                    ),


  Container(
  color: Colors.white,
  width: MediaQuery.of(context).size.width,
   height: MediaQuery.of(context).size.height * 0.45,
  //height: 350.h,
      child: Stack(
    children: [
      Stack(
        alignment: Alignment.center, 
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 260, // Adjust the height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/zeehcard.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),


          
          Positioned(
            left: MediaQuery.of(context).size.width * 0.16,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your\nbalance',
                    style: GoogleFonts.montserrat(
                      fontSize: 10.sp, // Adjust the font size
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                  Text(walletbalance,
                    style: GoogleFonts.dmMono(
                      fontSize: 18.sp, // Adjust the font size
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h), // Adjust the height as needed
                  Row(
                    children: [
                      Text(walletname,
                        style: GoogleFonts.montserrat(
                          fontSize: 10.sp, // Adjust the font size
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(width: 30.w), // Adjust the width as needed
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
 

      Positioned(
        bottom: 30.h, // Adjust as needed for spacing
        left: 0.0,
        right: 0.0,
        child: GestureDetector(
          onTap: () {
            navigate(context, Fundwallet());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0), // Adjust the padding as needed
            child: Container(
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: ZeehColors.buttonPurple,
                  ),
                  SizedBox(width: 5.w),
                  DMSanText(
                    text: "Top-up",
                    textColor: ZeehColors.buttonPurple,
                    fontSize: 14.sp,
                  ),
                ],
              ),

              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 0.5,
                  color: ZeehColors.greyColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),

    ],
  ),
),

//SizedBox(height: 40.h,), // Adjust the height as needed

Divider(
  color: ZeehColors.greyColor,
  thickness: 1.0,
  height: 0.0,
),

   
                    Column(
                      children: [
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(vertical: 10.0),
                        //   child: Divider(
                        //     color: ZeehColors.greyColor,
                        //     thickness: 1.0,
                        //     height: 0.0,
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 18, bottom: 18),
                          child: Row(
                            children: [
                              DMSanText(
                                text: "Recommened for you",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            navigate(context, Individuals());
                          },
                          child: Container(
                            height: 60.h,
                            width: MediaQuery.of(context).size.width - 40.w,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/dcredit.png"),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  DMSanText(
                                      text: "Check Credit Insight",
                                      fontSize: 14)
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 0.5, color: ZeehColors.greyColor),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 0),
                          child: Row(
                            children: [
                              const DMSanText(
                                text: "Articles for you",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: SingleChildScrollView(
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

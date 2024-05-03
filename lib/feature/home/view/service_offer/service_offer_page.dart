import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';
import 'package:zeeh_mobile/feature/offers/view/bnpl/bnpl_offer_page.dart';
import 'package:zeeh_mobile/feature/offers/view/insurance/insurance_option_screen.dart';

import '../../../../common/components/text_widget.dart';
import '../../../../constants/asset_paths.dart';

class ServiceOffer extends StatefulWidget {
  const ServiceOffer({super.key});

  @override
  State<ServiceOffer> createState() => _ServiceOfferState();
}

class _ServiceOfferState extends State<ServiceOffer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 812.h,
        width: 375.w,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const HomeHeaderWidgetTwo(title: "Service Offer"),
          SizedBox(
            height: 3.h,
          ),
          // Container(
          //   width: double.infinity,
          //   padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
          //   decoration: const BoxDecoration(color: Colors.white),
          //   child: InkWell(
          //     onTap: () => navigate(context, const ActiveOffers()),
          //     child: GroteskText(
          //       text: "Active offers (8)",
          //       fontWeight: FontWeight.w500,
          //       fontSize: 18.sp,
          //       textColor: ZeehColors.buttonPurple,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 17.h,
          // ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 15.h),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DMSanText(
                text: "New service offers",
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
              SizedBox(
                height: 17.h,
              ),
              const HomeFeatureWidget(
                  description: 'Secure high credit score',
                  imageAsset: ZeehAssets.growingMoneyIcon,
                  title: 'Investment'),
              const Divider(thickness: 1, color: Color(0xffD7D7D7)),
              const HomeFeatureWidget(
                description: 'Access to financial stability',
                imageAsset: ZeehAssets.bankCardIcon,
                title: 'Credit card',
              ),
            ]),
          ),
          SizedBox(
            height: 17.h,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 15.h),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DMSanText(
                text: "Service offers",
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
              SizedBox(
                height: 3.h,
              ),
              // HomeFeatureWidget(
              //   onTap: () => navigate(context, const LoanOffersPage()),
              //   description: 'Your way top emergency funds',
              //   imageAsset: ZeehAssets.dollarBankNotesIcon,
              //   title: 'Loan',
              // ),
              const Divider(thickness: 1, color: Color(0xffD7D7D7)),
              HomeFeatureWidget(
                onTap: () => navigate(context, const InsuranceOptionScreen()),
                description: 'Easy way to safer life',
                imageAsset: ZeehAssets.insuranceProtectIcon,
                title: 'Insurance',
              ),
              const Divider(thickness: 1, color: Color(0xffD7D7D7)),
              HomeFeatureWidget(
                onTap: () => navigate(context, const BnplOffersPage()),
                description: 'Buy now and pay by installments',
                imageAsset: ZeehAssets.buyingIcon,
                title: 'Buy now pay later',
              ),
              const Divider(thickness: 1, color: Color(0xffD7D7D7)),
              SizedBox(
                height: 14.h,
              ),
              const NoteWidget(
                text:
                    "New interesting service offers will keep coming to you as long as your credit goals and creditworthiness improves.",
              )
            ]),
          ),
        ]),
      ),
    );
  }
}

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      decoration: const BoxDecoration(
          color: Color(0xffF8F9FD),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(children: [
        CircleAvatar(
          backgroundColor: const Color(0xffEBEAEE),
          radius: 10.sp,
          child: CircleAvatar(
            backgroundColor: ZeehColors.buttonPurple,
            radius: 6.sp,
            child: DMSanText(
              text: "?",
              textColor: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: SizedBox(
            width: 270.w,
            child: DMSanText(
              text: text,
              fontSize: 10.sp,
              maxLines: 4,
            ),
          ),
        ),
      ]),
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
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.0.h),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0.h),
          child: Row(
            children: [
              Image.asset(
                imageAsset,
                height: 40.h,
                width: 40.w,
              ),
              SizedBox(width: 16.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DMSanText(
                    text: title,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 4.h),
                  SizedBox(
                    width: 206.w,
                    child: DMSanText(
                      text: description,
                      fontSize: 11.sp,
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/feature/offers/view/bnpl/take_bnpl_details_page.dart';

import '../../../../common/components/text_widget.dart';
import '../../../../common/utils/navigator.dart';
import '../../../../constants/colors.dart';
import '../../../home/view/service_offer/active_offer_page.dart';
import '../../../home/view/widgets/home_header_widget_two.dart';

class BnplOffersPage extends StatefulWidget {
  const BnplOffersPage({super.key});

  @override
  State<BnplOffersPage> createState() => _BnplOffersPageState();
}

class _BnplOffersPageState extends State<BnplOffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 812.h,
          width: 375.w,
          decoration: const BoxDecoration(color: ZeehColors.scaffoldBackground),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeaderWidgetTwo(title: "Buy now and pay later"),
              SizedBox(
                height: 17.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 327.w,
                      height: 58.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.r),
                        ),
                        border: Border.all(
                          color: ZeehColors.greyColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 24.sp,
                            color: ZeehColors.grayColor,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: GroteskText(
                              text: "Search by name",
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 17.h),
                    ActiveOffersFeatureWidget(
                        onTap: () => navigate(context, const TakeBnplPage()),
                        title: "CredPal",
                        description: "Item : Laptop",
                        moreDetails: "6 months purchase plan",
                        titleRight: "₦300,000.00",
                        descriptionRight: "Weekly payback"),
                    const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    const ActiveOffersFeatureWidget(
                        title: "CredPal",
                        description: "Item : Laptop",
                        moreDetails: "6 months purchase plan",
                        titleRight: "₦20,000.00",
                        descriptionRight: "Weekly payback"),
                    const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    const ActiveOffersFeatureWidget(
                        title: "CredPal",
                        description: "Item : Laptop",
                        moreDetails: "6 months purchase plan",
                        titleRight: "₦20,000.00",
                        descriptionRight: "Weekly payback"),
                    const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    const ActiveOffersFeatureWidget(
                        title: "CredPal",
                        description: "Item : Laptop",
                        moreDetails: "6 months purchase plan",
                        titleRight: "₦20,000.00",
                        descriptionRight: "Weekly payback"),
                    const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    const ActiveOffersFeatureWidget(
                        title: "CredPal",
                        description: "Item : Laptop",
                        moreDetails: "6 months purchase plan",
                        titleRight: "₦20,000.00",
                        descriptionRight: "Weekly payback"),
                    const Divider(thickness: 1, color: Color(0xffD7D7D7)),
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

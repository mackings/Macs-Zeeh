import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/feature/offers/view/investment/take_investment_details_page.dart';

import '../../../../common/utils/navigator.dart';
import '../../../../constants/asset_paths.dart';
import '../../../../constants/colors.dart';
import '../../../home/view/service_offer/active_offer_page.dart';
import '../../../home/view/widgets/home_header_widget_two.dart';

class InsuranceOfferPage extends StatefulWidget {
  const InsuranceOfferPage({super.key});

  @override
  State<InsuranceOfferPage> createState() => _InsuranceOfferPageState();
}

class _InsuranceOfferPageState extends State<InsuranceOfferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: 812.h,
          width: 375.w,
          decoration: const BoxDecoration(
            color: ZeehColors.scaffoldBackground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeaderWidgetTwo(
                title: "Insurance Offers",
              ),
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
                      ActiveOffersFeatureWidget(
                          onTap: () =>
                              navigate(context, const TakeInvestmentPage()),
                          title: "Alico Insurance",
                          description: "6 months term",
                          moreDetails: "Vehicle Insurance",
                          moreDetailsIcon: ZeehAssets.carIcon,
                          titleRight: "₦300,000.00",
                          descriptionRight: "Basic"),
                      const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                      const ActiveOffersFeatureWidget(
                          title: "Alico Insurance",
                          description: "6 months term",
                          moreDetails: "Life Insurance",
                          moreDetailsIcon: ZeehAssets.umbrellaIcon,
                          titleRight: "₦20,000.00",
                          descriptionRight: "Payback weekly"),
                      const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                      const ActiveOffersFeatureWidget(
                          title: "Alico Insurance",
                          description: "6 months term",
                          moreDetails: "Health Insurance",
                          moreDetailsIcon: ZeehAssets.heartPlusIcon,
                          titleRight: "₦300,000.00",
                          descriptionRight: "Premuim"),
                      const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                      const ActiveOffersFeatureWidget(
                          title: "Alico Insurance",
                          description: "3 months term",
                          moreDetailsIcon: ZeehAssets.homeIconTwo,
                          moreDetails: "House Insurance",
                          titleRight: "₦100,000.00",
                          descriptionRight: "Payback weekly"),
                      const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                      const ActiveOffersFeatureWidget(
                        title: "Fairmoney",
                        description: "3 months term",
                        moreDetails: "Car Insurance",
                        moreDetailsIcon: ZeehAssets.carIcon,
                        titleRight: "₦100,000.00",
                        descriptionRight: "Basic",
                      ),
                      const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                      const ActiveOffersFeatureWidget(
                        title: "Fairmoney",
                        description: "3 months term",
                        moreDetails: "Car Insurance",
                        moreDetailsIcon: ZeehAssets.carIcon,
                        titleRight: "₦100,000.00",
                        descriptionRight: "Basic",
                      ),
                      const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                      SizedBox(
                        height: 25.h,
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

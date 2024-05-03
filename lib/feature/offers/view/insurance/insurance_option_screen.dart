import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/home/view/service_offer/service_offer_page.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';
import 'package:zeeh_mobile/feature/offers/view/insurance/insurance_offer_page.dart';

class InsuranceOptionScreen extends StatefulWidget {
  const InsuranceOptionScreen({super.key});

  @override
  State<InsuranceOptionScreen> createState() => _InsuranceOptionScreenState();
}

class _InsuranceOptionScreenState extends State<InsuranceOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeHeaderWidgetTwo(title: "Insurance"),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () => navigate(
                    context,
                    const InsuranceOfferPage(),
                  ),
                  child: const HomeFeatureWidget(
                    title: "Vehicle Insurance",
                    description: "Secure your vehicle",
                    imageAsset: ZeehAssets.carInsuranceIcon,
                  ),
                ),
                const Divider(thickness: 1, color: ZeehColors.greyColor),
                InkWell(
                  onTap: () => navigate(
                    context,
                    const InsuranceOfferPage(),
                  ),
                  child: const HomeFeatureWidget(
                    title: "Health Insurance",
                    description: "Secure your health",
                    imageAsset: ZeehAssets.healthIcon,
                  ),
                ),
                const Divider(thickness: 1, color: ZeehColors.greyColor),
                InkWell(
                  onTap: () => navigate(
                    context,
                    const InsuranceOfferPage(),
                  ),
                  child: const HomeFeatureWidget(
                    title: "House Insurance",
                    description: "Secure your house",
                    imageAsset: ZeehAssets.houseIcon,
                  ),
                ),
                const Divider(thickness: 1, color: ZeehColors.greyColor),
                SizedBox(height: 30.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}

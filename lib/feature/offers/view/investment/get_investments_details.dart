import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/dropdowns/dropdown_button.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';
import 'package:zeeh_mobile/feature/offers/view/investment/confrim_investments_page.dart';

import '../../../../common/components/button.dart';
import '../../../../common/components/text_widget.dart';
import '../../../../common/components/textfield_box.dart';
import '../../../../common/utils/navigator.dart';

class GetInvestmentDetails extends StatefulWidget {
  const GetInvestmentDetails({super.key});

  @override
  State<GetInvestmentDetails> createState() => _GetInvestmentDetailsState();
}

class _GetInvestmentDetailsState extends State<GetInvestmentDetails> {
  bool _isCheckedPublic = false;
  bool _isCheckedPrivate = false;
  bool _isCheckedPublicPrivate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 375.w,
          decoration: const BoxDecoration(color: ZeehColors.scaffoldBackground),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeaderWidgetTwo(title: "Alico insurance"),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GroteskText(
                          text: "Vehicle category",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 8.h),
                        const CustomDropdownButton(
                          buttonName: "-- Select category --",
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GroteskText(
                          text: "Vehicle brand",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 8.h),
                        const CustomDropdownButton(
                          buttonName: "-- Select brand --",
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GroteskText(
                          text: "Vehicle model",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 8.h),
                        const TextFieldBox(
                          hintText: "Enter vehicle model",
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GroteskText(
                          text: "Vehicle reg model",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 8.h),
                        const TextFieldBox(
                          hintText: "Enter reg model",
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GroteskText(
                          text: "Fuel variant",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 8.h),
                        const CustomDropdownButton(
                          buttonName: "-- Select variant --",
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    GroteskText(
                      text: "Select permit type of the vehicle *",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                side: const BorderSide(width: 0.9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                checkColor: Colors.white,
                                activeColor: ZeehColors.buttonPurple,
                                value: _isCheckedPublic,
                                onChanged: (bool? value) {
                                  setState(
                                    () {
                                      _isCheckedPublic = value ?? false;
                                    },
                                  );
                                },
                              ),
                            ),
                            const GroteskText(
                              text: "Public",
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                side: const BorderSide(width: 0.9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                checkColor: Colors.white,
                                activeColor: ZeehColors.buttonPurple,
                                value: _isCheckedPrivate,
                                onChanged: (bool? value) {
                                  setState(
                                    () {
                                      _isCheckedPrivate = value ?? false;
                                    },
                                  );
                                },
                              ),
                            ),
                            const GroteskText(
                              text: "Private",
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                side: const BorderSide(width: 0.9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                checkColor: Colors.white,
                                activeColor: ZeehColors.buttonPurple,
                                value: _isCheckedPublicPrivate,
                                onChanged: (bool? value) {
                                  setState(
                                    () {
                                      _isCheckedPublicPrivate = value ?? false;
                                    },
                                  );
                                },
                              ),
                            ),
                            const GroteskText(
                              text: "Public-Private",
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ZeehButton(
                  onClick: () =>
                      navigate(context, const ConfrimInvestmentPage()),
                  text: "Continue",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/components/textfield_box.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/Wallet/Credit/downloadsucccess.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';




class Businesses extends ConsumerStatefulWidget {
  const Businesses({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BusinessesState();
}

class _BusinessesState extends ConsumerState<Businesses> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: DMSanText(
          text: "For Businesses",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35.h),
              DMSanText(
                text: "Credit bureau",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 10.h),
              TextFieldBox(
                hintText: "--Select--",
                suffixIcon: DropdownButton<String>(
                  icon: Icon(Icons.arrow_drop_down),
                  //value: _selectedCurrency,
                  underline: Container(),
                  items: <String>['Top bureau', 'Naija bureau']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: DMSanText(
                          text: value,
                          fontSize: 14,
                        ));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      //  _selectedCurrency = newValue!;
                    });
                  },
                ),
              ),

              SizedBox(
                height: 20.h,
              ),

              DMSanText(
                text: "Registration number",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 10.h),
              TextFieldBox(
                hintText: "Enter your RC No.",
              ),
              SizedBox(height: 360.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ZeehButton(
                    onClick: () {
                      navigate(context, Downloadsuccess());
                    },
                    text: "Download report"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/colors.dart';

class CountryDropdownButton extends StatefulWidget {
  const CountryDropdownButton({
    super.key,
    this.onSelectCountry,
  });

  final Function(String?)? onSelectCountry;

  @override
  State<CountryDropdownButton> createState() => _CountryDropdownButtonState();
}

class _CountryDropdownButtonState extends State<CountryDropdownButton> {
  List<String> listOfCountries = ["", "Nigeria"];

  String? country = "";

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Center(
        // child: dropDown(),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            elevation: 1,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down,
            ),
            value: country,
            onChanged: (val) {
              widget.onSelectCountry!(val);
              setState(() {
                country = val;
              });
            },
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 14.0.h,
              color: ZeehColors.grayColor,
              fontWeight: FontWeight.w400,
            ),
            items:
                listOfCountries.map<DropdownMenuItem<String>>((String country) {
              return DropdownMenuItem<String>(
                value: country,
                child: GroteskText(
                  text: country,
                  fontSize: 14.sp,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

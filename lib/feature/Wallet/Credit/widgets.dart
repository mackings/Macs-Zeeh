import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/colors.dart';

class DropdownFieldBox<T> extends StatelessWidget {
  final String? hintText;
  final double? height;
  final double? width;
  final T? value;
  final List<T>? items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  const DropdownFieldBox({
    Key? key,
    this.hintText,
    this.height,
    this.width,
    this.value,
    this.items,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: DropdownButtonFormField<T>(
        value: value,
        items: items != null
            ? items!
                .map((item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(item.toString()),
                    ))
                .toList()
            : null,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 10.w),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ZeehColors.greyColor,
              width: 2,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ZeehColors.greyColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w400,
            fontSize: 14.h,
            color: const Color(0x805F6D7E),
          ),
        ),
      ),
    );
  }
}




class SuccessModalSheet extends StatelessWidget {
  final String message;
  final VoidCallback onButtonPressed;

  SuccessModalSheet({required this.message, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.check_circle, color: ZeehColors.buttonPurple, size: 50),
          SizedBox(height: 16.0),
          Text(
            'Credit report generated',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: InkWell(
              onTap: onButtonPressed,
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: ZeehColors.buttonPurple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Preview Report",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
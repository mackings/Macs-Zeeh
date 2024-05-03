import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

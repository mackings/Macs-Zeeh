import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/constants/colors.dart';

// Reusable TextField used App Wide



class TextFieldBox extends StatelessWidget {
  final String? hintText;
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final Widget? suffixColor;
  final Widget? prefixIcon;
  final bool? isCollapsed;
  final bool? isEnabled;
  final Function(String)? onChanged;
  final bool? autoFocus;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final Color? textColor;
  final bool? filled;
  final Color? fillColor;
  final int? maxLines;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final Color? prefixColor;
  final bool? autoCorrect;
  final bool? enableSuggestion;
  final List<TextInputFormatter>? inputFormatters;
  final double? fontSize;
  final String? prefixText;

  const TextFieldBox({
    Key? key,
    this.hintText,
    this.height,
    this.width,
    this.controller,
    this.validator,
    this.textColor,
    this.textInputAction,
    this.obscureText,
    this.suffixColor,
    this.prefixIcon,
    this.isCollapsed,
    this.isEnabled,
    this.onChanged,
    this.autoFocus,
    this.suffixIcon,
    this.hintStyle,
    this.filled,
    this.fillColor,
    this.maxLines,
    this.focusNode,
    this.onEditingComplete,
    this.borderColor,
    this.keyboardType,
    this.prefixColor,
    this.autoCorrect,
    this.enableSuggestion,
    this.inputFormatters,
    this.fontSize,
    this.prefixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextFormField(
        inputFormatters: inputFormatters,
        autocorrect: autoCorrect ?? true,
        enableSuggestions: enableSuggestion ?? true,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        maxLines: maxLines ?? 1,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        style: TextStyle(
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w400,
          fontSize: fontSize ?? 16.h,
          color: ZeehColors.blackColor,
          decoration: TextDecoration.none,
        ),
        obscureText: obscureText ?? false,
        cursorColor: ZeehColors.blackColor,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 24.h, vertical: 10.w),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefixText: prefixText,
          prefixStyle: TextStyle(
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w400,
            fontSize: fontSize ?? 14.h,
            color: ZeehColors.blackColor,
            decoration: TextDecoration.none,
          ),
          prefixIconColor: prefixColor,
          fillColor: fillColor ?? Colors.white,
          filled: filled ?? true,
          border: OutlineInputBorder(

            borderSide: BorderSide(
              color: borderColor ?? ZeehColors.greyColor,
              width: 3,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ZeehColors.greyColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
          ),
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyle(
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



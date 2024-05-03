import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zeeh_mobile/constants/colors.dart';

class PinOTPFieldWidget extends StatefulWidget {
  const PinOTPFieldWidget({
    super.key,
    this.width,
    required this.controller,
    required this.length,
    this.onComplete,
    this.textColor,
    this.inactiveColor,
    this.activeColor,
    this.fieldWidth,
    this.fieldHeight,
    this.borderRadius,
    this.inactiveFillColor,
    this.activeFillColor,
    this.selectedFillColor,
    this.obscureText,
    this.cursorColor,
    this.selecedColor,
  });

  final double? width;
  final TextEditingController controller;
  final int length;
  final Function(String)? onComplete;
  final Color? textColor;
  final Color? inactiveColor;
  final Color? activeColor;

  final double? fieldWidth;
  final double? fieldHeight;

  final double? borderRadius;

  final Color? inactiveFillColor;
  final Color? activeFillColor;
  final Color? selectedFillColor;

  final bool? obscureText;

  final Color? cursorColor;
  final Color? selecedColor;

  @override
  State<PinOTPFieldWidget> createState() => _PinOTPFieldWidgetState();
}

class _PinOTPFieldWidgetState extends State<PinOTPFieldWidget> {
  String currentText = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 250.w,
      child: PinCodeTextField(
        length: widget.length,
        obscureText: widget.obscureText ?? false,
        keyboardType: TextInputType.number,
        animationType: AnimationType.fade,
        cursorColor: widget.cursorColor ?? ZeehColors.greyColor,
        textStyle: TextStyle(
          color: widget.textColor ?? ZeehColors.buttonPurple,
          fontFamily: 'DM Sans',
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderWidth: 1.h,
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius ?? 6.r),
          ),
          fieldHeight: widget.fieldHeight ?? 56.h,
          fieldWidth: widget.fieldWidth ?? 56.w,
          selectedFillColor: widget.selectedFillColor ??
              const Color(0xffffffff).withOpacity(0.1),
          selectedColor: widget.selecedColor ?? ZeehColors.greyColor,
          activeColor: widget.activeColor ?? ZeehColors.buttonPurple,
          activeFillColor: widget.activeFillColor ??
              const Color(0xffffffff).withOpacity(0.1),
          inactiveColor: widget.inactiveColor ?? ZeehColors.greyColor,
          inactiveFillColor: widget.inactiveFillColor ??
              const Color(0xffffffff).withOpacity(0.1),
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        controller: widget.controller,
        onCompleted: widget.onComplete,
        onChanged: (value) {
          setState(() {
            currentText = value;
          });
        },
        beforeTextPaste: (text) {
          return true;
        },
        appContext: context,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/colors.dart';

class LoanPaymentTile<T> extends StatelessWidget {
  const LoanPaymentTile({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    required this.body,
  }) : super(key: key);

  final Widget body;
  final T groupValue;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    bool isHighlighted = value == groupValue;

    return GestureDetector(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: isHighlighted ? 2 : 1,
            color:
                isHighlighted ? ZeehColors.buttonPurple : ZeehColors.greyColor,
          ),
        ),
        child: Row(
          children: [
            Radio<T>(
              activeColor: ZeehColors.buttonPurple,
              value: value,
              groupValue: groupValue,
              onChanged: (T? newValue) {
                onChanged(newValue as T);
              },
            ),
            body,
          ],
        ),
      ),
    );
  }
}

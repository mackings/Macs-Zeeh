import 'package:flutter/material.dart';
import 'package:zeeh_mobile/constants/colors.dart';

/// Reusable Radio List Tile Widget used majorly for selection

class ProductLabeledRadio<T> extends StatelessWidget {
  const ProductLabeledRadio({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    required this.title,
    this.width,
    this.topPad,
    this.containerHeight,
    this.containerWidth,
  }) : super(key: key);

  final List<Widget> title;
  final double? containerHeight;
  final double? containerWidth;
  final double? topPad;
  final double? width;
  final T groupValue;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containerHeight,
      width: containerWidth,
      child: InkWell(
        onTap: () {
          if (value != groupValue) {
            onChanged(value);
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Radio List Tile Title
            Row(
              children: title,
            ),

            const Spacer(),

            // Radio Widget
            Radio<T>(
              activeColor: ZeehColors.buttonPurple,
              value: value,
              groupValue: groupValue,
              onChanged: (T? newValue) {
                onChanged(newValue as T);
              },
            ),
          ],
        ),
      ),
    );
  }
}

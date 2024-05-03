import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/colors.dart';

class CustomBottomAppBarItem {
  final String imageData;
  final String text;

  CustomBottomAppBarItem(this.imageData, this.text);
}

class CustomBottomAppBar extends StatefulWidget {
  final List<CustomBottomAppBarItem> items;
  final double? height;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? textColor;
  final Color? selectedColor;
  final ValueChanged<int> onTabSelected;

  const CustomBottomAppBar({
    super.key,
    required this.items,
    this.height,
    this.iconSize,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    required this.onTabSelected,
    this.textColor,
  });

  @override
  State<StatefulWidget> createState() => CustomBottomAppBarState();
}

class CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _selectedIndex = 0;

  // Update Index
  _updatedIndex(int index) {
    widget.onTabSelected(index);
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Generated a list of the Items for the BottomNavBar
    List<Widget> items = List.generate(
      widget.items.length,
      (int index) {
        return _buildTabItem(
          item: widget.items[index],
          index: index,
          onPressed: _updatedIndex,
        );
      },
    );
    // items.insert(items.length >> 1, _buildMiddleTabItem());

    // Bottom App Bar Implementation
    return BottomAppBar(
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.only(
          top: 0,
          bottom: 8.0.h,
          left: 8.0.w,
          right: 8.0.w,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        ),
      ),
    );
  }

  Widget _buildTabItem({
    CustomBottomAppBarItem? item,
    int? index,
    ValueChanged<int>? onPressed,
  }) {
    Color? topColor =
        _selectedIndex == index ? widget.selectedColor : Colors.white;
    Color? color =
        _selectedIndex == index ? widget.selectedColor : widget.color;
    Color? textColor = _selectedIndex == index
        ? ZeehColors.buttonPurple
        : ZeehColors.greyColor;

    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed!(index!),
            borderRadius: BorderRadius.circular(10.0.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4.h,
                  width: 40.h,
                  decoration: BoxDecoration(
                    color: topColor,
                    borderRadius: BorderRadius.circular(4.0.r),
                  ),
                ),
                SizedBox(height: 10.h),
                SvgPicture.asset(
                  item!.imageData,
                  height: 25.h,
                  width: 25.w,
                  color: color,
                ),
                GroteskText(
                  text: item.text,
                  textColor: textColor,
                  fontSize: 12.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

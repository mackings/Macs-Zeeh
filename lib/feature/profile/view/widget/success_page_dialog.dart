import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';

import '../../../../common/utils/navigator.dart';

class SuccessPageDialog extends StatelessWidget {
  const SuccessPageDialog({
    Key? key,
    required this.bodyText,
    required this.headerText,
    required this.imagePath,
    this.duplicateHeader = false,
    this.twoButtons = false,
    this.subHeader,
    this.yesClick,
    this.noClick,
  }) : super(key: key);

  final String bodyText;
  final String headerText;
  final String imagePath;
  final bool duplicateHeader;
  final String? subHeader;
  final bool twoButtons;
  final Function()? yesClick;
  final Function()? noClick;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: 375.w,
        decoration: BoxDecoration(
          color: ZeehColors.scaffoldBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.r),
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  child: Center(
                    child: DMSanText(
                      text: headerText,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(height: 100.h),
                        SizedBox(
                          width: 120.w,
                          height: 120.h,
                          child: SvgPicture.asset(imagePath),
                        ),
                        SizedBox(height: 24.h),
                        duplicateHeader
                            ? Column(
                                children: [
                                  DMSanText(
                                    text: subHeader ?? headerText,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 24.h),
                                ],
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          width: 300.sp,
                          child: DMSanText(
                            text: bodyText,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            maxLines: 4,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 60.h,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: twoButtons
                    ? Column(
                        children: [
                          ZeehButton(
                            onClick: yesClick!,
                            text: 'Yes',
                          ),
                          SizedBox(height: 16.h),
                          ZeehButton(
                            onClick: noClick!,
                            isOutline: true,
                            text: 'No',
                          ),
                        ],
                      )
                    : ZeehButton(
                        onClick: () => popView(context),
                        text: 'Return home',
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onNoClick(BuildContext context) {
    showCustomModalBottomSheet(
      context,
      child: const SuccessPageDialog(
        bodyText: 'Your account could not be deleted'
            ' because you are yet to complete'
            ' your loan payment',
        headerText: 'Delete account',
        imagePath: ZeehAssets.failureIcon,
      ),
    );
  }

  void onYesClick(BuildContext context) {
    showCustomModalBottomSheet(
      context,
      child: const SuccessPageDialog(
        duplicateHeader: true,
        subHeader: 'Success !',
        bodyText: 'Your account has been deleted',
        headerText: 'Delete account',
        imagePath: ZeehAssets.successSvgIcon,
      ),
    );
  }
}

void showCustomModalBottomSheet(BuildContext context, {required Widget child}) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false,
    clipBehavior: Clip.antiAlias,
    context: context,
    builder: (BuildContext sheetContext) => child,
  );
}

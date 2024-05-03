import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/colors.dart';

class VerificationChannelDropdownButton extends StatefulWidget {
  const VerificationChannelDropdownButton({
    super.key,
    this.onSelectChannel,
  });

  final Function(String?)? onSelectChannel;

  @override
  State<VerificationChannelDropdownButton> createState() => _VerificationChannelDropdownButtonState();
}

class _VerificationChannelDropdownButtonState extends State<VerificationChannelDropdownButton> {
  List<String> listOfChannels = ["", "Bank Verification Number (BVN)"];

  String? channel = "";

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
            value: channel,
            onChanged: (val) {
              widget.onSelectChannel!(val);
              setState(() {
                channel = val;
              });
            },
            style: TextStyle(
              fontFamily: 'ClashGrotesk',
              fontSize: 14.0.h,
              color: ZeehColors.grayColor,
              fontWeight: FontWeight.w400,
            ),
            items:
                listOfChannels.map<DropdownMenuItem<String>>((String channel) {
              return DropdownMenuItem<String>(
                value: channel,
                child: GroteskText(
                  text: channel,
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

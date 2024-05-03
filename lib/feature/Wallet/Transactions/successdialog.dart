import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/pin_otp_field.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/components/textfield_box.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';

class Successdialog extends ConsumerStatefulWidget {
  const Successdialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SuccessdialogState();
}

class _SuccessdialogState extends ConsumerState<Successdialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 250.h,
              ),

              Column(
                children: [
                  Image.asset("assets/images/sent.png"),

                  SizedBox(height: 15.h,),

                  DMSanText(text: "Success!",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,),

                  SizedBox(height: 15.h,),

          Text(
            'Your have  successfully sent N1,000 to\nthe recipient wallet.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF282A2B),
              fontSize: 16,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w500,
            ),
          ),
          
                ],
              ),

          SizedBox(height: 50.h,),
              
          ZeehButton(onClick: (){}, text: "Done"),

          SizedBox(height: 15.h,),

                    ZeehButton(
                      isOutline: true,
                      borderColor: ZeehColors.greyColor,
                      textColor: ZeehColors.blackColor,
                      onClick: (){}, 
                      text: "Send money again")
        
            ],
          ),
        ),
      ),
    );
  }
}

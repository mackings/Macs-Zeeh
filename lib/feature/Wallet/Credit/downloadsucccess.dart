import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/components/textfield_box.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/Wallet/Credit/credithome.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';

class Downloadsuccess extends ConsumerStatefulWidget {
  const Downloadsuccess({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DownloadsuccessState();
}

class _DownloadsuccessState extends ConsumerState<Downloadsuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(
                    height: 15.h,
                  ),
                  DMSanText(
                    text: "Success!",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'Your have  successfully downloaded \nyour credit insight',
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
              SizedBox(
                height: 90.h,
              ),
              ZeehButton(
                  onClick: () {
    
                    Navigator.pop(context);
                    Navigator.pop(context);
                    
                  },
                  text: "Return to credit insight"),
            ],
          ),
        ),
      ),
    );
  }
}

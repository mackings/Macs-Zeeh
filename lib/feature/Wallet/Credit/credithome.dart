import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/Wallet/Credit/businesses.dart';
import 'package:zeeh_mobile/feature/Wallet/Credit/individual.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';

class Credithome extends ConsumerStatefulWidget {
  const Credithome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CredithomeState();
}

class _CredithomeState extends ConsumerState<Credithome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: DMSanText(
          text: "Credit Insights",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: ZeehColors.greyColor,
            height: 1.0,
            thickness: 1.0,
          ),
          SizedBox(height: 30),
Text(
  'Retrieve comprehensive credit histories for both \nbusinesses and individuals from all major credit \nbureaus with just one search',
  style: TextStyle(
    color: Color(0xFF242739),
    fontSize: MediaQuery.of(context).size.width * 0.039, // Adjust the multiplier as needed
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.w400,
    height: 1.2,
  ),
),


Padding(
  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: MediaQuery.of(context).size.height * 0.03),
  child: Column( 
    children: [
      GestureDetector(
        onTap: () {
          navigate(context, Individuals());
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Color(0xFFD7D7D7)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            title: DMSanText(
              text: "For Individuals",
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w500,
            ),
            subtitle: Text(
              'Generate customer credit insights',
              style: TextStyle(
                color: Color(0xFF5F6D7E),
                fontSize: MediaQuery.of(context).size.width * 0.032,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: ZeehColors.buttonPurple,
              child: Icon(
                Icons.person_2_outlined,
                color: Colors.white,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.015),


      GestureDetector(
        onTap: () {
          //navigate(context, Individuals());
          navigate(context, Businesses());
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Color(0xFFD7D7D7)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            title: DMSanText(
              text: "For Businesses",
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w500,
            ),
            subtitle: Text(
              'Generate business credit insights',
              style: TextStyle(
                color: Color(0xFF5F6D7E),
                fontSize: MediaQuery.of(context).size.width * 0.032,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: ZeehColors.buttonPurple,
              child: Icon(
                Icons.business,
                color: Colors.white,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    ],
  ),
)

        ],
      ),
    );
  }
}

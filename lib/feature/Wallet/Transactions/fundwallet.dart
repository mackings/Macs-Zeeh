import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/Wallet/model/wallet.dart';

class Fundwallet extends ConsumerStatefulWidget {
  const Fundwallet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FundwalletState();
}

class _FundwalletState extends ConsumerState<Fundwallet> {
  WalletResponse? _walletResponse;
  dynamic Balance;

  Future<WalletResponse?> getWalletDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? walletDataJson = prefs.getString('walletResponse');

    if (walletDataJson != null) {
      Map<String, dynamic> walletDataMap = jsonDecode(walletDataJson);

      // Access the available balance from walletDataMap
      String formattedBalance = NumberFormat.currency(
        locale: 'en_NG',
        symbol: 'N',
      ).format(
          double.parse(walletDataMap['data']['available_balance'] ?? "0.00"));

      setState(() {
        Balance = formattedBalance;
      });
      return WalletResponse.fromJson(walletDataMap);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getWalletDataFromSharedPreferences().then((walletResponse) {
      setState(() {
        _walletResponse = walletResponse;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DMSanText(
                text: "Available balance",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textColor: Color(0xFF5F6D7E),
              ),
              SizedBox(
                height: 10.h,
              ),
              DMSanText(
                text: Balance,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 28.h,
              ),
              Text(
                'Pay into this account to instantly fund your Zeeh wallet.',
                style: TextStyle(
                  color: Color(0xFF5F6D7E),
                  fontSize: 12,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Mycard(
                virtualAccount: _walletResponse?.data.virtualAccount,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'NOTE:',
                      style: TextStyle(
                        color: Color(0xFF5F6D7E),
                        fontSize: MediaQuery.of(context).size.width *
                            0.035, // Adjust the font size as needed
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' Please note that this account is only for your wallet \ntop-up. Your registered funding bank account and payment \nfrom any other account will be charged.',
                      style: TextStyle(
                        color: Color(0xFF5F6D7E),
                        fontSize: MediaQuery.of(context).size.width *
                            0.030, // Adjust the font size as needed
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Mycard extends StatelessWidget {
  final VirtualAccount? virtualAccount;

  const Mycard({Key? key, this.virtualAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(width: 1, color: Color(0xFFEBEBEB)),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Your virtual account details',
                  style: TextStyle(
                    color: Color(0xFF242739),
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildAccountDetail(
                  'Account Name', virtualAccount?.accountName ?? ""),
              _buildAccountDetail(
                  'Account Number', virtualAccount?.accountNumber ?? ""),
              _buildAccountDetail('Bank Name', virtualAccount?.bankName ?? ""),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountDetail(String title, String detail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF5F6D7E),
                    fontSize: 12,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  detail,
                  style: TextStyle(
                    color: Color(0xFF242739),
                    fontSize: 14,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            FlutterClipboard.copy(virtualAccount!.accountNumber).then((value) {
              Fluttertoast.showToast(
                msg: "Copied",
                backgroundColor: ZeehColors.buttonPurple
                );
            });
          },
          icon: Icon(
            Icons.content_copy_rounded,
            color: ZeehColors.buttonPurple,
          ),
        ),
      ],
    );
  }
}

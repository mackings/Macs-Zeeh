import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/finnacle_loading_widget.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/components/textfield_box.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/Wallet/Credit/credithome.dart';
import 'package:zeeh_mobile/feature/Wallet/model/wallet.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Transhistory extends StatefulWidget {
  const Transhistory({Key? key}) : super(key: key);

  @override
  _TranshistoryState createState() => _TranshistoryState();
}

class _TranshistoryState extends State<Transhistory> {
  List<Transaction> transactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? walletResponseJson = prefs.getString('walletResponse');

    if (walletResponseJson == null) {
      print('Wallet data not found in SharedPreferences');
      return;
    }

    try {
      WalletResponse walletResponse =
          WalletResponse.fromJson(jsonDecode(walletResponseJson));
      int walletId = walletResponse.data.virtualAccount.walletId;
      print(walletResponse.data.usezeeh_user_id);

      var response = await http.get(
        Uri.parse(
            'https://sandbox.api.zeeh.africa/wallet/get_usezeeh_user_transaction/$walletId'),
      );
     //$walletId
      if (response.statusCode == 200) {
        print(walletId);
        var jsonResponse = jsonDecode(response.body);
        var data = jsonResponse['data'];
        if (data is List) {
          setState(() {
            transactions = data
                .map((transactionData) => Transaction.fromJson(transactionData))
                .toList();
            isLoading = false;
          });
        } else if (data is Map<String, dynamic>) {
          setState(() {
            transactions = [Transaction.fromJson(data)];
            isLoading = false;
          });
        } else {
          print('Invalid data format in response');
        }
      } else {
        print(walletId);
        print('Request failed with status: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Transactions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: ZeehColors.greyColor,
            height: 1.0,
            thickness: 1.0,
          ),
          Expanded(
            child: isLoading
                ? Container(
              height: 812.h,
              width: 375.w,
              color: Colors.transparent,
              child: Center(
                child: LoadingIndicatorWidget(
                  color: ZeehColors.buttonPurple,
                  height: 40.h,
                  width: 40.w,
                ),
              ),
            )
                : transactions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/images/zero.png"),
                            ),
                            Text(
                              "No transaction history",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ListTile(
                              title: DMSanText(
                                text: "${transactions[index].serviceName}",
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                textColor: Color(0xFF445368),
                              ),
                              trailing: DMSanText(
                                text: transactions[index].transactionType ==
                                        'credit'
                                    ? '+N${transactions[index].amount}'
                                    : '-N${transactions[index].amount}',
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                textColor:
                                    transactions[index].transactionType ==
                                            'credit'
                                        ? Color(0xFF009E74)
                                        : Colors.black,
                              ),
                              subtitle: DMSanText(
                                text: DateFormat('MMM d').format(DateTime.parse(
                                    transactions[index].updatedAt)),
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                textColor: Color(0xFF7888A1),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class Transaction {
  final int id;
  final String amount;
  final String ref;
  final int ownerId;
  final String ownerType;
  final String status;
  final String transactionType;
  final String paymentType;
  final String prevBalance;
  final String currentBalance;
  final String fee;
  final int walletId;
  final bool valueGiven;
  final String appId;
  final int payerId;
  final String? appName;
  final String? businessName;
  final String serviceName;
  final String createdAt;
  final String updatedAt;

  Transaction({
    required this.id,
    required this.amount,
    required this.ref,
    required this.ownerId,
    required this.ownerType,
    required this.status,
    required this.transactionType,
    required this.paymentType,
    required this.prevBalance,
    required this.currentBalance,
    required this.fee,
    required this.walletId,
    required this.valueGiven,
    required this.appId,
    required this.payerId,
    this.appName,
    this.businessName,
    required this.serviceName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? 0,
      amount: json['amount'] ?? '0.00',
      ref: json['ref'] ?? '',
      ownerId: json['owner_id'] ?? 0,
      ownerType: json['owner_type'] ?? '',
      status: json['status'] ?? '',
      transactionType: json['transaction_type'] ?? '',
      paymentType: json['payment_type'] ?? '',
      prevBalance: json['prev_balance'] ?? '0.00',
      currentBalance: json['current_balance'] ?? '0.00',
      fee: json['fee'] ?? '0.00',
      walletId: json['wallet_id'] ?? 0,
      valueGiven: json['value_given'] ?? false,
      appId: json['app_id'] ?? '',
      payerId: json['payer_id'] ?? 0,
      appName: json['app_name'],
      businessName: json['business_name'],
      serviceName: json['service_name'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zeeh_mobile/common/components/app_snackbar.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';
import 'package:zeeh_mobile/feature/offers/view/loan/Macs/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeeh_mobile/feature/offers/view/loan/Macs/widgets/widgets.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';

class AllLoans extends StatefulWidget {
  const AllLoans({Key? key}) : super(key: key);

  @override
  State<AllLoans> createState() => _AllLoansState();
}

class _AllLoansState extends State<AllLoans> {
  late Future<ApiResponse> _loanData;
  dynamic userFirstName;
  dynamic token;

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) async {
       
        final String accessToken = AuthManager.instance.user?.token ?? '';
        debugPrint("Access Token is $accessToken");
        
        final prefs = await SharedPreferences.getInstance();
        final userData = prefs.getString('user_data');
        final userToken = prefs.getString('accesstk');

        if (userData != null) {
          final Map<String, dynamic> userMap = json.decode(userData);
          setState(() {
            userFirstName = userMap['first_name'] ?? '';
            token = userToken;
          });

          debugPrint(userFirstName);
          debugPrint("Token is $token");
        }
      },
    );
    _loanData = fetchLoanData();
  }

  final tk =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3YjUwOGIwLTE2MzktNDQwMi1hMWVjLTYzMTgxNmRhNzg1MSIsImlhdCI6MTcwNzI4ODAwOCwiZXhwIjoxNzA3MzA2MDA4fQ.2B39GBppbHzU_osMIDIb3kk6ZKPVcsxygN-uwCf3KVU";
  Future<void> makePostRequest() async {
    const String url = 'https://dev.api.usezeeh.com/api/offers/claimOffer';

    final String accessToken = AuthManager.instance.user?.token ?? '';
    

    Map<String, dynamic> requestBody = {
      "service": "64c2514d6389006c4deb735a",
      "offer": "Emergency Loan",
      "loanAmount": "10000",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $tk",
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('POST request successful!');
        print('Response: ${response.body}');
      } else {
        print(
            'Failed to make POST request. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Exception during POST request: $e');
    }
  }

  Future<ApiResponse> fetchLoanData() async {
    final String accessToken = AuthManager.instance.user?.token ?? '';
    debugPrint("Access Token is $accessToken");
    final response = await http.get(
      Uri.parse("https://dev.api.usezeeh.com/api/offers/"),
      headers: {
        'Authorization': "Bearer $tk",
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode == 200) {
      print('API Response: ${response.body}');
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      print('API Error: ${response.body}');
      throw Exception('Failed to load loan data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 1.0),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              title: GestureDetector(
                onTap: () {
                  makePostRequest();
                },
                child: Text(
                  "Loan Offers",
                  style: GoogleFonts.dmSans(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder<ApiResponse>(
          future: _loanData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingIndicatorWidget();
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData ||
                snapshot.data!.info.offers.isEmpty) {
              return Text('No loan offers available.');
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: snapshot.data!.info.offers.length,
                  itemBuilder: (context, index) {
                    var offer = snapshot.data!.info.offers[index];
                    return GestureDetector(
                      onTap: () {
                        AppSnackbar(context).showToast(
                          text: "Coming soon",
                        );
                      },
                      child: LoanCard(
                        imagePath: offer.image,
                        duration: offer.duration.toInt(),
                        interest: offer.interest,
                        minAmount: offer.loanAmount.minimum,
                        maxAmount: offer.loanAmount.maximum,
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

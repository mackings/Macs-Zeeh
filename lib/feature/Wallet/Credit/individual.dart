import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/components/textfield_box.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/Wallet/Credit/oldhistory.dart';
import 'package:zeeh_mobile/feature/Wallet/Credit/scorehistory.dart';
import 'package:zeeh_mobile/feature/Wallet/Credit/widgets.dart';
import 'package:zeeh_mobile/feature/Wallet/model/wallet.dart';
import 'package:zeeh_mobile/feature/credit/view/credit_report_page.dart';

class Individuals extends ConsumerStatefulWidget {
  const Individuals({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IndividualsState();
}

class _IndividualsState extends ConsumerState<Individuals> {
  TextEditingController bvn = TextEditingController();

  bool loading1 = false;
  bool loading2 = false;

  bool _downloading = false;
  bool _downloaded = false;

  bool _downloading2 = false;
  bool _downloaded2 = false;

  late final pw.Font _openSansFont;

  Map<String, dynamic>? alldata;
  Map<String, dynamic>? olddata;

  dynamic User_id;
  bool _apiCallCompleted = false;
  bool _apiCallCompleted2 = false;
  // Flag to track API call completion
  var selectedValue1;
  var selectedValue2;

  Future<void> loadFont() async {
    final fontData =
        await rootBundle.load('assets/fonts/DMSans_24pt-Regular.ttf');
    _openSansFont = pw.Font.ttf(fontData);
  }

  Future Fetchdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? walletResponseJson = prefs.getString('walletResponse');

    if (walletResponseJson == null) {
      print('Wallet data not found in SharedPreferences');
      return;
    }
    WalletResponse walletResponse =
        WalletResponse.fromJson(jsonDecode(walletResponseJson));
    var userid = walletResponse.data.usezeeh_user_id;
    setState(() {
      User_id = userid;
    });
    print(User_id);
  }

  Future<void> _downloadPdf() async {
    final font = await GoogleFonts.dmSans();
    final fonts = await PdfGoogleFonts.nunitoExtraLight();

    setState(() {
      _downloading = true;
    });

    var url = Uri.parse('https://v2.api.zeeh.africa/credit_reports/crc_basic');
    var payload = {"bvn": bvn.text, "mobile_app": true, "user_id": User_id};
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Secret_Key': 'pv_mxl58PLF5Rd3yZ8i61tbVNQFg',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];
      setState(() {
        alldata = data;
        _apiCallCompleted = true;
      });

      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text('CRC Credit History: ${data['name']}',
                  style: pw.TextStyle(font: fonts)),
            );
          },
        ),
      );

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/crc_credit_history.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      setState(() {
        _downloading = false;
        _downloaded = true;
      });
    } else {
      setState(() {
        _downloading = false;
        _downloaded = false;
      });
      print('Post request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 400 &&
          response.body.contains('In-sufficient fund!')) {
        setState(() {
          _downloaded = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ZeehColors.buttonPurple,
            content: Text('Insufficient funds! Please try again later.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> CheckOldhistory() async {
    setState(() {
      _downloading2 = true;
    });

    var url = Uri.parse(
        //'https://sandbox.api.zeeh.africa/credit_reports/one_history?plan=plan&id=${bvn.text}&mobile_app=true'
        'https://v2.api.zeeh.africa/credit_reports/one_history?id=${bvn.text}&mobile_app=true&plan=crc_basic');

    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Secret_Key': 'pv_mxl58PLF5Rd3yZ8i61tbVNQFg',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];

      setState(() {
        olddata = data;
        _apiCallCompleted2 = true;
      });

      setState(() {
        _downloading2 = false;
        _downloaded2 = true;
      });
      print(response.statusCode);
      print(data);

    } else if (response.statusCode == 400) {
      setState(() {
        _downloading2 = false;
        _downloaded2 = false;
      });
    } else {
      setState(() {
        _downloading2 = false;
        _downloaded2 = false;
      });
      print('Post request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  void initState() {
    loadFont();
    Fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: DMSanText(
          text: "For Individuals",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35.h),

              DMSanText(
                text: "Creadit bureau",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),

              SizedBox(height: 10.h),

              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: ZeehColors.greyColor),
                    borderRadius: BorderRadius.circular(8)),
                child: DropdownButtonFormField<String>(
                  items: const [
                    DropdownMenuItem(
                      value: "crc",
                      child: Text("CRC"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedValue1 = value;
                    });
                    print("Selected value: $selectedValue1");
                  },
                  decoration: const InputDecoration(
                    hintText: "CRC",
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  value: "crc",
                  isExpanded: true,
                ),
              ),

              SizedBox(height: 15.h),

              DMSanText(
                text: "Type of report",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),

              SizedBox(height: 10.h),

              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: ZeehColors.greyColor),
                    borderRadius: BorderRadius.circular(8)),
                child: DropdownButtonFormField<String>(
                  items: const [
                    DropdownMenuItem(
                      value: "old",
                      child: Text("Summary"),
                    ),
                    DropdownMenuItem(
                      value: "new",
                      child: Text("New report"),
                    ),
                  ],

                  onChanged: (value) {
                    setState(() {
                      selectedValue2 = value;
                    });
                    print("Selected value: $selectedValue2");
                  },

                  decoration: const InputDecoration(
                    hintText: "Select report type",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),

                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),

                    // Adjust padding
                  ),

                  value: "old",

                  isExpanded: true, // Allow the dropdown to expand horizontally
                ),
              ),

              SizedBox(height: 15.h),
              DMSanText(
                text: "BVN",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 10.h),
              TextFieldBox(
                controller: bvn,
                hintText: "Enter your BVN",
              ),
              SizedBox(height: 300.h),

GestureDetector(
  onTap: () async {
    if (selectedValue2 == "old") {
      if (_downloaded2 && olddata != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OldHistory(scoreData: olddata!),
          ),
        );
      } else {
        try {
          await CheckOldhistory();
          if (_downloaded2 && olddata != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OldHistory(scoreData: olddata!),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: ZeehColors.buttonPurple,
                content: Text(
                  'Failed to fetch data. Please try again later.'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ZeehColors.buttonPurple,
              content: Text(
                'Failed to fetch data. Please try again later.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } else if (selectedValue2 == "new") {
      await _downloadPdf(); 
      if (_downloaded) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScoreHistory(scoreData: alldata!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ZeehColors.buttonPurple,
            content: Text(
              'Failed to fetch data. Please try again later.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  },
  child: (_downloading2 || _downloading)
    ? Center(
        child: LoadingIndicatorWidget(
          color: ZeehColors.buttonPurple,
          height: 20.h,
          width: 20.w,
        ),
      )
    : Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: 45.h,
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            color: ZeehColors.buttonPurple,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: _downloaded2
              ? DMSanText(
                  text: "Preview",
                  textColor: Colors.white,
                )
              : DMSanText(
                  text: "Generate report",
                  textColor: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
),



              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}

class ApiDataContainer extends StatelessWidget {
  final Map<String, dynamic> data;

  const ApiDataContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final score = data['score'];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScoreHistory(scoreData: score),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            if (data['name'] != null) DMSanText(text: 'Name: ${data['name']}'),
            if (score != null) ...[
              DMSanText(
                  text: 'Last Reported Date: ${score['lastReportedDate']}'),
              DMSanText(text: 'Total No of Loans: ${score['totalNoOfLoans']}'),
            ],
          ],
        ),
      ),
    );
  }
}

class ZeehButton2 extends StatelessWidget {
  final String text;
  final VoidCallback? onClick;
  final bool loading;

  const ZeehButton2({
    Key? key,
    required this.text,
    this.onClick,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ZeehColors.buttonPurple, // Change the color as needed
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClick,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (loading)
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  else
                    SizedBox.shrink(),
                  if (loading) // Add some space between the indicator and text
                    SizedBox(width: 8),
                  Center(
                      child: DMSanText(
                    text: text,
                    textColor: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ZeehButton3 extends StatelessWidget {
  final String text;
  final VoidCallback? onClick;
  final bool loading;

  const ZeehButton3({
    Key? key,
    required this.text,
    this.onClick,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5, color: ZeehColors.buttonPurple),
        // color: ZeehColors.buttonPurple, // Change the color as needed
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClick,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (loading)
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ZeehColors.buttonPurple),
                      ),
                    )
                  else
                    SizedBox.shrink(),
                  if (loading) // Add some space between the indicator and text
                    SizedBox(width: 8),
                  Center(
                      child: DMSanText(
                    text: text,
                    textColor: ZeehColors.buttonPurple,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

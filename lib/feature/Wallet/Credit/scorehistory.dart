import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreHistory extends ConsumerWidget {
  final Map<String, dynamic> scoreData;
  const ScoreHistory({Key? key, required this.scoreData}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime parsedDate = DateTime.parse(scoreData['searchedDate']);
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: DMSanText(
          text: "CRC Credit history",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.5, color: ZeehColors.greyColor)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      DMSanText(text: "Credit history data",
                      fontWeight: FontWeight.w500,),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRow(
                        title1: 'BVN',
                        subtitle1: '${scoreData['bvn']}',
                        title2: "Customer ID",
                        subtitle2: "${scoreData['customerId']}"),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRow(
                        title1: 'Business ID',
                        subtitle1: '${scoreData['businessId']}',
                        title2: "",
                        subtitle2: ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRow(
                        title1: 'Name',
                        subtitle1: '${scoreData['name']}',
                        title2: "Gender",
                        subtitle2: "${scoreData['gender']}"),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRow(
                        title1: 'Date of birth',
                        subtitle1: '${scoreData['dateOfBirth']}',
                        title2: "Phone number",
                        subtitle2: "${scoreData['phone']}"),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRow(
                        title1: 'Address',
                        subtitle1: '${scoreData['address']}',
                        title2: "",
                        subtitle2: ""),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRow(
                        title1: 'Search date',
                        subtitle1: formattedDate,
                        title2: "",
                        subtitle2: ""),
                  ),
            //totalNoOfDelinquentFacilities
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRow(
                        title1: 'Total No of Delinquent Facilities',
                        subtitle1:
                            '${scoreData['score']['totalNoOfDelinquentFacilities']}',
                        title2: "",
                        subtitle2: ""),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRow(
                        title1: 'Last Reported Date',
                        subtitle1: '${scoreData['score']['lastReportedDate']}',
                        title2: "Total No of Loans",
                        subtitle2: "${scoreData['score']['totalNoOfLoans']}"),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRow(
                        title1: 'Total No of Institutions',
                        subtitle1:
                            '${scoreData['score']['totalNoOfInstitutions']}',
                        title2: "Total No of Active loans",
                        subtitle2:
                            "${scoreData['score']['totalNoOfActiveLoans']}"),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRow(
                        title1: 'Total Borrowed',
                        subtitle1: '${scoreData['score']['totalBorrowed']}',
                        title2: "Total Outstanding",
                        subtitle2: "${scoreData['score']['totalOutstanding']}"),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRow(
                        title1: 'Total Overdue',
                        subtitle1: '${scoreData['score']['totalBorrowed']}',
                        title2: "Max No of days",
                        subtitle2: "${scoreData['score']['maxNoOfDays']}"),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRow(
                        title1: 'Total No of Closed Loans',
                        subtitle1:
                            '${scoreData['score']['totalNoOfClosedLoans']}',
                        title2: "Crc Report order No",
                        subtitle2:
                            "${scoreData['score']['crcReportOrderNumber']}"),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final String title1;
  final String subtitle1;
  final String title2;
  final String subtitle2;

  const CustomRow({
    required this.title1,
    required this.subtitle1,
    required this.title2,
    required this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: DMSanText(
                  text: title1,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF5F6D7E),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: DMSanText(
                  text: subtitle1,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 19.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: DMSanText(
                  text: title2,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF5F6D7E),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: DMSanText(
                  text: subtitle2,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}





      // Container(
      //   padding: EdgeInsets.all(20),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'Name: ${scoreData['name']}',
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //       ),
      //       SizedBox(height: 10),
      //       Text(
      //         'Last Reported Date: ${scoreData['lastReportedDate']}',
      //         style: TextStyle(fontSize: 16),
      //       ),
      //       Text(
      //         'Total No of Loans: ${scoreData['totalNoOfLoans']}',
      //         style: TextStyle(fontSize: 16),
      //       ),
      //       // Add more score data fields as needed
      //     ],
      //   ),
      // ),

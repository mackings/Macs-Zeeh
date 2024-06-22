import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OldHistory extends ConsumerWidget {
  final Map<String, dynamic> scoreData;

  const OldHistory({Key? key, required this.scoreData}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

   // Safely extract values from scoreData with default values
    String bvn = scoreData['data']['bvn']?.toString() ?? 'N/A';
    String customerId = scoreData['data']['customerId']?.toString() ?? 'N/A';
    String businessId = scoreData['data']['businessId']?.toString() ?? 'N/A';
    String name = scoreData['data']['name']?.toString() ?? 'N/A';
    String gender = scoreData['data']['gender']?.toString() ?? 'N/A';
    String dateOfBirth = scoreData['data']['dateOfBirth']?.toString() ?? 'N/A';
    String address = scoreData['data']['address']?.toString() ?? 'N/A';
    String searchedDate = scoreData['data']['searchedDate']?.toString() ?? 'N/A';
    Map<String, dynamic> score = scoreData['data']['score'] ?? {};

    // Safely extract values from score map with default values
    String totalNoOfDelinquentFacilities = score['totalNoOfDelinquentFacilities']?.toString() ?? 'N/A';
    String lastReportedDate = score['lastReportedDate']?.toString() ?? 'N/A';
    String totalNoOfLoans = score['totalNoOfLoans']?.toString() ?? 'N/A';
    String totalNoOfInstitutions = score['totalNoOfInstitutions']?.toString() ?? 'N/A';
    String totalNoOfActiveLoans = score['totalNoOfActiveLoans']?.toString() ?? 'N/A';
    String totalBorrowed = score['totalBorrowed']?.toString() ?? 'N/A';
    String totalOutstanding = score['totalOutstanding']?.toString() ?? 'N/A';
    String totalOverdue = score['totalOverdue']?.toString() ?? 'N/A';
    String maxNoOfDays = score['maxNoOfDays']?.toString() ?? 'N/A';
    String totalNoOfClosedLoans = score['totalNoOfClosedLoans']?.toString() ?? 'N/A';
    String crcReportOrderNumber = score['crcReportOrderNumber']?.toString() ?? 'N/A';


    print(scoreData);

    return scoreData.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
      appBar: AppBar(
        title: Text('CRC Credit history'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5,color: ZeehColors.greyColor)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [

                Row(
                  children: [
                    DMSanText( 
                      text: "Credit history data",
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRow(
                    title1: 'BVN',
                    subtitle1: bvn,
                    title2: "Customer ID",
                    subtitle2: customerId,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRow(
                    title1: 'Business ID',
                    subtitle1: businessId,
                    title2: "",
                    subtitle2: "",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRow(
                    title1: 'Name',
                    subtitle1: name,
                    title2: "Gender",
                    subtitle2: gender,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRow(
                    title1: 'Date of birth',
                    subtitle1: dateOfBirth,
                    title2: "Phone number",
                    subtitle2: 'N/A', 
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRow(
                    title1: 'Address',
                    subtitle1: address =="null"? "N/A":address,
                    title2: "",
                    subtitle2: "",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRow(
                    title1: 'Search date',
                    subtitle1: searchedDate,
                    title2: "",
                    subtitle2: "",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRow(
                    title1: 'No of Delinquent Facilities',
                    subtitle1: totalNoOfDelinquentFacilities,
                    title2: "",
                    subtitle2: "",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRow(
                    title1: 'Last Reported Date',
                    subtitle1: lastReportedDate,
                    title2: "Total No of Loans",
                    subtitle2: totalNoOfLoans,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRow(
                    title1: 'Total Institutions',
                    subtitle1: totalNoOfInstitutions,
                    title2: "Total Active loans",
                    subtitle2: totalNoOfActiveLoans,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRow(
                    title1: 'Total Borrowed',
                    subtitle1: 'N${totalBorrowed}',
                    title2: "Total Outstanding",
                    subtitle2: totalOutstanding,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRow(
                    title1: 'Total Overdue',
                    subtitle1: totalOverdue,
                    title2: "Max No of days",
                    subtitle2: maxNoOfDays,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRow(
                    title1: 'Total No of Closed Loans',
                    subtitle1: totalNoOfClosedLoans,
                    title2: "Crc Report order No",
                    subtitle2: crcReportOrderNumber,
                  ),
                ),
              ],
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

  CustomRow({
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title1,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(subtitle1),
          ],
        ),
        if (title2.isNotEmpty && subtitle2.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(subtitle2),
            ],
          ),
      ],
    );
  }
}




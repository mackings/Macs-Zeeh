import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/currency_function.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/feature/home/view/service_offer/loan/loan_payment_amount.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget.dart';

import '../../../../common/components/button.dart';
import '../../../../common/utils/navigator.dart';
import '../../../../constants/colors.dart';
import '../../../auth/data/state/auth_notifier.dart';
import '../../../auth/model/auth/authenticated_user.dart';
import '../../../profile/data/state/profile_state_notifier.dart';
import '../../../profile/model/user_details.dart';
import '../../../provider.dart';

class PaybackLoanPage extends ConsumerStatefulWidget {
  const PaybackLoanPage({super.key});

  @override
  ConsumerState createState() => _PaybackLoanPageState();
}

class _PaybackLoanPageState extends ConsumerState<PaybackLoanPage> {
  UserDetails userDetails = UserDetails();

  AuthenticatedUser authUser = AuthenticatedUser();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);

    if (authState is LogInSuccessState) {
      authUser = authState.user.user!;
    }

    final userDetailsState = ref.watch(profileStateNotifierProvider);

    if (userDetailsState is UserDetailsSuccess) {
      userDetails = userDetailsState.userDetails;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: 812.h,
        width: 375.w,
        child: Column(
          children: [
            HomeHeaderWidget(
              userImage: userDetails.imageUrl ?? "",
              userName: "${userDetails.firstName ?? ""} "
                  "${userDetails.lastName ?? ""}",
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: ZeehColors.greyColor,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              width: 343.w,
              child: Column(
                children: [
                  const GroteskText(
                    text: 'Loan Payment',
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 23.h),
                  const GroteskText(
                    text: 'NEXT PAYMENT DATE',
                    textColor: ZeehColors.grayColor,
                  ),
                  SizedBox(height: 4.h),
                  GroteskText(
                    text: '17th July, 2023',
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                  SizedBox(height: 16.h),
                  const GroteskText(
                    text: 'AMOUNT DUE',
                    textColor: ZeehColors.grayColor,
                  ),
                  SizedBox(height: 4.h),
                  SpaceGroteskText(
                    text: '₦ ${amountFormatter(5000)}',
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                  SizedBox(height: 16.h),
                  GroteskText(
                    text: 'Date of last payment:  01:35 PM, 19-05-2023',
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GroteskText(
                        text: 'Check loan details',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        textColor: ZeehColors.buttonPurple,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: Icon(
                          Icons.arrow_right_alt_outlined,
                          color: ZeehColors.buttonPurple,
                          size: 26.h,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.h, bottom: 12.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const GroteskText(
                              text: 'Loan History',
                              fontWeight: FontWeight.w500,
                            ),
                            GroteskText(
                              text: 'View your payment history',
                              textColor: ZeehColors.grayColor,
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(thickness: 1, color: ZeehColors.greyColor),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 56.w),
                            child: GroteskText(
                              text: 'Payment Date',
                              fontSize: 12.sp,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: GroteskText(
                              text: 'Amount due',
                              fontSize: 12.sp,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 41.w),
                            child: GroteskText(
                              text: 'Status',
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    const LoanHistoryTile(
                      index: 1,
                      date: '17/07/23',
                      amount: 5000,
                      status: false,
                    ),
                    const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    const LoanHistoryTile(
                      index: 2,
                      date: '17/06/23',
                      amount: 5000,
                      status: true,
                    ),
                    const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    const LoanHistoryTile(
                      index: 3,
                      date: '17/06/23',
                      amount: 5000,
                      status: true,
                    ),
                  ],
                ),
              ),
            ),
            // Send Message
            SizedBox(height: 16.h),

            Container(
              color: Colors.white,
              height: 100.h,
              width: double.infinity,
              child: Center(
                child: ZeehButton(
                  onClick: () => navigate(context, const LoanPaymentAmount()),
                  text: "Pay Now",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoanHistoryTile extends StatelessWidget {
  const LoanHistoryTile({
    Key? key,
    required this.index,
    required this.date,
    required this.amount,
    required this.status,
    this.onTap,
  }) : super(key: key);

  final int index;
  final String date;
  final double amount;
  final bool status;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 40.h,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: GroteskText(
                text: index.toString(),
                fontSize: 13.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 41.w),
              child: GroteskText(
                text: date,
                fontSize: 13.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.w),
              child: SpaceGroteskText(
                text: '₦ ${amountFormatter(amount)}',
                fontSize: 13.sp, //₦5,000
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 47.w),
              child: StatusChip(paid: status),
            )
          ],
        ),
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  const StatusChip({Key? key, required this.paid}) : super(key: key);

  final bool paid;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: paid ? const Color(0xffE8F4E7) : const Color(0xffFDE8E8),
      ),
      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
      child: GroteskText(
        text: paid ? 'paid' : 'Not paid',
        fontSize: 12.sp,
        textColor: paid ? const Color(0xff1D8D13) : const Color(0xffEF1515),
      ),
    );
  }
}

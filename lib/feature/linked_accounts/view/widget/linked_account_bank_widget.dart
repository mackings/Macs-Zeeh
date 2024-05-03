import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/home/view/home_screen.dart';
import 'package:zeeh_mobile/feature/linked_accounts/data/state/linked_account_state_notifier.dart';
import 'package:zeeh_mobile/feature/linked_accounts/model/linked_account_model.dart';
import 'package:zeeh_mobile/feature/profile/view/widget/success_page_dialog.dart';
import 'package:zeeh_mobile/feature/provider.dart';

class LinkedAccountBankWidget extends ConsumerStatefulWidget {
  const LinkedAccountBankWidget({
    super.key,
    required this.linkedAccount,
    required this.index,
  });

  final LinkedAccountModel linkedAccount;
  final int index;

  @override
  ConsumerState<LinkedAccountBankWidget> createState() =>
      _LinkedAccountBankWidgetState();
}

class _LinkedAccountBankWidgetState
    extends ConsumerState<LinkedAccountBankWidget> {
  handleUnlinkBank(WidgetRef ref) {
    ref
        .read(unlinkAccountStateNotifierProvider.notifier)
        .unlinkBank(widget.linkedAccount.banks![widget.index].id!);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      unlinkAccountStateNotifierProvider,
      (previous, next) {
        if (next is UnlinkBankSuccess) {
          pushUntil(context, const HomeScreen());
        }
      },
    );

    return Row(
      children: [
        SizedBox(width: 10.w),
        Image.network(
          widget.linkedAccount.banks![widget.index].bankLogo!,
          height: 32.h,
          width: 32.w,
        ),
        SizedBox(width: 16.w),
        GroteskText(
          text: widget.linkedAccount.banks![widget.index].bankName!,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        const Spacer(),
        InkWell(
          onTap: () => showCustomModalBottomSheet(
            context,
            child: SuccessPageDialog(
              headerText: 'Disconnect',
              bodyText: 'Are you sure you want to disconnect '
                  '${widget.linkedAccount.banks![widget.index].bankName} bank account from '
                  'UseZeeh',
              imagePath: ZeehAssets.failureSvgIcon,
              twoButtons: true,
              yesClick: () {
                handleUnlinkBank(ref);
              },
              noClick: () {
                popView(context);
              },
            ),
          ),
          child: Container(
            height: 31.h,
            width: 90.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffD7D7D7),
              ),
            ),
            child: Center(
              child: GroteskText(
                text: "Disconnect",
                fontSize: 12.sp,
                textColor: ZeehColors.buttonPurple,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
      ],
    );
  }
}

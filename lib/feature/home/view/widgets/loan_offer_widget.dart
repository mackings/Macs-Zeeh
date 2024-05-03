import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';

class LoanOfferWidget extends StatelessWidget {
  const LoanOfferWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Stack(
            children: [
              Container(
                width: 197.w,
                height: 92.h,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(ZeehAssets.fairmoneyIcon),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                ),
              ),
              Positioned(
                left: 150,
                top: 12.h,
                child: Container(
                  height: 14.h,
                  width: 41.w,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: ShapeDecoration(
                    color: const Color(0x191F9F14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DMSanText(
                        text: 'Eligible',
                        textColor: Color(0xFF1F9F14),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 185.w,
          height: 80.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFEBEBEB),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
            ),
          ),
          padding: EdgeInsets.only(left: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              SpaceGroteskText(
                text: '₦10,000-₦55,000',
                textColor: const Color(0xFF101828),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              const DMSanText(
                text: '6 months term',
                textColor: Color(0xFF5F6D7E),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const DMSanText(
                text: '0.4% interest rate',
                textColor: Color(0xFF5F6D7E),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

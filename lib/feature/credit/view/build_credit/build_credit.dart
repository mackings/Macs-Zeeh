import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/credit/view/build_credit/article_screen.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';

class BuildCreditScreen extends StatefulWidget {
  const BuildCreditScreen({super.key});

  @override
  State<BuildCreditScreen> createState() => _BuildCreditScreenState();
}

class _BuildCreditScreenState extends State<BuildCreditScreen> {
  int selectedChipIndex = 0;
  final chipItems = ['For you', 'Credit Score', 'Investment', 'Finance'];

  onSelectableChipTap(int index) {
    setState(() {
      if (selectedChipIndex != index) {
        selectedChipIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: 375.w,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeaderWidgetTwo(title: "Articles"),
              Container(
                color: ZeehColors.scaffoldBackground,
                height: 16.h,
              ),
              SizedBox(
                height: 187.h,
                child: Stack(
                  children: [
                    SizedBox(
                      width: 375.w,
                      child: Image.asset(
                        ZeehAssets.stock,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox.square(
                                dimension: 12.r,
                                child: Image.asset(ZeehAssets.sampleImage14),
                              ),
                              SizedBox(width: 10.w),
                              DMSanText(
                                text: 'ZeeH Africa',
                                textColor: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                              SizedBox(width: 10.w),
                              // GroteskText(
                              //   text: 'Aug. 04 | 2 min read',
                              //   textColor: Colors.white,
                              //   fontSize: 10.sp,
                              // )
                            ],
                          ),
                          SizedBox(height: 8.h),
                          DMSanText(
                            text: 'The Future of Credit Score',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: DMSanText(
                  text: 'Recommended Articles',
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                height: 45.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: chipItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: 8.w,
                        left: index == 0 ? 24.w : 0,
                      ),
                      child: SelectableChip(
                        isSelected: selectedChipIndex == index,
                        label: chipItems[index],
                        onTap: () => onSelectableChipTap(index),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 4.h),

              //  const  EmptyStateWidget(
              //     description: "No Articles Yet",
              //   ),

              /// Articles
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RecommendedArticleTile(
                      imagePath: ZeehAssets.creditImage1,
                      title: 'Financial Literacy Explained',
                      onTap: () => navigate(
                        context,
                        const ArticleScreen(
                          selectedArticle: 1,
                        ),
                      ),
                    ),
                    const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    RecommendedArticleTile(
                      imagePath: ZeehAssets.creditImage2,
                      title: 'FICO Explained Simply',
                      onTap: () => navigate(
                        context,
                        const ArticleScreen(
                          selectedArticle: 2,
                        ),
                      ),
                    ),
                    const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    RecommendedArticleTile(
                      imagePath: ZeehAssets.creditImage3,
                      title: 'Benefits of a Good Credit Score',
                      onTap: () {
                        navigate(
                          context,
                          const ArticleScreen(
                            selectedArticle: 3,
                          ),
                        );
                      },
                    ),
                    const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    RecommendedArticleTile(
                      imagePath: ZeehAssets.creditImage4,
                      title: 'How Does Budgeting Improve Your Credit Score?',
                      onTap: () {
                        navigate(
                          context,
                          const ArticleScreen(
                            selectedArticle: 4,
                          ),
                        );
                      },
                    ),
                    const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                    SizedBox(height: 35.h),
                    // RecommendedArticleTile(
                    //   imagePath: ZeehAssets.creditImage5,
                    //   title: 'Improving your credit score',
                    //   onTap: () {},
                    // ),
                    // const Divider(thickness: 1, color: Color(0xffD7D7D7)),
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

class RecommendedArticleTile extends StatelessWidget {
  const RecommendedArticleTile({
    super.key,
    required this.imagePath,
    required this.title,
    this.onTap,
  });

  final String imagePath;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox.square(
              dimension: 75.r,
              child: Image.asset(imagePath),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox.square(
                      dimension: 18.r,
                      child: Image.asset(ZeehAssets.sampleImage14),
                    ),
                    SizedBox(width: 8.w),
                    DMSanText(
                      text: 'ZeeH Africa',
                      fontSize: 11.sp,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                  child: DMSanText(
                    text: title,
                    maxLines: 2,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                DMSanText(
                  text: 'Aug. 18 | 2 min read',
                  fontSize: 12.sp,
                  textColor: ZeehColors.grayColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SelectableChip extends StatelessWidget {
  final bool isSelected;
  final String label;
  final VoidCallback onTap;

  const SelectableChip({
    super.key,
    required this.isSelected,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
        backgroundColor:
            isSelected ? ZeehColors.buttonPurple : const Color(0xffEAECEF),
        label: GroteskText(
          text: label,
          textColor: isSelected ? Colors.white : ZeehColors.grayColor,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

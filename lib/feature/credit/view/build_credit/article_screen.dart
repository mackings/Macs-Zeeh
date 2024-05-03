import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/components/text_widget.dart';
import '../../../../constants/asset_paths.dart';
import '../../../../constants/colors.dart';
import '../../../home/view/widgets/home_header_widget_two.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({
    super.key,
    required this.selectedArticle,
  });

  final int selectedArticle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: 375.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeaderWidgetTwo(title: "Article"),
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
                      selectedArticle == 1
                          ? ZeehAssets.creditImage1
                          : selectedArticle == 2
                              ? ZeehAssets.creditImage2
                              : selectedArticle == 3
                                  ? ZeehAssets.creditImage3
                                  : ZeehAssets.creditImage4,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DMSanText(
                        text: selectedArticle == 1
                            ? articleTitle[0]
                            : selectedArticle == 2
                                ? articleTitle[1]
                                : selectedArticle == 3
                                    ? articleTitle[2]
                                    : articleTitle[3],
                        maxLines: 2,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          SizedBox.square(
                            dimension: 20.r,
                            child: Image.asset(ZeehAssets.sampleImage14),
                          ),
                          SizedBox(width: 8.w),
                          DMSanText(
                            text: 'ZeeH Africa',
                            fontSize: 12.sp,
                          ),
                          SizedBox(width: 10.w),
                          DMSanText(
                            text: 'Aug. 18 | 2 min read',
                            fontSize: 12.sp,
                            textColor: ZeehColors.grayColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        child: SingleChildScrollView(
                          child: DMSanText(
                            text: selectedArticle == 1
                                ? articleBody[0]
                                : selectedArticle == 2
                                    ? articleBody[1]
                                    : selectedArticle == 3
                                        ? articleBody[2]
                                        : articleBody[3],
                            maxLines: 200,
                            fontSize: 14.sp,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

final List articleTitle = [
  "Financial Literacy",
  "FICO Explained Simply",
  "Benefits of a Good Credit Score",
  "How Does Budgeting Improve Your Credit Score?",
];

final List articleBody = [
  /// 1
  '''
   

Ade is a civil servant with three children; like every other average civil servant, Ade earns an average of 81 000, and in the year, he earns 972,000 per annum. 

He has to pay for his kid's school fees, feed them, take off their emergency needs like health care, and take care of rent. The responsibilities occasionally lead Ade to collect loans because the money he earns might sometimes need to be enough.

Ade is indebted and in severe lack; Ade begins to think about where he went wrong in all these; Ade concludes he is not just a lucky fellow. The problem is not the loan, which, when collected right, is a good advantage, or the size of his earning, which can be scaled. The real problem is Ade is financially illiterate.

What is financial literacy?  
Financial literacy refers to the logical knowledge of economic principles and abilities, such as budgeting, investing, and borrowing, paying taxes, and managing one's finances. Being financially illiterate means lacking these abilities.

Effective money management is also made possible through financial education. It gives one the information and abilities required to make a budget, handle debt, and put money aside for the future. The development of sound financial practices and the avoidance of debt traps are made possible by financial literacy.

Budgeting
Making sensible financial decisions requires creating a budget. Spending, investing, saving, and lending are the four primary ways you might use your money.
By striking the correct balance between these purposes, you may better manage your finances, feel comfortable financially, and have a brighter future.

A sound budget should assist you in eliminating any debts you may have, allocating funds for savings, and making wise investments that will pay off in the long run.

Investing
You must be aware of several crucial investing concepts to be financially savvy. These include stock market indices, interest rates, price ranges, diversification (spreading your investments), and lowering risks.
Understanding these essential elements of investing can help you manage your finances more effectively, which might result in more money arriving in the future.

Borrowing
Most people will, at some time in their lives, need to borrow money. You need to understand interest rates, compound interest (adding interest to interest), the time value of money (how the value of money varies over time), payment intervals (when you must return), and loan structure (how the loan is set up) to accomplish it properly.
Your financial literacy will increase due to learning these things, enabling you to make informed borrowing decisions and stay out of long-term debt situations.

Taxation
Financial literacy requires understanding the many tax kinds and how they influence the amount of money you spend. Different tax rates may apply to income from work, investments, rent, inheritance, or other sources.
Understanding these income tax rates may improve your money management, stabilize you financially, and improve your overall financial well-being.

Financial Management for Individuals
Combining all the elements mentioned above is the key to effective money management.
You can stabilize your finances, build your savings and investments, and pay off debt by balancing spending, saving, investing, and borrowing.

By learning about these financial topics, you may improve your financial literacy and ability to handle your money correctly.	


   ''',
  '''
   FICO EXPLAINED SIMPLY
Let's return to our friend Ade; Ade finally decides to open a business for his wife. 
Ade chooses to get a loan, and the bank asks for his Fico score. Ade tries to check 
his credit score; using a trusted organization to calculate the credit score is always 
good.

Ade uses Zeeh Africa to check his credit score; unfortunately, his credit score is 
low. Ade's dream feels truncated, and he is desolate.

Ade reaches out to Zeeh, and they tell him it just takes a strategic habit for a credit 
score to be increased.

Now what is a Fico score? The score you get in an exam shows how well you know a
subject. Similarly, a fico score is a customized metric that tells your lender how 
good you are with money which determines your likelihood of paying back the 
money. The Fico score is from 300 to 850, the higher it is the better your credit 
worthiness. For you to be good with money and increase your credit score comes 
down to financial literacy.

What was Ade doing wrong?
Ade doesn't pay his loans on time: As difficult as it can be, paying your loan on 
time and keeping to your financial obligations help increase your fico score. So 
when we take loans, we should ensure we pay it back on time so it doesn't affect 
our fico score.

Ade doesn't save: Ade talks about how little his earning is compared to his 
expenditure, so he doesn't save. No matter how little, putting money aside in your 
savings or investments indicates you are better at handling money, hence 
increasing your FICO score.

Ade's spending Habit: A look at Ade's transaction history, we see the things Ade 
spends his money on does not show he is wise with his spending. He occasionally 
gambles, buys drinks in the bar, and does things that doesn’t directly increase his 
earnings. Spending on something that makes you happy is not a bad thing but it 
should be balanced out with wiser and more strategic spending.

Like Ade, your credit score will likely increase if you stick to the above advice.
The next piece: the benefit of a credit score.

(I want to include this at the end of every article) Zeeh Africa is committed to 
creating a platform where people have better access to loans and proper financial 
   ''',
  '''

    Whether you're someone who might need a loan or someone who might never have such a need, understanding why a credit score matters is essential, a good credit score isn't just a number; it's a reflection of your strong financial habits. In fact, having a good credit score signifies robust financial health. So, whether you're considering a loan or not, let's explore the benefits of a good credit score.


1. Negotiation Leverage: A high credit score empowers you when dealing with creditors, lenders, and financial institutions. It gives you an upper hand in negotiating loan terms and other financial arrangements, putting you in a favorable position.

2. Credit Card Opportunities: A solid credit score enhances your chances of being approved for credit cards that offer enticing rewards, bonuses, and favorable annual fees. You'll likely qualify for higher credit limits, which can be a valuable asset.

3. Unlocking Financial Opportunities: A strong credit score opens the door to various financial opportunities. These opportunities could range from securing business loans to obtaining financing for significant expenses or even embarking on your entrepreneurial journey.

4. Access to Credit and Loans: Lenders evaluate your credit score to gauge your likelihood of repaying loans, whether for a car, a home, or other necessities. A higher credit score often translates to better loan terms, lower interest rates, and more substantial borrowing limits. Consequently, you can access the funds you need without being burdened by excessive interest charges.

5. Lower Interest Rates: A high credit score signals to lenders that you're a reliable borrower, prompting them to extend loans at lower interest rates. This practice can result in significant savings over time, as interest costs can accumulate rapidly.

6. Achieving Financial Goals: Cultivating good financial habits simplifies the process of setting and achieving financial objectives. Whether you're saving for a dream vacation, a home, or retirement, having disciplined financial behaviors lays the foundation for realizing these goals.

A good credit score isn't merely about borrowing money—it's a testament to your responsible money management. It positions you favorably in financial negotiations, grants access to attractive credit card offers, and opens up financial possibilities. Moreover, it allows you to secure loans on better terms and save on interest expenses. Developing solid financial habits ultimately empowers you to pursue your financial aspirations confidently.

Zeeh Africa is dedicated to creating a platform that makes it easier for individuals and businesses to get loans, enhance credit scores, and promote financial knowledge."

  ''',
  '''
   Budgeting is about planning your income or money to make the most of it. By budgeting, you can use your money wisely and ensure you have enough for what you need without running out too quickly.

But how does budgeting actually help your credit score? Well, your credit score is based on how you've spent your money in the past and how well you've managed your available funds. When you budget well, it directly links to building a good credit score.

So, How Do You Make a Budget?

1. Know Your Money: It's important to understand how much money you have. This includes your salary, gifts of money, allowances, and any loans – basically, any cash you start with for a certain period.

2. Know What You Need: Figuring out what you truly need versus what you want, identifying debts to pay, and setting aside savings are vital when creating a budget. Writing this down helps you see the big picture and prioritize what's important.

3. Make a Plan: Create a plan by dividing your income to cover the things on your list. Be practical and think about both your current needs and any future expenses. It's a good idea to set a timeline for achieving your financial goals.

4. The Challenge: The tough part is sticking to your budget. Adhering to it is a big step towards better credit health. Before spending any money, check if it fits within your budget. Even small expenses matter because they add up.

5. Keep Track: Unexpected expenses can pop up, and it's essential to track your spending. You can do this daily, weekly, or monthly – whatever suits you. Treat your credit score like an exam. Similar to following a study plan to perform well, monitoring your spending through a budget plan impacts your credit score.

Why Should You Budget?

Budgeting isn't just about being smart with money. It means taking control and deciding how to use your money.

- Freedom: Budgeting lets you buy what you want and plan for your goals financially.
- Life Skill: Managing money is a skill, much like swimming, that's important no matter your age. Budgeting helps avoid overspending and financial troubles.

- Saving and Investment: A budget helps you find opportunities to save and invest. When you see where your money goes, you can plug leaks and allocate funds for savings and investments.

- Growth: Budgeting improves your credit history, making you more creditworthy and boosting your credit score. It sets you up for better loan opportunities and shows you're responsible with money.

Starting budgeting early is crucial, and now is a great time. Budgeting helps you achieve what you want while preparing for anything that might come your way.



Zeeh Africa is dedicated to creating a platform that makes it easier for individuals and businesses to get loans, enhance credit scores, and promote financial knowledge."

   ''',
];

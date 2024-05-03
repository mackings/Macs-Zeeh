import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/Wallet/Credit/credithome.dart';
import 'package:zeeh_mobile/feature/Wallet/Transactions/history.dart';
import 'package:zeeh_mobile/feature/Wallet/home/Home.dart';
import 'package:zeeh_mobile/feature/credit/view/credit_screen.dart';
import 'package:zeeh_mobile/feature/home/view/home_page.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/bottom_app_bar.dart';
import 'package:zeeh_mobile/feature/linked_accounts/view/linked_account.dart';
import 'package:zeeh_mobile/feature/offers/view/offer_screen.dart';
import 'package:zeeh_mobile/feature/profile/view/profile_screen.dart';
import 'package:zeeh_mobile/feature/provider.dart';



class HomeManager extends ConsumerStatefulWidget {
  const HomeManager({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeManagerState();
}

class _HomeManagerState extends ConsumerState<HomeManager> {

int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(profileStateNotifierProvider.notifier).userDetails();

        ref.read(activitiesStateNotifierProvider.notifier).userActivities();

        ref.read(creditStateNotifierProvider.notifier).getCreditScore();

        ref.read(linkedAccountStateNotifierProvider.notifier).allBanks();

        ref.read(offerStateNotifierProvider.notifier).getServiceType();

        ref.read(activeOfferStateNotifierProvider.notifier).activeOffers();
      },
    );
  }

  late List<Widget> tabOptions = [
    const Wallethome(),
    const Credithome(),
    const Transhistory(),
    // const HomePage(),
   // CreditScreen(action: _updateIndex),
    // const OfferScreen(
    //   showBackButton: false,
    // ),
    // const LinkedAccount(),
    const ProfileScreen(),
  ];

  void _updateIndex() {
    setState(() {
      selectedIndex = 3;
    });
  }

  void _selectedTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        
        body: SizedBox(
          child: tabOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: CustomBottomAppBar(
          onTabSelected: _selectedTab,
          color: ZeehColors.greyColor,
          selectedColor: ZeehColors.buttonPurple,
          items: [
            CustomBottomAppBarItem(
              ZeehAssets.homeIcon,
              'Home',
            ),
            CustomBottomAppBarItem(
              ZeehAssets.credithomeicon,
              'Credit Insight',
            ),
            CustomBottomAppBarItem(
              ZeehAssets.transicon,
              'Transactions',
            ),
            CustomBottomAppBarItem(
              ZeehAssets.settingsIcon,
              'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
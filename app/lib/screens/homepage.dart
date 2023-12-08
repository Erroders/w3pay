import 'package:ethpay/components/box_card.dart';
import 'package:ethpay/components/wallet_card.dart';
import 'package:ethpay/constants.dart';
import 'package:ethpay/controllers/homepage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HomepageController controller = HomepageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 8),
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 38,
            ),
            const SizedBox(width: 8),
            const Text(
              'EthPay',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SizedBox(height: kToolbarHeight * 2),
                WalletCard(),

                SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: BoxCard(
                        text: 'Pay',
                        icon: 'assets/svgs/pay.svg',
                        color: PRIMARY_COLOR_1,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: BoxCard(
                        text: 'Receive',
                        icon: 'assets/svgs/receive.svg',
                        color: PRIMARY_COLOR_2,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: BoxCard(
                        text: 'Transactions',
                        icon: 'assets/svgs/transactions.svg',
                        color: PRIMARY_COLOR_4,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: BoxCard(
                        text: 'Settings',
                        icon: 'assets/svgs/settings.svg',
                        color: PRIMARY_COLOR_3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

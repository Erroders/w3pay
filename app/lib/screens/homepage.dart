import 'package:ethpay/components/box_card.dart';
import 'package:ethpay/components/wallet_card.dart';
import 'package:ethpay/constants.dart';
import 'package:ethpay/controllers/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HomepageController controller = Get.find<HomepageController>();

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SizedBox(height: kToolbarHeight * 2),
                const WalletCard(),

                const SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.onReceive();
                        },
                        child: const BoxCard(
                          text: 'Receive',
                          icon: 'assets/svgs/receive.svg',
                          color: PRIMARY_COLOR_2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.onPay();
                        },
                        child: const BoxCard(
                          text: 'Pay',
                          icon: 'assets/svgs/pay.svg',
                          color: PRIMARY_COLOR_1,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.onTransactions();
                        },
                        child: BoxCard(
                          text: 'Transactions',
                          icon: 'assets/svgs/transactions.svg',
                          color: GREY_COLOR_LIGHT,
                          aspectRatio: 3,
                        ),
                      ),
                    ),
                    // SizedBox(width: 16),
                    // Expanded(
                    //   child: BoxCard(
                    //     text: 'Settings',
                    //     icon: 'assets/svgs/settings.svg',
                    //     color: PRIMARY_COLOR_3,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

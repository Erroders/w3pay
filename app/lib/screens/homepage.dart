import 'package:ethpay/components/box_card.dart';
import 'package:ethpay/components/wallet_card.dart';
import 'package:ethpay/constants.dart';
import 'package:ethpay/controllers/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  static const String id = "/screens/homepage";

  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HomepageController controller = Get.find<HomepageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8, bottom: 8),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: 38,
              ),
            ),
            title: const Text(
              APP_NAME,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  controller.onSettings();
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black.withOpacity(0.7),
                  size: 28,
                ),
              ),
            ],
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
                    WalletCard(
                      color: controller.walletCreated.isFalse
                          ? GREY_COLOR_LIGHT
                          : null,
                      address: controller.walletAddress.value,
                      balance: controller.walletBalance.value,
                    ),
                    const SizedBox(height: 32),
                    if (controller.walletCreated.isFalse)
                      GestureDetector(
                        onTap: () {
                          controller.onFundWallet();
                        },
                        child: const BoxCard(
                          text: 'Fund Wallet',
                          icon: 'assets/svgs/add_funds.svg',
                          color: PRIMARY_COLOR_1,
                        ),
                      ),
                    if (controller.walletCreated.isTrue)
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
                                color: PRIMARY_COLOR_1,
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
                    if (controller.walletCreated.isTrue)
                      const SizedBox(height: 16),
                    if (controller.walletCreated.isTrue)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                controller.onSettings();
                              },
                              child: const BoxCard(
                                text: 'Add Funds',
                                icon: 'assets/svgs/add_funds.svg',
                                color: PRIMARY_COLOR_2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                controller.onTransactions();
                              },
                              child: const BoxCard(
                                text: 'Transactions',
                                icon: 'assets/svgs/transactions.svg',
                                color: GREY_COLOR_LIGHT,
                                aspectRatio: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

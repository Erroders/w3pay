import 'package:ethpay/controllers/homepage.dart';
import 'package:ethpay/screens/homepage.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateWallet extends StatefulWidget {
  static const String id = "/screens/create_wallet";
  const CreateWallet({super.key});

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/full_logo.png",
                height: 500,
                width: 500,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dancingScript(
                    textStyle: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Get.find<HomepageController>().generateWallet();
                  Get.toNamed(Homepage.id);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 64),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 20,
                      cornerSmoothing: 1,
                    ),
                  ),
                ),
                child: const Text('Create Wallet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

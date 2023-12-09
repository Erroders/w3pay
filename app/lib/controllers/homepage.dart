import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class HomepageController extends GetxController {
  RxString walletAddress = "0x35c8a36820378c75Eb7792c4Ef411a9F8c5C18cF".obs;
  RxBool walletCreated = false.obs;
  RxDouble walletBalance = 0.0.obs;

  HomepageController() {
    //
  }

  Future<void> onPay() async {
    String? address = await Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.only(
              topLeft: SmoothRadius(
                cornerRadius: 20,
                cornerSmoothing: 1,
              ),
              topRight: SmoothRadius(
                cornerRadius: 20,
                cornerSmoothing: 1,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 25,
                        cornerSmoothing: 1,
                      ),
                      child: MobileScanner(
                        fit: BoxFit.cover,
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          // final Uint8List? image = capture.image;
                          for (final barcode in barcodes) {
                            Get.back(result: barcode.rawValue);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Scan QR code to send Payment",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      enterBottomSheetDuration: const Duration(milliseconds: 200),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
    );

    if (address != null) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Address: $address',
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> onReceive() async {
    String? address = await Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.only(
              topLeft: SmoothRadius(
                cornerRadius: 20,
                cornerSmoothing: 1,
              ),
              topRight: SmoothRadius(
                cornerRadius: 20,
                cornerSmoothing: 1,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: PrettyQrView.data(
                  data: walletAddress.value,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Scan this QR code to receive Payment",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      enterBottomSheetDuration: const Duration(milliseconds: 200),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
    );

    if (address != null) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Address: $address',
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> onTransactions() async {
    Get.showSnackbar(
      const GetSnackBar(
        message: 'Coming Soon',
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
      ),
    );
  }

  Future<void> onSettings() async {
    Get.showSnackbar(
      const GetSnackBar(
        message: 'Coming Soon',
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
      ),
    );
  }

  Future<void> onFundWallet() async {
    walletCreated.value = true;
  }
}

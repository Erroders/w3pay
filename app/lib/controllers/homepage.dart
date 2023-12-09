import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HomepageController extends GetxController {
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
}

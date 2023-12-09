import 'package:ethpay/constants.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class HomepageController extends GetxController {
  RxString walletAddress = "0x35c8a36820378c75Eb7792c4Ef411a9F8c5C18cF".obs;
  RxBool walletCreated = false.obs;
  RxDouble walletBalance = 0.0.obs;

  final _w3mService = W3MService(
    projectId: WALLETCONNECT_PROJECT_ID,
    metadata: const PairingMetadata(
      name: APP_NAME,
      description: 'UPI for Web3',
      url: 'https://www.walletconnect.com/',
      icons: ['https://walletconnect.com/walletconnect-logo.png'],
      redirect: Redirect(
        native: 'flutterdapp://',
        universal: 'https://www.walletconnect.com',
      ),
    ),
  );

  final _celoChain = W3MChainInfo(
    chainName: 'Celo',
    namespace: 'eip155:42220',
    chainId: '42220',
    tokenName: 'CELO',
    rpcUrl: 'https://forno.celo.org/',
    blockExplorer: W3MBlockExplorer(
      name: 'Celo Explorer',
      url: 'https://explorer.celo.org/mainnet',
    ),
  );

  final _polygonZkEvmChain = W3MChainInfo(
    chainName: 'Polygon ZkEVM',
    namespace: 'eip155:1101',
    chainId: '1101',
    tokenName: 'ETH',
    rpcUrl: 'https://rpc.ankr.com/polygon_zkevm',
    blockExplorer: W3MBlockExplorer(
      name: 'PolygonZkEVM Explorer',
      url: 'https://zkevm.polygonscan.com',
    ),
  );

  HomepageController() {
    _initWC();
  }

  Future<void> _initWC() async {
    W3MChainPresets.chains.clear();
    W3MChainPresets.chains.putIfAbsent('42220', () => _celoChain);
    W3MChainPresets.chains.putIfAbsent('1101', () => _polygonZkEvmChain);
    await _w3mService.init();
    _w3mService.selectChain(_polygonZkEvmChain);
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Steps to add Funds",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              const Text(
                "1. Connect Wallet",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  W3MNetworkSelectButton(service: _w3mService),
                  W3MConnectWalletButton(service: _w3mService),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                "2. Approve Funding",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _approveTransaction();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 64),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 20,
                      cornerSmoothing: 1,
                    ),
                  ),
                  backgroundColor: const Color(PRIMARY_COLOR_1),
                ),
                child: const Text(
                  'Approve Funds',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _sendTransaction();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 64),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 20,
                      cornerSmoothing: 1,
                    ),
                  ),
                  backgroundColor: const Color(PRIMARY_COLOR_1),
                ),
                child: const Text(
                  'Send Funds',
                  style: TextStyle(
                    color: Colors.white,
                  ),
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

    if (_w3mService.address != null) {
      walletAddress.value = _w3mService.address!;
    }
    walletCreated.value = true;
  }

  _approveTransaction() async {
    if (_w3mService.web3App == null ||
        _w3mService.session == null ||
        _w3mService.selectedChain == null) {
      return;
    }
    final response = _w3mService.web3App!.request(
      topic: _w3mService.session!.topic,
      chainId: "eip155:1101",
      request: SessionRequestParams(
        method: 'eth_sendTransaction',
        params: [
          {
            "to": USDC_POLYGON_ZK_EVM,
            "from": _w3mService.address,
            // "gas": "",
            "value": "0x0",
            "data":
                "0x095ea7b30000000000000000000000007b36dfd5304562952e2b4de9c8048ed155c6115d00000000000000000000000000000000000000000000000107ad8f556c6c0000",
            // "gasPrice": "",
            // "maxPriorityFeePerGas": "",
            // "maxFeePerGas": ""
          }
        ],
      ),
    );

    _w3mService.launchConnectedWallet();
    await Future.wait([response]);
  }

  _sendTransaction() async {
    if (_w3mService.web3App == null ||
        _w3mService.session == null ||
        _w3mService.selectedChain == null) {
      return;
    }
    final response = _w3mService.web3App!.request(
      topic: _w3mService.session!.topic,
      chainId: _w3mService.selectedChain!.chainId,
      request: SessionRequestParams(
        method: 'eth_sendTransaction',
        params: [
          {
            "to": "",
            "from": _w3mService.address,
            "gas": "",
            "value": "",
            "data": "",
            "gasPrice": "",
            "maxPriorityFeePerGas": "",
            "maxFeePerGas": ""
          }
        ],
      ),
    );

    _w3mService.launchConnectedWallet();
    await Future.wait([response]);
  }
}

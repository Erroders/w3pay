import 'dart:math';

import 'package:ethpay/constants.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:web_socket_channel/io.dart';

class HomepageController extends GetxController {
  RxBool isInitiated = false.obs;
  RxString walletAddress = "".obs;
  RxString proxyWalletAddress = "".obs;
  RxString proxyWalletPrivateKey = "".obs;
  late EthPrivateKey proxyWalletEthPrivateKey;
  RxBool walletCreated = false.obs;
  RxDouble walletBalance = 0.0.obs;

  late SharedPreferences _sharedPreferences;
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

  final client = Web3Client(
    RPC_POLYGON_ZK_EVM,
    Client(),
    socketConnector: () {
      return IOWebSocketChannel.connect(WS_POLYGON_ZK_EVM).cast<String>();
    },
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
    SharedPreferences.getInstance().then((value) async {
      _sharedPreferences = value;
      final String? pk = _sharedPreferences.getString("proxyPK");

      if (pk != null && pk.isNotEmpty) {
        proxyWalletEthPrivateKey = EthPrivateKey.fromInt(BigInt.parse(pk));
        proxyWalletAddress.value = proxyWalletEthPrivateKey.address.hex;
      }
    });
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

    if (address == null) {
      return;
    }

    bool? sent = await Get.bottomSheet(
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
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 32),
              const Text(
                "Send USDC",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 20,
                      cornerSmoothing: 1,
                    ),
                  ),
                  hintText: 'Enter Amount',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  Get.back(result: true);
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
                  'Send',
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

    if (sent != null && sent) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Sent Successfully',
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.GROUNDED,
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
    bool? completed = await Get.bottomSheet(
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
                  final res = await _sendTransaction();
                  Get.back(result: res);
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

    if (completed != null && completed) {
      walletCreated.value = true;
    }
  }

  Future<void> generateWallet() async {
    var rng = Random.secure();
    proxyWalletEthPrivateKey = EthPrivateKey.createRandom(rng);
    proxyWalletAddress.value = proxyWalletEthPrivateKey.address.hex;

    await _sharedPreferences.setString(
      "proxyPK",
      proxyWalletEthPrivateKey.privateKeyInt.toString(),
    );

    isInitiated.value = true;
  }

  _approveTransaction() async {
    if (_w3mService.web3App == null ||
        _w3mService.session == null ||
        _w3mService.selectedChain == null) {
      return;
    }

    // Indian_rupee(
    //   address: EthereumAddress.fromHex(DEPLOYED_USDC_POLYGON_ZK_EVM),
    //   client: client,
    // ).approve(
    //   EthereumAddress.fromHex(proxyWalletAddress.value),
    //   BigInt.from(1000),
    //   credentials: proxyWalletEthPrivateKey,
    // );

    final response = _w3mService.web3App!.request(
      topic: _w3mService.session!.topic,
      chainId: "eip155:1101",
      request: SessionRequestParams(
        method: 'eth_sendTransaction',
        params: [
          {
            "to": USDC_POLYGON_ZK_EVM,
            "from": _w3mService.address,
            "value": "0x0",
            "data":
                "0x095ea7b3000000000000000000000000${_w3mService.address}FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
            // "gas": "",
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

  Future<bool> _sendTransaction() async {
    if (_w3mService.web3App == null ||
        _w3mService.session == null ||
        _w3mService.selectedChain == null) {
      return true;
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

    var res = await Future.wait([response]);

    return true;
  }
}

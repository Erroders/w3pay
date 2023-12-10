import 'package:ethpay/constants.dart';
import 'package:ethpay/controllers/homepage.dart';
import 'package:ethpay/screens/create_wallet.dart';
import 'package:ethpay/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put<HomepageController>(HomepageController(), permanent: true);

  final sp = await SharedPreferences.getInstance();
  final String? pk = sp.getString("proxyPK");

  runApp(MyApp(
    isInitiated: pk != null && pk.isNotEmpty,
  ));
}

class MyApp extends StatelessWidget {
  final bool isInitiated;
  const MyApp({super.key, required this.isInitiated});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: isInitiated ? Homepage.id : CreateWallet.id,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: Homepage.id,
          page: () => const Homepage(),
        ),
        GetPage(
          name: CreateWallet.id,
          page: () => const CreateWallet(),
        ),
      ],
    );
  }
}

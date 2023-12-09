import 'package:ethpay/constants.dart';
import 'package:ethpay/controllers/homepage.dart';
import 'package:ethpay/screens/create_wallet.dart';
import 'package:ethpay/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put<HomepageController>(HomepageController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: CreateWallet.id,
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

import 'package:ethpay/controllers/homepage.dart';
import 'package:ethpay/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

void main() {
  Get.put<HomepageController>(HomepageController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EthPay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}

import 'package:get/get.dart';

class HomepageController extends GetxController {
  final _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  void onItemTapped(int index) {
    _selectedIndex.value = index;
  }
}

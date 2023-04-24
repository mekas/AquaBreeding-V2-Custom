import 'package:get/get.dart';

class PondListController extends GetxController {
  // It is mandatory initialize with one value from listType
  final selected = "pilih kolam".obs;

  void setSelected(String value) {
    selected.value = value;
  }
}

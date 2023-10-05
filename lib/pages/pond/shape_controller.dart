import 'package:get/get.dart';
import '../../service/logging_service.dart';


class ShapeController extends GetxController {
  // It is mandatory initialize with one value from listType
  final selected = "persegi".obs;
  final listMaterial = ["persegi", "bundar"];

  void setSelected(String value) {
    selected.value = value;
  }

  final DateTime startTime = DateTime.now();
  final fitur = 'Select Shape';

  Future<void> postDataLog(String fitur) async {
    bool value =
    await LoggingService().postLogging(startAt: startTime, fitur: fitur);
  }

  @override
  void onInit() async {
    postDataLog(fitur);
    super.onInit();
  }

  @override
  void dispose() {
    postDataLog(fitur);
    super.dispose();
  }
}

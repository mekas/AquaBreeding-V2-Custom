import 'package:get/get.dart';
import '../../service/logging_service.dart';

class CarbonTypeController extends GetxController {
  // It is mandatory initialize with one value from listType
  final selected = "tidak ada".obs;
  final listCarbon = ["tidak ada", "molase", "gula", "terigu"];

  void setSelected(String value) {
    selected.value = value;
  }

  final DateTime startTime = DateTime.now();
  final fitur = 'Input Carbon';

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

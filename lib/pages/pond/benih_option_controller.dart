import 'package:get/get.dart';
import '../../service/logging_service.dart';

class BenihOptionController extends GetxController {
  final selected = "1-2 cm".obs;
  final listBenih = [
    "1-2 cm",
    "2-3 cm",
    "3-4 cm",
    "4-5 cm",
    "5-6 cm",
    "6-7 cm",
    "8-9 cm",
    "9-10 cm"
  ];

  void setSelected(String value) {
    selected.value = value;
  }

  final DateTime startTime = DateTime.now();
  final fitur = 'Benih Option';

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

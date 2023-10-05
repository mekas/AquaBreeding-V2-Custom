import 'package:get/get.dart';
import '../../service/logging_service.dart';

class TypeController extends GetxController {
  // It is mandatory initialize with one value from listType
  final selected = "ringan".obs;
  final listtreatment = ["ringan", "berat"];

  void setSelected(String value) {
    selected.value = value;
  }


  final DateTime startTime = DateTime.now();
  final fitur = 'Pond Treatment';

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

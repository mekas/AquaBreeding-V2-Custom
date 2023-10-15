import 'package:get/get.dart';

import '../../service/logging_service.dart';

class TransferTypeController extends GetxController {
  // It is mandatory initialize with one value from listType
  final selected = "oversized_transfer".obs;
  final listMethod = ["oversized_transfer", "undersized_transfer"];

  void setSelected(String value) {
    selected.value = value;
  }

  final DateTime startTime = DateTime.now();
  final fitur = 'Fist Transfer(Sortir)';

  Future<void> postDataLog(String fitur) async {
    // print(buildJsonFish());
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

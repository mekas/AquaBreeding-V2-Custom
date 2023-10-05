import 'package:get/get.dart';
import '../../service/logging_service.dart';

class FishTypeController extends GetxController {
  // It is mandatory initialize with one value from listType
  final selected = "pilih ikan".obs;

  final listFish = ["lele", "nila merah", "nila hitam", "mas", "patin"].obs;

  void setSelected(String value) {
    selected.value = value;
  }

  final DateTime startTime = DateTime.now();
  final fitur = 'Fish Death';

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

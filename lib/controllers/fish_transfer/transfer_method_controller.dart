import 'package:get/get.dart';

import 'fish_transfer_entry_controller.dart';
import '../../service/logging_service.dart';

class TransferMethodController extends GetxController {
  // It is mandatory initialize with one value from listType
  final selected = "basah".obs;
  final listMethod = ["kering", "basah"];

  void setSelected(String value) {
    selected.value = value;
    FishTransferEntryController().getPondsData(selected.toString());
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

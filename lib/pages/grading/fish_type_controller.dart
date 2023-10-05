import 'package:fish/models/activation_model.dart';
import 'package:fish/pages/grading/grading_entry_controller.dart';
import 'package:get/get.dart';
import '../../service/logging_service.dart';

class FishTypeController extends GetxController {
  // It is mandatory initialize with one value from listType

  // GradingEntryController listfishController = GradingEntryController();
  Activation activation = Get.arguments["activation"];

  final selected = "pilih ikan".obs;

  final listFish = [
    "lele",
    "nila merah",
    "nila hitam",
    "mas",
    "patin",
  ].obs;

  // List getFish() {
  //   // List<String> listFish = [];
  //   listFish.clear();
  //   for (var i in activation.fishLive!) {
  //     listFish.add(i.type!);
  //     print(listFish);
  //   }
  //   return listFish;
  // }

  void setSelected(String value) {
    selected.value = value;
  }

  final DateTime startTime = DateTime.now();
  final fitur = 'Grading';

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

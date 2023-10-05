import 'package:get/get.dart';
import '../../service/logging_service.dart';

class BreedOptionController extends GetxController {
  final selected = "Benih".obs;
  final listBreed = ["Benih", "Pembesaran"];

  void setSelected(String value) {
    selected.value = value;
  }

  final DateTime startTime = DateTime.now();
  final fitur = 'Breed Option';

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

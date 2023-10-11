import 'package:fish/models/activation_model.dart';
import 'package:fish/models/pond_model.dart';
import 'package:get/get.dart';
import '../../service/logging_service.dart';


class ConstantaEditController extends GetxController {
  Pond pond = Get.arguments['pond'];
  Activation activation = Get.arguments['activation'];
  var isLoading = false.obs;

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

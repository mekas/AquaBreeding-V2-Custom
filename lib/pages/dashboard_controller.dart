import 'package:fish/controllers/home/home_controller.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;
  final HomeController controller = Get.put(HomeController(), permanent: false);

  void changeTabIndex(int index) {
    controller.getUserData();
    controller.getStatisticData();
    tabIndex = index;
    update();
  }
}

import 'package:fish/models/new_sortir_model.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/service/pond_service.dart';
import 'package:get/get.dart';
import '../../service/logging_service.dart';

class PondListController extends GetxController {
  // It is mandatory initialize with one value from listType
  final RxInt initialLenght = 1.obs;
  final isLoading = false.obs;
  late String selected;

  final listPondSelected = <ListPondSortir>[].obs;
  Future<void> getDestination(String alias) async {
    isLoading.value = true;
    List<Pond> pondsData = await PondService().getPonds();
    for (var i in pondsData) {
      if (i.alias == alias) {
        ListPondSortir pond = ListPondSortir(
            id: i.id, isInputed: false, name: i.alias, isActive: i.isActive);
        listPondSelected.add(pond);
      }
    }
    print(listPondSelected);
    isLoading.value = false;
  }

  void setSelected(String value) {
    getDestination(value);
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

  // Future<void> getPondsData(String method) async {
  //   isLoading.value = true;
  //   List<Pond> pondsData = await PondService().getPonds();
  //   listPondName.clear();
  //   if (method == "kering") {
  //     listPondName.add("pilih kolam");
  //     for (var i in pondsData) {
  //       listPondName.add(i.alias.toString());
  //     }
  //   } else {
  //     listPondName.add("pilih kolam");
  //     for (var i in pondsData) {
  //       if (i.isActive == true) {
  //         listPondName.add(i.alias.toString());
  //       }
  //     }
  //   }
  //   isLoading.value = false;
  // }
}

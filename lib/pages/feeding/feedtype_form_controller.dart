import 'package:fish/models/feed_type_model.dart';
import 'package:fish/service/feed_type_service.dart';
import 'package:get/get.dart';
import '../../service/logging_service.dart';

class FeedTypeFormController extends GetxController {
  // It is mandatory initialize with one value from listType
  final selected = "".obs;
  final listFeedType = <FeedType>[].obs;

  void setSelected(String value) {
    selected.value = value;
  }

  Future<void> getData() async {
    listFeedType.clear();
    List<FeedType> feedtypes = await FeedTypeService().fetchFeedType();
    listFeedType.addAll(feedtypes);
    setSelected(listFeedType[0].type!);
    super.onInit();
  }

  String? getIdByName() {
    print(selected);
    for (FeedType feedType in listFeedType) {
      if (feedType.type == selected.value) {
        return feedType.id;
      }
    }
    return null;
  }

  final DateTime startTime = DateTime.now();
  final fitur = 'Feeding';

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

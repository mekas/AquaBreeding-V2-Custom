import 'package:get/get.dart';

class InventarisPakanState {
  RxString selectedDropdownValue = 'Pakan Industri'.obs;

  RxList dummyDataValue = [
    {'name': 'Industri 1', 'amount': 100, 'expired_date': '22-02-2022'},
    {'name': 'Industri 2', 'amount': 80, 'expired_date': '22-02-2022'},
    {'name': 'Industri 3', 'amount': 60, 'expired_date': '22-02-2022'},
    {'name': 'Industri 4', 'amount': 40, 'expired_date': '22-02-2022'}
  ].obs;

  RxList dummyDataValue2 = [
    {'name': 'Alami 1', 'amount': 100, 'expired_date': '22-02-2022'},
    {'name': 'Alami 2', 'amount': 80, 'expired_date': '22-02-2022'},
    {'name': 'Alami 3', 'amount': 60, 'expired_date': '22-02-2022'},
    {'name': 'Alami 4', 'amount': 40, 'expired_date': '22-02-2022'}
  ].obs;

  RxList dummyDataValue3 = [
    {'name': 'Campur 1', 'amount': 100, 'expired_date': '22-02-2022'},
    {'name': 'Campur 2', 'amount': 80, 'expired_date': '22-02-2022'},
    {'name': 'Campur 3', 'amount': 60, 'expired_date': '22-02-2022'},
    {'name': 'Campur 4', 'amount': 40, 'expired_date': '22-02-2022'}
  ].obs;
}

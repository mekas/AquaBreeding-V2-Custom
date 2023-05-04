import 'package:get/get.dart';

class InventarisPakanState {
  RxString selectedDropdownValue = 'Pakan Industri'.obs;
  RxString pageDetail = 'Industri'.obs;

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

  RxList dummyDataValue4 = [
    {
      'date_input': '18:18, 12 Jan 2020',
      'category': 'industri',
      'protein': 10,
      'karbon': 10,
      'name': 'Pelet',
      'price': 25000,
      'amount': 10,
      'expired_date': '30 Jan 2020'
    },
    {
      'date_input': '18:18, 12 Jan 2020',
      'category': 'industri',
      'protein': 10,
      'karbon': 10,
      'name': 'Pelet',
      'price': 25000,
      'amount': 10,
      'expired_date': '30 Jan 2020'
    },
    {
      'date_input': '18:18, 12 Jan 2020',
      'category': 'industri',
      'protein': 10,
      'karbon': 10,
      'name': 'Pelet',
      'price': 25000,
      'amount': 10,
      'expired_date': '30 Jan 2020'
    },
  ].obs;
}

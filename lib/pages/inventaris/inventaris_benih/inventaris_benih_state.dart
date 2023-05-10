import 'package:get/get.dart';

class InventarisBenihState {
  RxString selectedDropdown = 'Kelas Benih'.obs;
  RxString selectedDropdown2 = ''.obs;
  RxString selectedDropdown3 = ''.obs;
  RxString selectedPage = 'Kelas Benih'.obs;

  RxList dummyDataValue = [
    {'year': 2023, 'fish_type': 'lele', 'amount': 90},
    {'year': 2023, 'fish_type': 'lele', 'amount': 90},
    {'year': 2023, 'fish_type': 'lele', 'amount': 90},
    {'year': 2023, 'fish_type': 'lele', 'amount': 90}
  ].obs;

  RxList dummyDataValue2 = [
    {
      'date_input': '12 Januari 2020',
      'function': 'Perawatan Air',
      'name': 'Pelet',
      'price': 25000,
      'amount': 10,
      'expired_date': '30 Januari 2020'
    },
    {
      'date_input': '12 Januari 2020',
      'function': 'Perawatan Air',
      'name': 'Pelet',
      'price': 25000,
      'amount': 10,
      'expired_date': '30 Januari 2020'
    },
    {
      'date_input': '12 Januari 2020',
      'function': 'Perawatan Air',
      'name': 'Pelet',
      'price': 25000,
      'amount': 10,
      'expired_date': '30 Januari 2020'
    },
    {
      'date_input': '12 Januari 2020',
      'function': 'Perawatan Air',
      'name': 'Pelet',
      'price': 25000,
      'amount': 10,
      'expired_date': '30 Januari 2020'
    },
  ].obs;
}

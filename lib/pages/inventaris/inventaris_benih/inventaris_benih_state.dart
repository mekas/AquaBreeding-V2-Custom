import 'package:get/get.dart';

class InventarisBenihState {
  RxString selectedDropdown = 'Kelas Benih'.obs;
  RxString selectedDropdown2 = ''.obs;
  RxString selectedDropdown3 = ''.obs;
  RxString selectedPage = 'Kelas Benih'.obs;

  RxList dummyDataValue = [
    {
      'year': 2023,
      'fish_type': 'lele',
      'amount': 90,
      'weight': 800,
    },
    {
      'year': 2023,
      'fish_type': 'lele',
      'amount': 90,
      'weight': 800,
    },
    {
      'year': 2023,
      'fish_type': 'lele',
      'amount': 90,
      'weight': 800,
    },
    {
      'year': 2023,
      'fish_type': 'lele',
      'amount': 90,
      'weight': 800,
    }
  ].obs;

  RxList dummyDataValue2 = [
    {
      'date_input': '22-02-2022',
      'amount': 10,
      'weight': 400,
      'price': 50000,
      'category': 'Kelas Benih',
      'fish_type': 'Lele',
      'sortir': '1-2',
      'panjang': null,
      'lebar': null,
    },
    {
      'date_input': '22-02-2022',
      'amount': 10,
      'weight': 400,
      'price': 50000,
      'category': 'Kelas Benih',
      'fish_type': 'Lele',
      'sortir': '1-2',
      'panjang': null,
      'lebar': null,
    },
    {
      'date_input': '22-02-2022',
      'amount': 10,
      'weight': 400,
      'price': 50000,
      'category': 'Kelas Pembesaran',
      'fish_type': 'Lele',
      'sortir': null,
      'panjang': 10,
      'lebar': 10,
    },
    {
      'date_input': '22-02-2022',
      'amount': 10,
      'weight': 400,
      'price': 50000,
      'category': 'Kelas Pembesaran',
      'fish_type': 'Lele',
      'sortir': null,
      'panjang': 10,
      'lebar': 10,
    },
    {
      'date_input': '22-02-2022',
      'amount': 10,
      'weight': 400,
      'price': 50000,
      'category': 'Kelas Pembesaran',
      'fish_type': 'Lele',
      'sortir': null,
      'panjang': 10,
      'lebar': 10,
    },
  ].obs;
}

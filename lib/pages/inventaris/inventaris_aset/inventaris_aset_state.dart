import 'package:get/get.dart';

class InventarisAsetState {
  RxList filterList = [
    {'title_id': 1, 'title': 'Semua', 'key': 'all'},
    {'title_id': 2, 'title': 'Tukang', 'key': 'tukang'},
    {'title_id': 3, 'title': 'Budidaya', 'key': 'budidaya'},
    {'title_id': 4, 'title': 'Kolam', 'key': 'kolam'},
    {'title_id': 5, 'title': 'Living', 'key': 'living'},
  ].obs;

  RxInt currIndexFilter = 1.obs;
  RxString selectedFilter = 'all'.obs;

  RxString selectedDropdownValue = 'Aset Tukang'.obs;

  RxList dummyDataValue2 = [
    {
      'date_input': '12 Januari 2020',
      'name': 'Filter Air',
      'price': 25000,
      'amount': 10,
      'function': 'Digunakan untuk memfilter air',
    },
    {
      'date_input': '12 Januari 2020',
      'name': 'Filter Air',
      'price': 25000,
      'amount': 10,
      'function': 'Digunakan untuk memfilter air',
    },
    {
      'date_input': '12 Januari 2020',
      'name': 'Filter Air',
      'price': 25000,
      'amount': 10,
      'function': 'Digunakan untuk memfilter air',
    },
    {
      'date_input': '12 Januari 2020',
      'name': 'Filter Air',
      'price': 25000,
      'amount': 10,
      'function': 'Digunakan untuk memfilter air',
    },
    {
      'date_input': '12 Januari 2020',
      'name': 'Filter Air',
      'price': 25000,
      'amount': 10,
      'function': 'Digunakan untuk memfilter air',
    },
    {
      'date_input': '12 Januari 2020',
      'name': 'Filter Air',
      'price': 25000,
      'amount': 10,
      'function': 'Digunakan untuk memfilter air',
    },
    {
      'date_input': '12 Januari 2020',
      'name': 'Filter Air',
      'price': 25000,
      'amount': 10,
      'function': 'Digunakan untuk memfilter air',
    },
    {
      'date_input': '12 Januari 2020',
      'name': 'Filter Air',
      'price': 25000,
      'amount': 10,
      'function': 'Digunakan untuk memfilter air',
    },
  ].obs;
}

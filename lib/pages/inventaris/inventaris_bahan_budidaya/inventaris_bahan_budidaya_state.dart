import 'package:get/get.dart';

class InventarisBahanBudidayaState {
  RxString selectedDropdownValue = 'Perawatan Air'.obs;
  RxString selectedDropdownValue2 = 'kg'.obs;

  RxString pageDetail = 'Perawatan Air'.obs;
  RxString detailFilter = 'input'.obs;

  RxList dummyDataValue = [
    {
      'name': 'Industri 1',
      'amount': 100,
      'type': 'kg',
      'expired_date': '22-02-2022'
    },
    {
      'name': 'Industri 2',
      'amount': 80,
      'type': 'kg',
      'expired_date': '22-02-2022'
    },
    {
      'name': 'Industri 3',
      'amount': 60,
      'type': 'ltr',
      'expired_date': '22-02-2022'
    },
    {
      'name': 'Industri 4',
      'amount': 40,
      'type': 'ltr',
      'expired_date': '22-02-2022'
    }
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
  ].obs;

  RxList dummyDataValue3 = [
    {
      'date_input': '15 Januari 2020',
      'name': 'Pelet',
      'amount': 100,
      'pond': 'Alpha',
    },
    {
      'date_input': '16 Januari 2020',
      'name': 'Pelet',
      'amount': 80,
      'pond': 'Beta',
    },
    {
      'date_input': '17 Januari 2020',
      'name': 'Pelet',
      'amount': 30,
      'pond': 'Charlie',
    }
  ].obs;
}

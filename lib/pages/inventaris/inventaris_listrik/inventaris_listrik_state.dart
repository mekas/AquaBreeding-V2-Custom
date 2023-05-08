import 'package:get/get.dart';

class InventarisListrikState {
  RxInt selectedDetailMonth = 1.obs;
  RxInt selectedDetailYear = 2023.obs;

  RxList dummyDataValue = [
    {
      'month_id': 1,
      'month': 'Januari',
      'amount': 100,
      'total': 9900,
      'year': 2023
    },
    {
      'month_id': 2,
      'month': 'Februari',
      'amount': 80,
      'total': 9900,
      'year': 2023
    },
    {
      'month_id': 3,
      'month': 'Maret',
      'amount': 60,
      'total': 9900,
      'year': 2023
    },
    {
      'month_id': 4,
      'month': 'April',
      'amount': 40,
      'total': 9900,
      'year': 2023
    },
    {
      'month_id': 1,
      'month': 'April',
      'amount': 40,
      'total': 9900,
      'year': 2023
    },
    {
      'month_id': 1,
      'month': 'April',
      'amount': 40,
      'total': 9900,
      'year': 2023
    },
    {
      'month_id': 1,
      'month': 'April',
      'amount': 40,
      'total': 9900,
      'year': 2023
    },
    {
      'month_id': 1,
      'month': 'April',
      'amount': 40,
      'total': 9900,
      'year': 2023
    },
    {
      'month_id': 1,
      'month': 'April',
      'amount': 40,
      'total': 9900,
      'year': 2023
    },
    {
      'month_id': 1,
      'month': 'April',
      'amount': 40,
      'total': 9900,
      'year': 2023
    },
    {
      'month_id': 1,
      'month': 'April',
      'amount': 40,
      'total': 9900,
      'year': 2023
    },
    {
      'month_id': 1,
      'month': 'April',
      'amount': 40,
      'total': 9900,
      'year': 2023
    },
  ].obs;

  RxList dummyDataValue2 = [
    {
      'date_input': '12 Januari 2020',
      'amount': 100,
      'price': 39000,
    },
    {
      'date_input': '13 Januari 2020',
      'amount': 100,
      'price': 39000,
    },
    {
      'date_input': '14 Januari 2020',
      'amount': 100,
      'price': 39000,
    },
  ].obs;
}

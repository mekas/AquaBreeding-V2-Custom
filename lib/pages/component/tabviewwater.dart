import 'package:fish/pages/dailywater/daily_water_list_page.dart';
import 'package:fish/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fish/models/activation_model.dart';
import 'package:fish/models/pond_model.dart';

import '../weeklywater/weeklywater_list_page.dart';

class MyWaterTabs extends GetxController
    with GetSingleTickerProviderStateMixin {
  Activation activation = Get.arguments["activation"];
  Pond pond = Get.arguments["pond"];
  var isLoading = false.obs;
  late TabController controller;
  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: 'Harian',
    ),
    const Tab(
      text: 'Mingguan',
    )
  ];

  @override
  void onInit() {
    controller = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

class MyWaterTabScreen extends StatelessWidget {
  const MyWaterTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyWaterTabs tabs = Get.put(MyWaterTabs());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: const Text('Kondisi Air'),
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: tabs.myTabs,
          controller: tabs.controller,
        ),
      ),
      body: TabBarView(
        controller: tabs.controller,
        children: const [DailyWaterPage(), WeeklyWaterPage()],
      ),
    );
  }
}

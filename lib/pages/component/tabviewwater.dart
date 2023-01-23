import 'package:fish/pages/dailywater/daily_water_pond_list_page.dart';
import 'package:fish/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWaterTabs extends GetxController
    with GetSingleTickerProviderStateMixin {
  var isLoading = false.obs;
  late TabController controller;
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Harian',
    ),
    Tab(
      text: 'Mingguan',
    )
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    controller = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    controller.dispose();
    super.onClose();
  }
}

class MyWaterTabScreen extends StatelessWidget {
  const MyWaterTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyWaterTabs _tabs = Get.put(MyWaterTabs());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: const Text('Kondisi Air'),
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: _tabs.myTabs,
          controller: _tabs.controller,
        ),
      ),
      body: TabBarView(
        controller: _tabs.controller,
        children: [DailyWaterPondPage(), Text('test')],
      ),
    );
  }
}

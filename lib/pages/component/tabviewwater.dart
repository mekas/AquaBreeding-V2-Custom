import 'package:fish/controllers/daily_water/daily_water_controller.dart';
import 'package:fish/controllers/weeklywater/weekly_water_controller.dart';
import 'package:fish/pages/dailywater/daily_water_list_page.dart';
import 'package:fish/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../weeklywater/weeklywater_list_page.dart';

class MyWaterTabs extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Activation activation = Get.arguments["activation"];
  // Pond pond = Get.arguments["pond"];
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
    controller.addListener(() {
      if (controller.indexIsChanging) {
        if (controller.previousIndex == 0) {
          Get.delete<DailyWaterController>();
          Get.put(WeeklyWaterController());
        } else {
          Get.delete<WeeklyWaterController>();
          Get.put(DailyWaterController());
        }
      }
      // Tab Changed tapping on new tab
    });
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
  final String routeName = 'waterTab';
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
        children: [DailyWaterPage(), WeeklyWaterPage()],
      ),
    );
  }
}

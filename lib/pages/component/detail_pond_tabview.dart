import 'package:fish/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/pond/pond_controller.dart';
import 'package:fish/pages/pond/detail_pond_page.dart';

import 'package:fish/pages/dailywater/daily_water_pond_detail_page.dart';

class MyTabsPond extends GetxController with GetSingleTickerProviderStateMixin {
  var isLoading = false.obs;

  late TabController controller;
  Pond pond = Get.arguments["pond"];
  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: 'Musim Budidaya',
    ),
    const Tab(
      text: 'Kondisi Air',
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

class MyTabPondScreen extends StatelessWidget {
  MyTabPondScreen({Key? key}) : super(key: key);
  final pondController = Get.put(PondController());
  @override
  Widget build(BuildContext context) {
    final MyTabsPond tabs = Get.put(MyTabsPond());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: const Text('Detail Kolam'),
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: tabs.myTabs,
          controller: tabs.controller,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            // Get.back();

            Navigator.pop(context);

            pondController.getPondsData(context);
          },
        ),
      ),
      body: TabBarView(
        controller: tabs.controller,
        children: const [DetailPondPage(), DailyWaterDetailPondPage()],
      ),
    );
  }
}

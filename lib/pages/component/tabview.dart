import 'package:fish/pages/pond/detail_breed_page.dart';
import 'package:fish/pages/treatment/treatment_page.dart';
import 'package:fish/pages/fish_transfer/fish_transfer_list_page.dart';
import 'package:fish/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fish/models/activation_model.dart';
import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/pond/detail_pond_controller.dart';

class MyTabs extends GetxController with GetSingleTickerProviderStateMixin {
  var isLoading = false.obs;

  late TabController controller;
  Activation activation = Get.arguments["activation"];
  Pond pond = Get.arguments["pond"];
  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: 'Rekap Data',
    ),
    const Tab(
      text: 'Treatment',
    ),
    const Tab(
      text: 'Riwayat Sortir',
    )
  ];

  @override
  void onInit() {
    controller = TabController(length: 3, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

class MyTabScreen extends StatelessWidget {
  MyTabScreen({Key? key}) : super(key: key);
  final DetailPondController detailPondController =
      Get.put(DetailPondController());
  @override
  Widget build(BuildContext context) {
    final MyTabs tabs = Get.put(MyTabs());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: const Text('Detail Musim Budidaya'),
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

            detailPondController.getPondActivation(context);
          },
        ),
      ),
      body: TabBarView(
        controller: tabs.controller,
        children: const [
          DetailBreedPage(),
          TreatmentpPage(),
          FishTransferListPage()
        ],
      ),
    );
  }
}

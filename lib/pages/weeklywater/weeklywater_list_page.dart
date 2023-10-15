import 'package:fish/controllers/weeklywater/weekly_water_controller.dart';
import 'package:fish/pages/component/weekly_water_card.dart';
import 'package:fish/pages/weeklywater/weeklywater_avg.dart';
import 'package:fish/pages/weeklywater/weeklywater_entry_page.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
// import 'package:fish/pages/dailywater/daily_water_entry_page.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:get/get.dart';

import '../../widgets/new_Menu_widget.dart';

class WeeklyWaterPage extends StatefulWidget {
  WeeklyWaterPage({Key? key}) : super(key: key);

  @override
  State<WeeklyWaterPage> createState() => _WeeklyWaterPageState();
}

class _WeeklyWaterPageState extends State<WeeklyWaterPage> {
  final WeeklyWaterController controller = Get.put(WeeklyWaterController());
  var isMenuTapped = false.obs;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await controller.getPondActivations(
    //       pondId: controller.pond.id.toString());
    // });
    controller.getWeeklyWaterData(context);
  }

  @override
  void dispose() {
    controller.postDataLog(controller.fitur);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    Widget fishDataRecap() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Kolam ${controller.pond.alias!}",
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: heavy,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            TextButton(
              onPressed: () {
                Get.to(() => WeeklyWaterAvgPage(), arguments: {
                  "pond": controller.pond,
                  "activation": controller.activation
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Rata-Rata/Minggu ',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget listWeeklyWater() {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
          child: Column(
            children: controller.listWeeklyWater
                .map(
                  (weeklyWaterList) => WeeklyWaterCard(
                      weeklyWaterList: weeklyWaterList,
                      activation: controller.activation,
                      pond: controller.pond),
                )
                .toList(),
          ));
    }

    Widget emptyList() {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
          child: Center(
            child: Column(children: [
              SizedBox(height: 35),
              Image(
                image: AssetImage("assets/unavailable_icon.png"),
                width: 100,
                height: 100,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(height: 20),
              Text(
                "Kolam belum pernah dilakukan treatment",
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text(
                "Silahkan masukan treatment",
                style: secondaryTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ]),
          ));
    }

    return Obx(() {
      if (controller.isLoading.value == false) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: backgroundColor1,
            actions: [
              IconButton(
                onPressed: () {
                  // scaffoldKey.currentState?.openEndDrawer();
                  setState(() {
                    isMenuTapped.value = !isMenuTapped.value;
                  });
                },
                icon: Icon(Icons.card_travel_rounded),
              )
            ],
          ),
          endDrawer: DrawerInvetarisList(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => WeeklyWaterEntryPage(), arguments: {
                "pond": controller.pond,
                "activation": controller.activation
              });
              controller.postDataLog(controller.fitur);
            },
            backgroundColor: primaryColor,
            child: const Icon(Icons.add),
          ),
          backgroundColor: backgroundColor1,
          body: ListView(
            children: [
              if (isMenuTapped.value)
                Column(
                  children: [
                    newMenu(),
                    SizedBox(height: 10,),
                  ],
                ),
              fishDataRecap(),
              controller.listWeeklyWater.isEmpty
                  ? emptyList()
                  : listWeeklyWater(),
              SizedBox(
                height: 10,
              )
            ],
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: secondaryColor,
          ),
        );
      }
    });
  }
}

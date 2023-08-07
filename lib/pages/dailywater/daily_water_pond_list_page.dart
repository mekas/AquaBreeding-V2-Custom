import 'package:fish/controllers/daily_water/daily_water_pond_list_controller.dart';
import 'package:fish/pages/component/list_pond_daily_water_card.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:get/get.dart';

class DailyWaterPondPage extends StatelessWidget {
  DailyWaterPondPage({Key? key}) : super(key: key);

  final DailyWaterPondListController controller =
      Get.put(DailyWaterPondListController());

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    // Widget title() {
    //   return Container(
    //     margin: EdgeInsets.only(
    //       top: defaultMargin,
    //       left: defaultMargin,
    //       right: defaultMargin,
    //     ),
    //     child: Text(
    //       controller.ponds.toString(),
    //       style: primaryTextStyle.copyWith(
    //         fontSize: 24,
    //         fontWeight: semiBold,
    //       ),
    //     ),
    //   );
    // }

    // Widget pondList() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 14),
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           SizedBox(
    //             width: defaultMargin,
    //           ),
    //           Column(
    //             children: controller.ponds
    //                 .map(
    //                   (pond) => DailyWaterListPondCard(pond: pond),
    //                 )
    //                 .toList(),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    Widget dailyWaterPonds() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemBuilder: ((context, index) {
            return DailyWaterListPondCard(pond: controller.ponds[index]
                // indicatorWater: controller.indicatorWater[index]);
                );
          }),
          itemCount: controller.ponds.length,
        ),
      );
    }

    return Obx(() {
      if (controller.isLoading.value == false) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: backgroundColor1,
          appBar: AppBar(
            backgroundColor: backgroundColor1,
            actions: [
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
                icon: Icon(Icons.card_travel_rounded),
              )
            ],
          ),
          endDrawer: DrawerInvetarisList(),
          body: ListView(
            children: [
              // title(),
              dailyWaterPonds(),
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

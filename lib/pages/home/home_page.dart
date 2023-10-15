import 'package:fish/pages/component/statistic_card.dart';
import 'package:fish/pages/component/water_card.dart';
import 'package:fish/controllers/home/home_controller.dart';
import 'package:fish/pages/deactivation_recap/deactivation_recap_page.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fish/theme.dart';

import '../../widgets/new_Menu_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController(), permanent: false);
  var isMenuTapped = false.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Selamat Datang',
          style: primaryTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget username() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          controller.username,
          style: secondaryTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget statistic() {
      return Container(
          margin: EdgeInsets.only(
            top: defaultMargin,
            left: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: StatisticCard(
                        title: 'Kolam',
                        value: controller.statistic.value.total_pond,
                      )),
                  Expanded(
                      flex: 1,
                      child: StatisticCard(
                        title: 'Kolam Aktif',
                        value: controller.statistic.value.active_pond,
                      )),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: StatisticCard(
                        title: 'Ikan Hidup',
                        value: controller.statistic.value.fish_live,
                        unit: 'Ekor',
                      )),
                  Expanded(
                      flex: 1,
                      child: StatisticCard(
                        title: 'Ikan Mati',
                        value: controller.statistic.value.fish_death,
                        unit: 'Ekor',
                      )),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: StatisticCard(
                        title: 'Panen',
                        value: double.parse(controller
                            .statistic.value.fish_harvested!
                            .toStringAsFixed(1)),
                        unit: 'Kg',
                      )),
                  Expanded(
                      flex: 1,
                      child: StatisticCard(
                        title: 'Total Pakan',
                        value: double.parse(controller
                            .statistic.value.total_feed_dose!
                            .toStringAsFixed(1)),
                        unit: 'Kg',
                      )),
                ],
              ),
            ],
          ));
    }

    Widget fishTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultSpace,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Berat Ikan',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    // Widget fish() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 14),
    //     child: SingleChildScrollView(
    //       scrollDirection: Axis.horizontal,
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: defaultMargin,
    //           ),
    //           Row(children: [
    //             FishCard(
    //               title: "Lele",
    //               value: controller.statistic.value.fishes_weight_lele!,
    //               image: "assets/lele.png",
    //             ),
    //             FishCard(
    //               title: "Nila Merah",
    //               value: controller.statistic.value.fishes_weight_nilamerah!,
    //               image: "assets/nilamerah.png",
    //             ),
    //             FishCard(
    //               title: "Nila Hitam",
    //               value: controller.statistic.value.fishes_weight_nilahitam!,
    //               image: "assets/nilahitam.png",
    //             ),
    //             FishCard(
    //               title: "Mas",
    //               value: controller.statistic.value.fishes_weight_mas!,
    //               image: "assets/mas.png",
    //             ),
    //           ]),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    Widget waterTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultSpace,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kualitas Air',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    Widget water() {
      return Container(
        margin: const EdgeInsets.only(top: 14),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Row(children: [
                WaterCard(
                  title: "pH",
                  normal: controller.statistic.value.ph_normal,
                  abnormal: controller.statistic.value.ph_abnormal,
                ),
                WaterCard(
                  title: "DO",
                  normal: controller.statistic.value.do_normal,
                  abnormal: controller.statistic.value.do_abnormal,
                ),
                WaterCard(
                  title: "Flok",
                  normal: controller.statistic.value.floc_normal,
                  abnormal: controller.statistic.value.floc_abnormal,
                ),
              ]),
            ],
          ),
        ),
      );
    }

    // Widget logoutButton() {
    //   return Container(
    //     height: 50,
    //     width: double.infinity,
    //     margin: EdgeInsets.only(
    //         top: defaultSpace * 3, right: defaultMargin, left: defaultMargin),
    //     child: TextButton(
    //       onPressed: () {
    //         // Get.back();
    //         controller.deleteToken();
    //         // controller.getWeek();
    //       },
    //       style: TextButton.styleFrom(
    //         backgroundColor: primaryColor,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(12),
    //         ),
    //       ),
    //       child: Text(
    //         'Submit',
    //         style: primaryTextStyle.copyWith(
    //           fontSize: 16,
    //           fontWeight: medium,
    //         ),
    //       ),
    //     ),
    //   );
    // }

    // Widget newMenu(bool isMenuTapped) {
    //   return isMenuTapped ? Column(
    //     children: [
    //       SizedBox(height: 10,),
    //       Container(
    //         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Column(
    //               children: [
    //                 SizedBox(
    //                   width: 55,
    //                   height: 55,
    //                   child: ElevatedButton(onPressed: (){}, child: Image.asset("assets/icon_pakan.png", fit: BoxFit.cover,), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(),)),
    //                 ),
    //                 SizedBox(height: 10,),
    //                 Text("Pakan",
    //                   style: primaryTextStyle.copyWith(
    //                     fontSize: 18,
    //                     fontWeight: semiBold,
    //                   ),)
    //               ],
    //             ),
    //             Column(
    //               children: [
    //                 SizedBox(
    //                   width: 55,
    //                   height: 55,
    //                   child: ElevatedButton(onPressed: (){}, child: Image.asset("assets/icon_suplemen.png", fit: BoxFit.cover,), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(),)),
    //                 ),
    //                 SizedBox(height: 10,),
    //                 Text("Suplemen",
    //                   style: primaryTextStyle.copyWith(
    //                     fontSize: 18,
    //                     fontWeight: semiBold,
    //                   ),)
    //               ],
    //             ),
    //             Column(
    //               children: [
    //                 SizedBox(
    //                   width: 55,
    //                   height: 55,
    //                   child: ElevatedButton(onPressed: (){}, child: Image.asset("assets/icon_listrik.png", fit: BoxFit.cover,), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(),)),
    //                 ),
    //                 SizedBox(height: 10,),
    //                 Text("Listrik",
    //                   style: primaryTextStyle.copyWith(
    //                     fontSize: 18,
    //                     fontWeight: semiBold,
    //                   ),)
    //               ],
    //             ),
    //             Column(
    //               children: [
    //                 SizedBox(
    //                   width: 55,
    //                   height: 55,
    //                   child: ElevatedButton(onPressed: (){}, child: Image.asset("assets/ikon_asset.png", fit: BoxFit.cover,), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(),)),
    //                 ),
    //                 SizedBox(height: 10,),
    //                 Text("Asset",
    //                   style: primaryTextStyle.copyWith(
    //                     fontSize: 18,
    //                     fontWeight: semiBold,
    //                   ),)
    //               ],
    //             ),
    //             Column(
    //               children: [
    //                 SizedBox(
    //                   width: 55,
    //                   height: 55,
    //                   child: ElevatedButton(onPressed: (){}, child: Image.asset("assets/icon_benih.png", fit: BoxFit.cover,), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(),)),
    //                 ),
    //                 SizedBox(height: 10,),
    //                 Text("Benih",
    //                   style: primaryTextStyle.copyWith(
    //                     fontSize: 18,
    //                     fontWeight: semiBold,
    //                   ),)
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ) : Container();
    // }

    return Obx(() {
      if (controller.isLoading.value == false) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: backgroundColor1,
            title: Text('Home'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return DeactivationRecapPage();
                  },
                ));
              },
              icon: Icon(Icons.book_rounded),
            ),
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
          backgroundColor: backgroundColor1,
          body: ListView(
            children: [
              if (isMenuTapped.value)
                newMenu(),
              title(),
              username(),
              statistic(),
              waterTitle(),
              water(),
              const SizedBox(
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



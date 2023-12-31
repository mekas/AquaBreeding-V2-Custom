import 'dart:developer';

import 'package:fish/models/feed_chart_model.dart';
import 'package:fish/pages/component/feed_month_card.dart';
import 'package:fish/pages/feeding/feed_controller.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:flutter/material.dart';
import 'package:fish/pages/feeding/feed_entry_page.dart';
import 'package:fish/theme.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../widgets/new_Menu_widget.dart';

class DetailFeedPage extends StatefulWidget {
  const DetailFeedPage({Key? key}) : super(key: key);

  @override
  State<DetailFeedPage> createState() => _DetailFeedPageState();
}

class _DetailFeedPageState extends State<DetailFeedPage> {
  var isMenuTapped = false.obs;
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    final FeedController controller = Get.put(FeedController());
    final InventarisPakanState pakanState = Get.put(InventarisPakanState());

    Widget feedCatDropdown() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Kategori Pakan',
              style: headingText2,
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: inputColor,
              ),
              child: StatefulBuilder(
                builder: ((context, setState) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton(
                      onChanged: ((String? value) async {
                        setState(() {
                          pakanState.feedCategory.value = value!;
                        });
                        pakanState.feedCategory.value = value!;
                        await pakanState.getHistoryFeedChartData(
                            pakanState.feedCategory.value, () {
                          controller
                              .getChartFeed(pakanState.feedCategory.value);
                        });
                      }),
                      value: pakanState.feedCategory.value,
                      dropdownColor: inputColor,
                      items: pakanState.dropdownList.map(
                        (String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                              style: headingText3,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    }

    Widget chartFeed() {
      return SfCartesianChart(
        enableAxisAnimation: true,
        tooltipBehavior: TooltipBehavior(enable: true),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
        ),
        title: ChartTitle(
            text: 'Total Pakan',
            textStyle: const TextStyle(color: Colors.white)),
        legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            textStyle: const TextStyle(color: Colors.white)),
        primaryXAxis: CategoryAxis(
            labelStyle: const TextStyle(color: Colors.white),
            autoScrollingDelta: 4),
        primaryYAxis: NumericAxis(
            labelFormat: '{value} kg',
            // maximum: 100,
            // minimum: 0,
            labelStyle: const TextStyle(color: Colors.white)),
        series: <ChartSeries>[
          LineSeries<FeedChartData, dynamic>(
              enableTooltip: true,
              color: Colors.blueAccent,
              dataSource: controller.charData,
              xValueMapper: (FeedChartData feed, _) => feed.getDate(),
              yValueMapper: (FeedChartData feed, _) => feed.amount,
              name: 'Jumlah Pakan')
        ],
      );
    }

    Widget emptyListPond() {
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
                "Anda belum pernah melakukan entry pakan",
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
                "Silahkan Lakukan Entry Pakan",
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

    Widget feedDataRecap() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "kolam ${controller.pond.alias}",
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: heavy,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget entryPakanButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: TextButton(
          onPressed: () {
            Get.to(() => FeedEntryPage(), arguments: {
              "pond": controller.pond,
              "activation": controller.activation
            });
            controller.postDataLog(controller.fitur);
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.green.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Entry Pakan',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    Widget detail() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lokasi Kolam",
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "Blok A",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  " ",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Total Pemberian Pakan",
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "30 Kali",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jumlah Ikan",
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "Lele: 100 Ekor",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "Nila Merah: 100 Ekor",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Total Pakan",
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "30 Kg",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget recapTitle() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace * 2, right: defaultMargin, left: defaultMargin),
        child: Text(
          "Rekapitulasi Pakan Bulanan",
          style: primaryTextStyle.copyWith(
            fontSize: 14,
            fontWeight: bold,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );
    }

    // Widget chartRecap() {
    //   return Container(
    //     width: double.infinity,
    //     margin: EdgeInsets.only(
    //         top: defaultSpace * 2, right: defaultMargin, left: defaultMargin),
    //     // decoration: BoxDecoration(
    //     //     image: DecorationImage(image: AssetImage('assets/feedChart.png'))),
    //   );
    // }

    Widget listMonthFeed() {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
          child: Column(
            children: controller.list_feedHistoryMonthly
                .map(
                  (feedHistoryMonthly) => FeedMonthCard(
                      activation: controller.activation,
                      pond: controller.pond,
                      feedHistoryMonthly: feedHistoryMonthly),
                )
                .toList(),
          ));
    }

    return Obx(
      () => Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: backgroundColor2,
          title: const Text("Detail Pakan Permusim"),
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
        body: controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              )
            : ListView(
                children: [
                  if (isMenuTapped.value)
                    Column(
                      children: [
                        newMenu(),
                        SizedBox(height: 10,),
                      ],
                    ),
                  feedCatDropdown(),
                  chartFeed(),
                  feedDataRecap(),
                  // detail(),
                  entryPakanButton(),
                  recapTitle(),
                  // chartRecap(),
                  controller.list_feedHistoryMonthly.isEmpty
                      ? emptyListPond()
                      : listMonthFeed(),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
      ),
    );
  }
}

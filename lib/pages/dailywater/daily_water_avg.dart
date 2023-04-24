import 'package:fish/pages/component/daily_water_avg_card.dart';
import 'package:fish/controllers/daily_water/daily_water_avg_controller.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:get/get.dart';

class DailyWaterAvgPage extends StatefulWidget {
  const DailyWaterAvgPage({Key? key}) : super(key: key);

  @override
  State<DailyWaterAvgPage> createState() => _DailyWaterAvgPageState();
}

class _DailyWaterAvgPageState extends State<DailyWaterAvgPage> {
  final DailyWaterAvgController controller = Get.put(DailyWaterAvgController());

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await controller.getPondActivations(
    //       pondId: controller.pond.id.toString());
    // });
    controller.getDailyWaterData(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget fishDataRecap() {
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
                  "Kolam ${controller.pond.alias!}",
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: heavy,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget listDailyWater() {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemBuilder: ((context, index) {
              return DailyWaterCardAvg(sol: controller.sol[index]
                  // indicatorWater: controller.indicatorWater[index]);
                  );
            }),
            itemCount: controller.sol.length,
          ));
    }

    Widget emptyList() {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
          child: Center(
            child: Column(children: [
              const SizedBox(height: 35),
              const Image(
                image: AssetImage("assets/unavailable_icon.png"),
                width: 100,
                height: 100,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 10),
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
          appBar: AppBar(
            backgroundColor: backgroundColor2,
            title: const Text("Kondisi Air Rata-Rata/Minggu"),
          ),
          backgroundColor: backgroundColor1,
          body: ListView(
            children: [
              fishDataRecap(),
              controller.listDailyWater.isEmpty
                  ? emptyList()
                  : listDailyWater(),
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

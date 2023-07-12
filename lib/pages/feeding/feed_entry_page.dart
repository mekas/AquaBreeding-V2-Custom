// ignore_for_file: unrelated_type_equality_checks

import 'package:fish/pages/feeding/feed_entry_controller.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:get/get.dart';

import 'feed_controller.dart';

class FeedEntryPage extends StatefulWidget {
  const FeedEntryPage({Key? key}) : super(key: key);

  @override
  State<FeedEntryPage> createState() => _FeedEntryPageState();
}

class _FeedEntryPageState extends State<FeedEntryPage> {
  final FeedEntryController controller = Get.put(FeedEntryController());
  final FeedController feedcontroller = Get.put(FeedController());
  final InventarisPakanState pakanState = Get.put(InventarisPakanState());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.feedDosisController.text = '0';
    pakanState.setStatusDetailFeed.value = false;
    pakanState.getAllData('Alami', () => null);
  }

  @override
  Widget build(BuildContext context) {
    // Widget feedTypeInput1() {
    //   return Container(
    //     margin: EdgeInsets.only(
    //         top: defaultSpace, right: defaultMargin, left: defaultMargin),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Jenis Pakan',
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 16,
    //             fontWeight: medium,
    //           ),
    //         ),
    //         SizedBox(
    //           height: 12,
    //         ),
    //         Container(
    //           height: 50,
    //           padding: EdgeInsets.symmetric(
    //             horizontal: 16,
    //           ),
    //           decoration: BoxDecoration(
    //             color: backgroundColor2,
    //             borderRadius: BorderRadius.circular(12),
    //           ),
    //           child: Center(
    //             child: TextFormField(
    //               style: primaryTextStyle,
    //               inputFormatters: <TextInputFormatter>[
    //                 FilteringTextInputFormatter.digitsOnly
    //               ],
    //               keyboardType: TextInputType.number,
    //               controller: controller.feedTypeController,
    //               decoration: InputDecoration.collapsed(
    //                 hintText: 'ex: Pelet',
    //                 hintStyle: subtitleTextStyle,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    Widget feedTypeInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tipe Pakan',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
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
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  onChanged: ((String? value) async {
                    pakanState.setStatusDetailFeed.value = false;
                    pakanState.selectedFeedType.value = value!;

                    await pakanState.getAllData(value, () => null);
                    pakanState.resetVariables();
                  }),
                  value: pakanState.selectedFeedType.value,
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
              ),
            ),
          ],
        ),
      );
    }

    Widget feedList() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'List Pakan',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
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
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Map<String, dynamic>>(
                  onChanged: (val) async {
                    pakanState.selectedFeedName.value = val!;
                    pakanState.setStatusDetailFeed.value = true;
                    controller.fishFeedID.value = val['feed_id'];
                    await pakanState.getDataByID(val['id'], () => null);
                  },
                  value: pakanState.selectedFeedName.value,
                  dropdownColor: inputColor,
                  items: pakanState.selectedFeedList
                      .map<DropdownMenuItem<Map<String, dynamic>>>(
                    (val) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: val,
                        child: Text(
                          val['feed_name'],
                          style: headingText3,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget feedDosisInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFieldWidget(
                  label: 'Produser',
                  controller: pakanState.producer,
                  isLong: false,
                  isEdit: false,
                ),
                TextFieldWidget(
                  label: 'Masa Kadaluarsa',
                  isLong: false,
                  isEdit: false,
                  controller: pakanState.minExp,
                  suffixSection: Text(
                    'hari',
                    style: headingText3,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFieldWidget(
                  label: 'Protein',
                  controller: pakanState.protein,
                  isLong: false,
                  isEdit: false,
                  suffixSection: Text(
                    '%',
                    style: headingText3,
                  ),
                ),
                TextFieldWidget(
                  label: 'Karbo',
                  isLong: false,
                  isEdit: false,
                  controller: pakanState.carbo,
                  suffixSection: Text(
                    '%',
                    style: headingText3,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFieldWidget(
                  label: 'Stok Pakan',
                  controller: pakanState.amount,
                  isLong: false,
                  isEdit: false,
                  suffixSection: Text(
                    'kg',
                    style: headingText3,
                  ),
                ),
                TextFieldWidget(
                  label: 'Dosis Pakan',
                  isLong: false,
                  isEdit: true,
                  numberOutput: true,
                  controller: controller.feedDosisController,
                  hint: 'ex: 2.1',
                  suffixSection: Text(
                    'kg',
                    style: headingText3,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget submitButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace * 3, right: defaultMargin, left: defaultMargin),
        child: TextButton(
          onPressed: () async {
            controller.feedDosisController.text == ""
                ? null
                : Navigator.pop(context);
            controller.postFeedHistory();
            // feedcontroller.getChartFeed(
            //     activation_id: controller.activation.id.toString());
            feedcontroller.getChartFeed('Alami');
            feedcontroller.getWeeklyRecapFeedHistory(
                activation_id: controller.activation.id.toString());
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Submit',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    return Obx(() {
      if (controller.isLoading.value == false) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor2,
            title: const Text("Entry Pakan"),
          ),
          backgroundColor: backgroundColor1,
          body: ListView(
            children: [
              // pondInput(),
              feedTypeInput(),
              pakanState.isLoadingPage.value
                  ? Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        feedList(),
                        pakanState.isLoadingFeedDetail.value
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : pakanState.setStatusDetailFeed.value
                                ? Column(
                                    children: [
                                      feedDosisInput(),
                                      submitButton(),
                                    ],
                                  )
                                : Container(),
                      ],
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

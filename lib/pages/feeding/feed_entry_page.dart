// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/feeding/feed_entry_controller.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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
    initializeDateFormatting('id', null);
    controller.feedDosisController.text = '0';
    pakanState.setStatusDetailFeed.value = false;
    pakanState.selectedUsedDate.value = '';
    pakanState.showedUsedDate.clear();
    pakanState.resetFeedVariables();
    pakanState.resetNameVariables();

    pakanState.selectedFeedType.value = pakanState.feedCategory.value;

    pakanState.getAllData(pakanState.selectedFeedType.value, () {
      if (pakanState.selectedFeedList.isNotEmpty) {
        pakanState.getDataByID(pakanState.selectedFeedName.value['id'], () {
          controller.calculatedStock.value =
              double.parse(pakanState.amount.text);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

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

                    await pakanState.getAllData(value, () {
                      if (pakanState.selectedFeedList.isNotEmpty) {
                        pakanState.getDataByID(
                            pakanState.selectedFeedName.value['id'], () {
                          controller.calculatedStock.value =
                              double.parse(pakanState.amount.text);
                        });
                      }
                    });
                    pakanState.resetFeedVariables();
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
            pakanState.selectedFeedList.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada data',
                      style: headingText3.copyWith(color: Colors.red),
                    ),
                  )
                : Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: inputColor,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (val) async {
                          pakanState.selectedFeedName.value = val!;
                          pakanState.setStatusDetailFeed.value = true;
                          await pakanState.getDataByID(val['id'], () {
                            controller.calculatedStock.value =
                                double.parse(pakanState.amount.text);
                          });
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
                  label: 'Karbon',
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) {
                        return TextFieldWidget(
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
                          onChange: (v) {
                            if (double.parse(pakanState.amount.text) -
                                    double.parse(controller
                                                .feedDosisController.text ==
                                            ''
                                        ? '0.0'
                                        : controller.feedDosisController.text) <
                                0) {
                              Flushbar(
                                message:
                                    "Tidak boleh kurang dari stok tersedia",
                                duration: Duration(seconds: 2),
                                leftBarIndicatorColor: Colors.red,
                              ).show(context);
                            }
                            setState(() {
                              controller.calculatedStock.value =
                                  double.parse(pakanState.amount.text) -
                                      double.parse(
                                          controller.feedDosisController.text ==
                                                  ''
                                              ? '0.0'
                                              : controller
                                                  .feedDosisController.text);
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Sisa Stok : ${controller.calculatedStock.value.toStringAsFixed(2)}',
                      style: headingText3.copyWith(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: controller.checkBoxState.value,
                  onChanged: (v) {
                    controller.checkBoxState.value = v!;
                    pakanState.selectedUsedDate.value = '';
                    pakanState.showedUsedDate.clear();
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Aktifkan tanggal input pakan manual',
                      style: headingText3,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            controller.checkBoxState.value
                ? GestureDetector(
                    onTap: () async {
                      final DateTime? datePicker = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      // ignore: use_build_context_synchronously
                      if (datePicker != null) {
                        final TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(datePicker!),
                          builder: (context, child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );

                        if (selectedTime != null) {
                          // Define the format for parsing

                          // Define the format for parsing the input date and time string
                          String inputFormatStr =
                              'EEEE, d MMMM yyyy | \'Jam\' HH:mm:ss.SSS';
                          DateTime dateTime =
                              DateFormat(inputFormatStr, 'id_ID').parse(
                                  '${pakanState.dateFormat(datePicker.toString(), false)} | Jam ${selectedTime!.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}:00.000');

                          // Define the format for formatting the date into the desired format
                          String outputFormatStr = 'yyyy-MM-ddTHH:mm:ss.SSS';
                          String formattedDateTime =
                              DateFormat(outputFormatStr).format(dateTime);

                          inspect(DateTime.now().toString());

                          pakanState.selectedUsedDate.value = datePicker == null
                              ? ''
                              : '$formattedDateTime +0000';

                          pakanState.showedUsedDate.text = datePicker == null
                              ? ''
                              : '${pakanState.dateFormat(datePicker.toString(), false)} | Jam ${selectedTime!.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}';

                          inspect(pakanState.selectedUsedDate.value);
                        }
                      }
                    },
                    child: TextFieldWidget(
                      label: 'Pilih Tanggal',
                      controller: pakanState.showedUsedDate,
                      isLong: true,
                      isEdit: false,
                      suffixSection: Icon(
                        Icons.arrow_drop_down_circle_rounded,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
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
            feedcontroller.getChartFeed(pakanState.selectedFeedType.value);
            feedcontroller.getWeeklyRecapFeedHistory(
                activation_id: controller.activation.id.toString());
            controller.postDataLog(controller.fitur);
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
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: backgroundColor2,
            title: const Text("Entry Pakan"),
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
                            : pakanState.selectedFeedList.isNotEmpty
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

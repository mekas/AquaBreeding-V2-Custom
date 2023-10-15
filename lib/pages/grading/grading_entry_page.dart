import 'dart:developer';

import 'package:fish/pages/grading/grading_entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../widgets/text_field_widget.dart';
import '../component/fish_list_card.dart';
import '../pond/detail_pond_controller.dart';
import 'grading_controller.dart';

class GradingEntryPage extends StatefulWidget {
  const GradingEntryPage({Key? key}) : super(key: key);

  @override
  State<GradingEntryPage> createState() => _GradingEntryPageState();
}

class _GradingEntryPageState extends State<GradingEntryPage> {
  var isMenuTapped = false.obs;
  @override
  Widget build(BuildContext context) {
    final GradingEntryController controller = Get.put(GradingEntryController());
    final GradingController gradingcontroller = Get.put(GradingController());
    final DetailPondController detailPondController = Get.find();

    Widget fishTypelInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis Ikan',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Obx(() => DropdownButtonFormField<String>(
                  onChanged: (newValue) =>
                      controller.fishTypeController.setSelected(newValue!),
                  value: controller.fishTypeController.selected.value,
                  items: controller.listFishAlive.map((fish) {
                    return DropdownMenuItem<String>(
                      value: fish,
                      child: Text(
                        fish,
                        style: primaryTextStyle,
                      ),
                    );
                  }).toList(),
                  dropdownColor: backgroundColor5,
                  decoration: InputDecoration(border: InputBorder.none),
                )),
              ),
            ),
          ],
        ),
      );
    }

    Widget fishInfo() {
      return Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryColor),
              color: transparentColor,
            ),
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jumlah Ikan",
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Divider(color: Colors.white),
                Column(
                  children:
                  detailPondController.selectedActivation.value.fishLive!
                      .map(
                        (fish) => FishListCard(fish: fish),
                  )
                      .toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Ikan",
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "${detailPondController.selectedActivation.value.fishAmount.toString()} Ekor",
                      style: purpleTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Berat",
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      detailPondController
                          .selectedActivation.value.totalWeightFishAlive!
                          .toStringAsFixed(2) +
                          " Kg",
                      style: purpleTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30)
        ],
      );
    }

    Widget sampleAmountInput() {
      return Container(
        margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jumlah Sample (Ekor)',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                Text(
                  controller.persentageSample.toStringAsFixed(2) + '%',
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium, color: Colors.green),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Obx(() {
                return TextFormField(
                  style: primaryTextStyle,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (newValue) {
                    controller.updatePersentageSample();
                  },
                  controller: controller.sampleAmountController,
                  decoration: controller.validatesampleAmount.value == true
                      ? controller.sampleAmount == ''
                      ? InputDecoration(
                      errorText: 'jumlah ikan tidak boleh kosong',
                      isCollapsed: true)
                      : InputDecoration.collapsed(
                      hintText: 'ex: 20', hintStyle: subtitleTextStyle)
                      : InputDecoration.collapsed(
                      hintText: 'ex: 20', hintStyle: subtitleTextStyle),
                );
              })),
            ),
          ],
        ),
      );
    }

    Widget fishWightInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Berat Total Sample (Kg)',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: TextFormField(
                  style: primaryTextStyle,
                  keyboardType: TextInputType.number,
                  // onChanged: controller.fishWeightChanged,
                  // onTap: controller.valfishWeight,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                  ],
                  controller: controller.fishWeightController,
                  decoration: InputDecoration.collapsed(
                      hintText: 'ex: 2.1', hintStyle: subtitleTextStyle),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget fishLengthAvgInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Panjang Rata-rata (cm) (Opsional)',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Center(
                    child: TextFormField(
                      style: primaryTextStyle,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                      ],
                      keyboardType: TextInputType.number,
                      controller: controller.fishLengthAvgController,
                      decoration: InputDecoration.collapsed(
                          hintText: 'ex: 23', hintStyle: subtitleTextStyle),
                    )),
              ),
            ),
          ],
        ),
      );
    }

    Widget undersizeInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah Ikan Undersize (Ekor) (Opsional)',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Center(
                    child: TextFormField(
                      style: primaryTextStyle,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: controller.undersizeController,
                      decoration: InputDecoration.collapsed(
                          hintText: 'ex: 23', hintStyle: subtitleTextStyle),
                    )),
              ),
            ),
          ],
        ),
      );
    }

    Widget oversizeInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah Ikan Oversize (Ekor) (Opsional)',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Center(
                    child: TextFormField(
                      style: primaryTextStyle,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: controller.oversizeController,
                      decoration: InputDecoration.collapsed(
                          hintText: 'ex: 4', hintStyle: subtitleTextStyle),
                    )),
              ),
            ),
          ],
        ),
      );
    }

    Widget normalsizeInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah Ikan Normalsize (Ekor) (Opsional)',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: TextFormField(
                    style: primaryTextStyle,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    controller: controller.normalsizeController,
                    decoration: InputDecoration.collapsed(
                        hintText: 'ex: 23', hintStyle: subtitleTextStyle),
                  )),
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
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: TextButton(
          onPressed: () async {
            Map<String, dynamic> result = controller.validationInput();
            if (result['isValid'] == false) {
              Get.snackbar('Input Salah', result['message'],
                  titleText: Text(
                    'Input Salah',
                    style: alertTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  messageText: Text(
                    result['message'],
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  backgroundColor: backgroundColor1);
            } else {
              await controller.postFishGrading();
              // update chart
              // await gradingcontroller.getFishGradingChart(
              //     activation_id: controller.activation.id.toString());
              // update list
              await gradingcontroller.getFishGrading(
                  activation_id: controller.activation.id.toString());
              await controller.postDataLog(controller.fitur);
              Get.back();
            }
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
            title: Text("Entry Grading ${controller.pond.alias}"),
          ),
          backgroundColor: backgroundColor1,
          body: ListView(
            children: [
              SizedBox(
                height: defaultMargin,
              ),
              fishInfo(),
              sampleAmountInput(),
              fishWightInput(),
              fishLengthAvgInput(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 4, horizontal: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: controller.checkUsedDate.value,
                          onChanged: (v) {
                            controller.checkUsedDate.value = v!;
                            controller.selectedUsedDate.value = '';
                            controller.showedUsedDate.clear();
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Aktifkan tanggal grading manual',
                              style: headingText3,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    controller.checkUsedDate.value
                        ? GestureDetector(
                      onTap: () async {
                        final DateTime? datePicker =
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );

                        // ignore: use_build_context_synchronously
                        if (datePicker != null) {
                          final TimeOfDay? selectedTime =
                          await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                datePicker!),
                            builder: (context, child) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(
                                    alwaysUse24HourFormat:
                                    true),
                                child: child!,
                              );
                            },
                          );

                          if (selectedTime != null) {
                            // Define the format for parsing

                            // Define the format for parsing the input date and time string
                            String inputFormatStr =
                                'EEEE, d MMMM yyyy | \'Jam\' HH:mm:ss.SSS';
                            DateTime dateTime = DateFormat(
                                inputFormatStr, 'id_ID')
                                .parse(
                                '${controller.dateFormat(datePicker.toString(), false)} | Jam ${selectedTime!.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}:00.000');

                            // Define the format for formatting the date into the desired format
                            String outputFormatStr =
                                'yyyy-MM-ddTHH:mm:ss.SSS';
                            String formattedDateTime =
                            DateFormat(outputFormatStr)
                                .format(dateTime);

                            inspect(DateTime.now().toString());

                            controller.selectedUsedDate
                                .value = datePicker ==
                                null
                                ? ''
                                : '$formattedDateTime +0000';

                            controller.showedUsedDate
                                .text = datePicker ==
                                null
                                ? ''
                                : '${controller.dateFormat(datePicker.toString(), false)} | Jam ${selectedTime!.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}';

                            inspect(controller
                                .selectedUsedDate.value);
                          }
                        }
                      },
                      child: TextFieldWidget(
                        label: 'Pilih Tanggal',
                        controller: controller.showedUsedDate,
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
              ),
              submitButton(),
              SizedBox(
                height: 8,
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

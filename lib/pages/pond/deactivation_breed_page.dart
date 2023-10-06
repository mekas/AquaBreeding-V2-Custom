import 'dart:developer';

import 'package:fish/pages/component/deactivation_list_input.dart';
import 'package:fish/pages/dashboard.dart';
import 'package:fish/pages/pond/deactivation_breed_controller.dart';
import 'package:fish/pages/pond/detail_pond_controller.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widgets/new_Menu_widget.dart';

class DeactivationBreedPage extends StatefulWidget {
  DeactivationBreedPage({Key? key}) : super(key: key);
  @override
  State<DeactivationBreedPage> createState() => _DeactivationBreedPageState();
}

class _DeactivationBreedPageState extends State<DeactivationBreedPage> {
  final DeactivationBreedController controller =
      Get.put(DeactivationBreedController());

  final DetailPondController detailPondController =
      Get.put(DetailPondController());

  final detailController = Get.put(DetailPondController());

  var currDate = DateTime.now();
  var isMenuTapped = false.obs;

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    var currMonth = DateTime.now().month;
    var currYear = DateTime.now().year;
    int lastday = DateTime(now.year, now.month + 1, 0).day;

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await controller.getPondActivations(
    //       pondId: controller.pond.id.toString());
    // });
    controller.getAllInventory(
      controller.pond.lastActivationDate
          .toString()
          .split('-')
          .reversed
          .join('-'),
      currDate.toString().split(' ')[0],
    );
    // inspect(currDate);
    controller.pondName.value = 'kolam ${detailController.pondController.selectedPond.value.alias}';
    controller.getHarvestedBool(detailPondController.activations[0]);
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    Widget activationButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: TextButton(
          onPressed: () async {
            // Get.back();
            await controller.pondDeactivation(
              context,
              () {
                detailPondController.getPondActivation();
              },
            );
            // detailPondController.isPondActive.value = false;
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Panen  ',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    Widget deactivationInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: detailPondController.activations.isEmpty
            ? Container()
            : ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemBuilder: ((context, index) {
                  return DeactivationListCard(
                      fish:
                          detailPondController.activations[0].fishLive[index]);
                }),
                itemCount: detailPondController.activations[0].fishLive.length,
              ),
      );
    }

    Widget sampleAmountInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah Sample (Ekor) (Opsional)',
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
                    controller: controller.sampleAmountController,
                    decoration: InputDecoration.collapsed(
                        hintText: 'ex: 20', hintStyle: subtitleTextStyle)),
              ),
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
              'Berat Rata-rata Ikan (Kg) (Opsional)',
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
                    FilteringTextInputFormatter.deny(RegExp(r'[-,\s]'))
                  ],
                  keyboardType: TextInputType.number,
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
                child: TextFormField(
                  style: primaryTextStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp(r'[-,\s]'))
                  ],
                  controller: controller.fishLengthAvgController,
                  decoration: InputDecoration.collapsed(
                      hintText: 'ex: 11', hintStyle: subtitleTextStyle),
                ),
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
                child: TextFormField(
                  style: primaryTextStyle,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  controller: controller.undersizeController,
                  decoration: InputDecoration.collapsed(
                      hintText: 'ex: 2', hintStyle: subtitleTextStyle),
                ),
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
                child: TextFormField(
                  style: primaryTextStyle,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  controller: controller.oversizeController,
                  decoration: InputDecoration.collapsed(
                      hintText: 'ex: 4', hintStyle: subtitleTextStyle),
                ),
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
              'Jumlah Ikan Normalsize (Ekor)(Opsional)',
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
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Obx(() {
      if (controller.isDeactivationProgress.value == false) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: backgroundColor2,
            title: const Text("Panen"),
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
                Column(
                  children: [
                    newMenu(),
                    SizedBox(height: 10,),
                  ],
                ),
              controller.isLoadingInventory.value
                  ? Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    )
                  : deactivationInput(),
              // waterHeightInput(),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
              ),
              sampleAmountInput(),
              fishLengthAvgInput(),
              fishWightInput(),
              normalsizeInput(),
              undersizeInput(),
              oversizeInput(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
                              'Aktifkan tanggal panen manual',
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
                              final DateTime? datePicker = await showDatePicker(
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
                                  initialTime:
                                      TimeOfDay.fromDateTime(datePicker!),
                                  builder: (context, child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
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
                                          '${controller.dateFormat(datePicker.toString(), false)} | Jam ${selectedTime!.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}:00.000');

                                  // Define the format for formatting the date into the desired format
                                  String outputFormatStr =
                                      'yyyy-MM-ddTHH:mm:ss.SSS';
                                  String formattedDateTime =
                                      DateFormat(outputFormatStr)
                                          .format(dateTime);

                                  controller.selectedUsedDate.value =
                                      datePicker == null
                                          ? ''
                                          : '$formattedDateTime +0000';

                                  controller.showedUsedDate.text = datePicker ==
                                          null
                                      ? ''
                                      : '${controller.dateFormat(datePicker.toString(), false)} | Jam ${selectedTime!.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}';
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
              controller.isLoadingInventory.value
                  ? Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    )
                  : activationButton(),

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

import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/pond/activation_breed_controller.dart';
import 'package:fish/pages/pond/detail_pond_controller.dart';
import 'package:fish/pages/pond/detail_pond_page.dart';
import 'package:fish/service/pond_service.dart';
import 'package:fish/service/activation_service.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_state.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../component/detail_pond_tabview.dart';

class ActivationBreedPage extends StatefulWidget {
  ActivationBreedPage({Key? key}) : super(key: key);

  @override
  State<ActivationBreedPage> createState() => _ActivationBreedPageState();
}

class _ActivationBreedPageState extends State<ActivationBreedPage> {
  final ActivationBreedController controller =
      Get.put(ActivationBreedController());

  final DetailPondController detailPondController =
      Get.put(DetailPondController());

  final InventarisBenihState benihState = Get.put(InventarisBenihState());

  TextEditingController dump = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    benihState.getAllSeedData('benih');

    benihState.selectedUsedDate.value = '';
    controller.breedOptionController.selected.value = 'Benih';

    controller.leleAmountController.text = '';
    controller.masAmountController.text = '';
    controller.patinAmountController.text = '';
    controller.nilaMerahAmountController.text = '';
    controller.nilaHitamAmountController.text = '';

    controller.isLele.value = false;
    controller.isNilaHitam.value = false;
    controller.isNilaMerah.value = false;
    controller.isPatin.value = false;
    controller.isMas.value = false;

    benihState.isLeleSelected.value = false;
    benihState.isNilaHitamSelected.value = false;
    benihState.isNilaMerahSelected.value = false;
    benihState.isPatinSelected.value = false;
    benihState.isMasSelected.value = false;
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    Widget checkBoxFish() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Ikan',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            benihState.listNilaHitam.isEmpty &&
                    benihState.listNilaMerah.isEmpty &&
                    benihState.listLele.isEmpty &&
                    benihState.listMas.isEmpty &&
                    benihState.listPatin.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada data',
                      style: headingText3.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  )
                : Container(),
            benihState.listNilaHitam.isEmpty
                ? Container()
                : Theme(
                    data: Theme.of(context)
                        .copyWith(unselectedWidgetColor: Colors.white),
                    child: CheckboxListTile(
                      title: Text(
                        'Nila Hitam',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      checkColor: Colors.white, // color of tick Mark
                      activeColor: primaryColor,
                      value: controller.isNilaHitam.value,
                      onChanged: (bool? value) async {
                        controller.setNilaHitam(value!);
                        benihState.isNilaHitamSelected.value = true;
                        await benihState.getNilaHitamDetail(
                            benihState.selectedNilaHitam.value['id'], () {
                          controller.calculatedNilaHitamStock.value =
                              int.parse(benihState.nilaHitamFishStock.value);
                        });
                      },
                    ),
                  ),
            benihState.listNilaMerah.isEmpty
                ? Container()
                : Theme(
                    data: Theme.of(context)
                        .copyWith(unselectedWidgetColor: Colors.white),
                    child: CheckboxListTile(
                      title: Text(
                        'Nila Merah',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      checkColor: Colors.white, // color of tick Mark
                      activeColor: primaryColor,
                      value: controller.isNilaMerah.value,
                      onChanged: (bool? value) async {
                        controller.setNilaMerah(value!);
                        benihState.isNilaMerahSelected.value = true;
                        await benihState.getNilaMerahDetail(
                            benihState.selectedNilaMerah.value['id'], () {
                          controller.calculatedNilaMerahStock.value =
                              int.parse(benihState.nilaMerahFishStock.value);
                        });
                      },
                    ),
                  ),
            benihState.listLele.isEmpty
                ? Container()
                : Theme(
                    data: Theme.of(context)
                        .copyWith(unselectedWidgetColor: Colors.white),
                    child: CheckboxListTile(
                      title: Text(
                        'Lele',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      checkColor: Colors.white, // color of tick Mark
                      activeColor: primaryColor,
                      value: controller.isLele.value,
                      onChanged: (bool? value) async {
                        controller.setLele(value!);
                        benihState.isLeleSelected.value = true;
                        await benihState.getLeleDetail(
                            benihState.selectedLele.value['id'], () {
                          controller.calculatedLeleStock.value =
                              int.parse(benihState.leleFishStock.value);
                        });
                      },
                    ),
                  ),
            benihState.listPatin.isEmpty
                ? Container()
                : Theme(
                    data: Theme.of(context)
                        .copyWith(unselectedWidgetColor: Colors.white),
                    child: CheckboxListTile(
                      title: Text(
                        'Patin',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      checkColor: Colors.white, // color of tick Mark
                      activeColor: primaryColor,
                      value: controller.isPatin.value,
                      onChanged: (bool? value) async {
                        controller.setPatin(value!);
                        benihState.isPatinSelected.value = true;
                        await benihState.getPatinDetail(
                            benihState.selectedPatin.value['id'], () {
                          controller.calculatedPatinStock.value =
                              int.parse(benihState.patinFishStock.value);
                        });
                      },
                    ),
                  ),
            benihState.listMas.isEmpty
                ? Container()
                : Theme(
                    data: Theme.of(context)
                        .copyWith(unselectedWidgetColor: Colors.white),
                    child: CheckboxListTile(
                      title: Text(
                        'Mas',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      checkColor: Colors.white, // color of tick Mark
                      activeColor: primaryColor,
                      value: controller.isMas.value,
                      onChanged: (bool? value) async {
                        controller.setMas(value!);
                        benihState.isMasSelected.value = true;
                        await benihState.getMasDetail(
                            benihState.selectedMas.value['id'], () {
                          controller.calculatedMasStock.value =
                              int.parse(benihState.masFishStock.value);
                        });
                      },
                    ),
                  ),
          ],
        ),
      );
    }

    Widget waterHeightInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tinggi air (meter)',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
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
                    FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                  ],
                  keyboardType: TextInputType.number,
                  controller: controller.waterHeightController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'ex: 2',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget leleInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lele',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: DropdownButtonFormField<Map<String, dynamic>>(
                  onChanged: (newValue) async {
                    benihState.selectedLele.value = newValue!;

                    controller.leleSeedIDController.value = newValue['seed_id'];
                    inspect(newValue);
                    await benihState.getLeleDetail(newValue['id'], () {
                      controller.calculatedLeleStock.value =
                          int.parse(benihState.leleFishStock.value);
                    });
                  },
                  value: benihState.selectedLele.value,
                  items: benihState.listLele
                      .map<DropdownMenuItem<Map<String, dynamic>>>((material) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: material,
                      child: Text(
                        material['fishName'],
                        style: primaryTextStyle,
                      ),
                    );
                  }).toList(),
                  dropdownColor: backgroundColor5,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 16),
            benihState.isLoadingLeleDetail.value
                ? Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : benihState.isLeleSelected.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.breedOptionController.selected.value ==
                                      'Benih'
                                  ? TextFieldWidget(
                                      label: 'Ukuran Sortir',
                                      controller: dump,
                                      isLong: false,
                                      isEdit: false,
                                      hint: benihState.leleFishSize.value == ''
                                          ? '-'
                                          : benihState.leleFishSize.value,
                                      isHintStyle: true,
                                      styleHint:
                                          const TextStyle(color: Colors.white),
                                      suffixSection: Text(
                                        'cm',
                                        style: headingText3,
                                      ),
                                    )
                                  : TextFieldWidget(
                                      label: 'Berat Ikan',
                                      controller: dump,
                                      isLong: false,
                                      isEdit: false,
                                      hint:
                                          benihState.leleFishWeigth.value == ''
                                              ? '-'
                                              : benihState.leleFishWeigth.value,
                                      isHintStyle: true,
                                      styleHint:
                                          const TextStyle(color: Colors.white),
                                      suffixSection: Text(
                                        'kg',
                                        style: headingText3,
                                      ),
                                    ),
                              TextFieldWidget(
                                label: 'Stok Benih',
                                controller: dump,
                                isLong: false,
                                isEdit: false,
                                hint: benihState.leleFishStock.value == ''
                                    ? '-'
                                    : benihState.leleFishStock.value,
                                isHintStyle: true,
                                styleHint: const TextStyle(color: Colors.white),
                                suffixSection: Text(
                                  'ekor',
                                  style: headingText3,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return TextFieldWidget(
                                label: 'Jumlah Ikan',
                                controller: controller.leleAmountController,
                                hint: 'Ex: 100',
                                numberOutput: true,
                                onChange: (v) {
                                  if (int.parse(
                                              benihState.leleFishStock.value) -
                                          int.parse(controller
                                                      .leleAmountController
                                                      .text ==
                                                  ''
                                              ? '0'
                                              : controller
                                                  .leleAmountController.text) <
                                      0) {
                                    Flushbar(
                                      message:
                                          "Tidak boleh kurang dari stok tersedia",
                                      duration: Duration(seconds: 2),
                                      leftBarIndicatorColor: Colors.red,
                                    ).show(context);
                                  }
                                  setState(() {
                                    controller
                                        .calculatedLeleStock.value = int.parse(
                                            benihState.leleFishStock.value) -
                                        int.parse(controller
                                                    .leleAmountController
                                                    .text ==
                                                ''
                                            ? '0'
                                            : controller
                                                .leleAmountController.text);
                                  });
                                },
                                suffixSection: Text(
                                  'ekor',
                                  style: headingText3,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Sisa Stok : ${controller.calculatedLeleStock.value}',
                            style: headingText3.copyWith(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      )
                    : Container(),
          ],
        ),
      );
    }

    Widget nilaMerahInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nila Merah',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: DropdownButtonFormField<Map<String, dynamic>>(
                  onChanged: (newValue) async {
                    benihState.selectedNilaMerah.value = newValue!;
                    controller.nilaMerahSeedIDController.value =
                        newValue['seed_id'];
                    await benihState.getNilaMerahDetail(newValue['id'], () {
                      controller.calculatedNilaMerahStock.value =
                          int.parse(benihState.nilaMerahFishStock.value);
                    });
                  },
                  value: benihState.selectedNilaMerah.value,
                  items: benihState.listNilaMerah
                      .map<DropdownMenuItem<Map<String, dynamic>>>((material) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: material,
                      child: Text(
                        material['fishName'],
                        style: primaryTextStyle,
                      ),
                    );
                  }).toList(),
                  dropdownColor: backgroundColor5,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 16),
            benihState.isLoadingNilaMerahDetail.value
                ? Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : benihState.isNilaMerahSelected.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.breedOptionController.selected.value ==
                                      'Benih'
                                  ? TextFieldWidget(
                                      label: 'Ukuran Sortir',
                                      controller: dump,
                                      isLong: false,
                                      isEdit: false,
                                      hint: benihState
                                                  .nilaMerahFishSize.value ==
                                              ''
                                          ? '-'
                                          : benihState.nilaMerahFishSize.value,
                                      isHintStyle: true,
                                      styleHint:
                                          const TextStyle(color: Colors.white),
                                      suffixSection: Text(
                                        'cm',
                                        style: headingText3,
                                      ),
                                    )
                                  : TextFieldWidget(
                                      label: 'Berat Ikan',
                                      controller: dump,
                                      isLong: false,
                                      isEdit: false,
                                      hint: benihState
                                                  .nilaMerahFishWeigth.value ==
                                              ''
                                          ? '-'
                                          : benihState
                                              .nilaMerahFishWeigth.value,
                                      isHintStyle: true,
                                      styleHint:
                                          const TextStyle(color: Colors.white),
                                      suffixSection: Text(
                                        'kg',
                                        style: headingText3,
                                      ),
                                    ),
                              TextFieldWidget(
                                label: 'Stok Benih',
                                controller: dump,
                                isLong: false,
                                isEdit: false,
                                hint: benihState.nilaMerahFishStock.value == ''
                                    ? '-'
                                    : benihState.nilaMerahFishStock.value,
                                isHintStyle: true,
                                styleHint: const TextStyle(color: Colors.white),
                                suffixSection: Text(
                                  'ekor',
                                  style: headingText3,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return TextFieldWidget(
                                label: 'Jumlah Ikan',
                                controller:
                                    controller.nilaMerahAmountController,
                                hint: 'Ex: 100',
                                numberOutput: true,
                                onChange: (v) {
                                  if (int.parse(benihState
                                              .nilaMerahFishStock.value) -
                                          int.parse(controller
                                                      .nilaMerahAmountController
                                                      .text ==
                                                  ''
                                              ? '0'
                                              : controller
                                                  .nilaMerahAmountController
                                                  .text) <
                                      0) {
                                    Flushbar(
                                      message:
                                          "Tidak boleh kurang dari stok tersedia",
                                      duration: Duration(seconds: 2),
                                      leftBarIndicatorColor: Colors.red,
                                    ).show(context);
                                  }
                                  setState(() {
                                    controller.calculatedNilaMerahStock
                                        .value = int.parse(benihState
                                            .nilaMerahFishStock.value) -
                                        int.parse(controller
                                                    .nilaMerahAmountController
                                                    .text ==
                                                ''
                                            ? '0'
                                            : controller
                                                .nilaMerahAmountController
                                                .text);
                                  });
                                },
                                suffixSection: Text(
                                  'ekor',
                                  style: headingText3,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Sisa Stok : ${controller.calculatedNilaMerahStock.value}',
                            style: headingText3.copyWith(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      )
                    : Container(),
          ],
        ),
      );
    }

    Widget nilaHitamInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nila Hitam',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: DropdownButtonFormField<Map<String, dynamic>>(
                  onChanged: (newValue) async {
                    benihState.selectedNilaHitam.value = newValue!;
                    controller.nilaHitamSeedIDController.value =
                        newValue['seed_id'];
                    await benihState.getNilaHitamDetail(newValue['id'], () {
                      controller.calculatedNilaHitamStock.value =
                          int.parse(benihState.nilaHitamFishStock.value);
                    });
                  },
                  value: benihState.selectedNilaHitam.value,
                  items: benihState.listNilaHitam
                      .map<DropdownMenuItem<Map<String, dynamic>>>((material) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: material,
                      child: Text(
                        material['fishName'],
                        style: primaryTextStyle,
                      ),
                    );
                  }).toList(),
                  dropdownColor: backgroundColor5,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 16),
            benihState.isLoadingNilaHitamDetail.value
                ? Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : benihState.isNilaHitamSelected.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.benihOptionController.selected.value ==
                                      'Benih'
                                  ? TextFieldWidget(
                                      label: 'Ukuran Sortir',
                                      controller: dump,
                                      isLong: false,
                                      isEdit: false,
                                      hint: benihState
                                                  .nilaHitamFishSize.value ==
                                              ''
                                          ? '-'
                                          : benihState.nilaHitamFishSize.value,
                                      isHintStyle: true,
                                      styleHint:
                                          const TextStyle(color: Colors.white),
                                      suffixSection: Text(
                                        'cm',
                                        style: headingText3,
                                      ),
                                    )
                                  : TextFieldWidget(
                                      label: 'Berat Ikan',
                                      controller: dump,
                                      isLong: false,
                                      isEdit: false,
                                      hint: benihState
                                                  .nilaHitamFishWeigth.value ==
                                              ''
                                          ? '-'
                                          : benihState
                                              .nilaHitamFishWeigth.value,
                                      isHintStyle: true,
                                      styleHint:
                                          const TextStyle(color: Colors.white),
                                      suffixSection: Text(
                                        'kg',
                                        style: headingText3,
                                      ),
                                    ),
                              TextFieldWidget(
                                label: 'Stok Benih',
                                controller: dump,
                                isLong: false,
                                isEdit: false,
                                hint: benihState.nilaHitamFishStock.value == ''
                                    ? '-'
                                    : benihState.nilaHitamFishStock.value,
                                isHintStyle: true,
                                styleHint: const TextStyle(color: Colors.white),
                                suffixSection: Text(
                                  'ekor',
                                  style: headingText3,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return TextFieldWidget(
                                label: 'Jumlah Ikan',
                                controller:
                                    controller.nilaHitamAmountController,
                                hint: 'Ex: 100',
                                numberOutput: true,
                                onChange: (v) {
                                  if (int.parse(benihState
                                              .nilaHitamFishStock.value) -
                                          int.parse(controller
                                                      .nilaHitamAmountController
                                                      .text ==
                                                  ''
                                              ? '0'
                                              : controller
                                                  .nilaHitamAmountController
                                                  .text) <
                                      0) {
                                    Flushbar(
                                      message:
                                          "Tidak boleh kurang dari stok tersedia",
                                      duration: Duration(seconds: 2),
                                      leftBarIndicatorColor: Colors.red,
                                    ).show(context);
                                  }
                                  setState(() {
                                    controller.calculatedNilaHitamStock
                                        .value = int.parse(benihState
                                            .nilaHitamFishStock.value) -
                                        int.parse(controller
                                                    .nilaHitamAmountController
                                                    .text ==
                                                ''
                                            ? '0'
                                            : controller
                                                .nilaHitamAmountController
                                                .text);
                                  });
                                },
                                suffixSection: Text(
                                  'ekor',
                                  style: headingText3,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Sisa Stok : ${controller.calculatedNilaHitamStock.value}',
                            style: headingText3.copyWith(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      )
                    : Container(),
          ],
        ),
      );
    }

    Widget patinInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patin',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: DropdownButtonFormField<Map<String, dynamic>>(
                  onChanged: (newValue) async {
                    benihState.selectedPatin.value = newValue!;
                    controller.patinSeedIDController.value =
                        newValue['seed_id'];
                    await benihState.getPatinDetail(newValue['id'], () {
                      controller.calculatedPatinStock.value =
                          int.parse(benihState.patinFishStock.value);
                    });
                  },
                  value: benihState.selectedPatin.value,
                  items: benihState.listPatin
                      .map<DropdownMenuItem<Map<String, dynamic>>>((material) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: material,
                      child: Text(
                        material['fishName'],
                        style: primaryTextStyle,
                      ),
                    );
                  }).toList(),
                  dropdownColor: backgroundColor5,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 16),
            benihState.isLoadingPatinDetail.value
                ? Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : benihState.isPatinSelected.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.benihOptionController.selected.value ==
                                      'Benih'
                                  ? TextFieldWidget(
                                      label: 'Ukuran Sortir',
                                      controller: dump,
                                      isLong: false,
                                      isEdit: false,
                                      hint: benihState.patinFishSize.value == ''
                                          ? '-'
                                          : benihState.patinFishSize.value,
                                      isHintStyle: true,
                                      styleHint:
                                          const TextStyle(color: Colors.white),
                                      suffixSection: Text(
                                        'cm',
                                        style: headingText3,
                                      ),
                                    )
                                  : TextFieldWidget(
                                      label: 'Berat Ikan',
                                      controller: dump,
                                      isLong: false,
                                      isEdit: false,
                                      hint: benihState.patinFishWeigth.value ==
                                              ''
                                          ? '-'
                                          : benihState.patinFishWeigth.value,
                                      isHintStyle: true,
                                      styleHint:
                                          const TextStyle(color: Colors.white),
                                      suffixSection: Text(
                                        'kg',
                                        style: headingText3,
                                      ),
                                    ),
                              TextFieldWidget(
                                label: 'Stok Benih',
                                controller: dump,
                                isLong: false,
                                isEdit: false,
                                hint: benihState.patinFishStock.value == ''
                                    ? '-'
                                    : benihState.patinFishStock.value,
                                isHintStyle: true,
                                styleHint: const TextStyle(color: Colors.white),
                                suffixSection: Text(
                                  'ekor',
                                  style: headingText3,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return TextFieldWidget(
                                label: 'Jumlah Ikan',
                                controller: controller.patinAmountController,
                                hint: 'Ex: 100',
                                numberOutput: true,
                                onChange: (v) {
                                  if (int.parse(
                                              benihState.patinFishStock.value) -
                                          int.parse(controller
                                                      .patinAmountController
                                                      .text ==
                                                  ''
                                              ? '0'
                                              : controller
                                                  .patinAmountController.text) <
                                      0) {
                                    Flushbar(
                                      message:
                                          "Tidak boleh kurang dari stok tersedia",
                                      duration: Duration(seconds: 2),
                                      leftBarIndicatorColor: Colors.red,
                                    ).show(context);
                                  }
                                  setState(() {
                                    controller
                                        .calculatedPatinStock.value = int.parse(
                                            benihState.patinFishStock.value) -
                                        int.parse(controller
                                                    .patinAmountController
                                                    .text ==
                                                ''
                                            ? '0'
                                            : controller
                                                .patinAmountController.text);
                                  });
                                },
                                suffixSection: Text(
                                  'ekor',
                                  style: headingText3,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Sisa Stok : ${controller.calculatedPatinStock.value}',
                            style: headingText3.copyWith(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      )
                    : Container(),
          ],
        ),
      );
    }

    Widget masInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mas',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: DropdownButtonFormField<Map<String, dynamic>>(
                  onChanged: (newValue) async {
                    benihState.selectedMas.value = newValue!;
                    controller.masSeedIDController.value = newValue['seed_id'];
                    await benihState.getMasDetail(newValue['id'], () {
                      controller.calculatedMasStock.value =
                          int.parse(benihState.masFishStock.value);
                    });
                  },
                  value: benihState.selectedMas.value,
                  items: benihState.listMas
                      .map<DropdownMenuItem<Map<String, dynamic>>>((material) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: material,
                      child: Text(
                        material['fishName'],
                        style: primaryTextStyle,
                      ),
                    );
                  }).toList(),
                  dropdownColor: backgroundColor5,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 16),
            benihState.isLoadingMasDetail.value
                ? Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : benihState.isMasSelected.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.breedOptionController.selected.value ==
                                      'Benih'
                                  ? TextFieldWidget(
                                      label: 'Ukuran Sortir',
                                      controller: dump,
                                      isLong: false,
                                      isEdit: false,
                                      hint: benihState.masFishSize.value == ''
                                          ? '-'
                                          : benihState.masFishSize.value,
                                      isHintStyle: true,
                                      styleHint:
                                          const TextStyle(color: Colors.white),
                                      suffixSection: Text(
                                        'cm',
                                        style: headingText3,
                                      ),
                                    )
                                  : TextFieldWidget(
                                      label: 'Berat Ikan',
                                      controller: dump,
                                      isLong: false,
                                      isEdit: false,
                                      hint: benihState.masFishWeigth.value == ''
                                          ? '-'
                                          : benihState.masFishWeigth.value,
                                      isHintStyle: true,
                                      styleHint:
                                          const TextStyle(color: Colors.white),
                                      suffixSection: Text(
                                        'kg',
                                        style: headingText3,
                                      ),
                                    ),
                              TextFieldWidget(
                                label: 'Stok Benih',
                                controller: dump,
                                isLong: false,
                                isEdit: false,
                                hint: benihState.masFishStock.value == ''
                                    ? '-'
                                    : benihState.masFishStock.value,
                                isHintStyle: true,
                                styleHint: const TextStyle(color: Colors.white),
                                suffixSection: Text(
                                  'ekor',
                                  style: headingText3,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return TextFieldWidget(
                                label: 'Jumlah Ikan',
                                controller: controller.masAmountController,
                                hint: 'Ex: 100',
                                numberOutput: true,
                                onChange: (v) {
                                  if (int.parse(benihState.masFishStock.value) -
                                          int.parse(controller
                                                      .masAmountController
                                                      .text ==
                                                  ''
                                              ? '0'
                                              : controller
                                                  .masAmountController.text) <
                                      0) {
                                    Flushbar(
                                      message:
                                          "Tidak boleh kurang dari stok tersedia",
                                      duration: Duration(seconds: 2),
                                      leftBarIndicatorColor: Colors.red,
                                    ).show(context);
                                  }
                                  setState(() {
                                    controller.calculatedMasStock.value =
                                        int.parse(
                                                benihState.masFishStock.value) -
                                            int.parse(controller
                                                        .masAmountController
                                                        .text ==
                                                    ''
                                                ? '0'
                                                : controller
                                                    .masAmountController.text);
                                  });
                                },
                                suffixSection: Text(
                                  'ekor',
                                  style: headingText3,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Sisa Stok : ${controller.calculatedMasStock.value}',
                            style: headingText3.copyWith(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      )
                    : Container(),
          ],
        ),
      );
    }

    Widget breedOptionInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategori Ikan',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Obx(() => DropdownButtonFormField<String>(
                      onChanged: (newValue) {
                        benihState.getAllSeedData(newValue!);
                        controller.breedOptionController.setSelected(newValue!);
                        controller.isLele.value = false;
                        controller.isNilaHitam.value = false;
                        controller.isNilaMerah.value = false;
                        controller.isPatin.value = false;
                        controller.isMas.value = false;

                        benihState.isLeleSelected.value = false;
                        benihState.isMasSelected.value = false;
                        benihState.isNilaHitamSelected.value = false;
                        benihState.isPatinSelected.value = false;
                        benihState.isNilaMerahSelected.value = false;
                      },
                      value: controller.breedOptionController.selected.value,
                      items: controller.breedOptionController.listBreed
                          .map((material) {
                        return DropdownMenuItem<String>(
                          value: material,
                          child: Text(
                            material,
                            style: primaryTextStyle,
                          ),
                        );
                      }).toList(),
                      dropdownColor: backgroundColor5,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    )),
              ),
            ),
          ],
        ),
      );
    }

    // Widget pembesaranInput() {
    //   return Container(
    //     margin: EdgeInsets.only(
    //         top: defaultSpace, right: defaultMargin, left: defaultMargin),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Kelas Pembesaran (gram)',
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 16,
    //             fontWeight: medium,
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         Container(
    //           height: 50,
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 16,
    //           ),
    //           decoration: BoxDecoration(
    //             color: backgroundColor2,
    //             borderRadius: BorderRadius.circular(12),
    //           ),
    //           child: Center(
    //             child: TextFormField(
    //               style: primaryTextStyle,
    //               controller: controller.kelasPembesaranController,
    //               decoration: InputDecoration.collapsed(
    //                 hintText: 'ex: 100',
    //                 hintStyle: subtitleTextStyle,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // Widget benihInput() {
    //   return Container(
    //     margin: EdgeInsets.only(
    //         top: defaultSpace, right: defaultMargin, left: defaultMargin),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Kelas Benih (cm)',
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 16,
    //             fontWeight: medium,
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         Container(
    //           height: 50,
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 16,
    //           ),
    //           decoration: BoxDecoration(
    //             color: backgroundColor2,
    //             borderRadius: BorderRadius.circular(12),
    //           ),
    //           child: Center(
    //             child: Obx(() => DropdownButtonFormField<String>(
    //                   onChanged: (newValue) => controller.benihOptionController
    //                       .setSelected(newValue!),
    //                   value: controller.benihOptionController.selected.value,
    //                   items: controller.benihOptionController.listBenih
    //                       .map((material) {
    //                     return DropdownMenuItem<String>(
    //                       value: material,
    //                       child: Text(
    //                         material,
    //                         style: primaryTextStyle,
    //                       ),
    //                     );
    //                   }).toList(),
    //                   dropdownColor: backgroundColor5,
    //                   decoration:
    //                       const InputDecoration(border: InputBorder.none),
    //                 )),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    Widget activationButton() {
      // return Obx(() {
      //   if (controller.isLoading.value == true) {
      //     return CircularProgressIndicator();
      //   }
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace * 3, right: defaultMargin, left: defaultMargin),
        child: TextButton(
          onPressed: () async {
            if (benihState.seedList.value.data!.isEmpty) {
              Flushbar(
                message: "Tidak ada ikan",
                duration: Duration(seconds: 3),
                leftBarIndicatorColor: Colors.red[400],
              ).show(context);
            }
            if (controller.waterHeightController.text == '') {
              Flushbar(
                message: "Gagal, Masukkan tinggi air",
                duration: Duration(seconds: 3),
                leftBarIndicatorColor: Colors.red[400],
              ).show(context);
            } else {
              await controller.pondActivation(
                context,
                () {
                  detailPondController.getPondActivation();
                  Navigator.pop(context);
                },
              );
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Start Budidaya',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
      // };
    }

    return Obx(() => Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: backgroundColor2,
            title: const Text("Aktivasi Kolam"),
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
              waterHeightInput(),
              breedOptionInput(),

              // controller.breedOptionController.selected.value == "Benih"
              //     ? benihInput()
              //     : pembesaranInput(),
              benihState.isLoadingPage.value
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
                        checkBoxFish(),
                        controller.isNilaHitam == true
                            ? nilaHitamInput()
                            : Container(),
                        controller.isNilaMerah == true
                            ? nilaMerahInput()
                            : Container(),
                        controller.isLele == true ? leleInput() : Container(),
                        controller.isPatin == true ? patinInput() : Container(),
                        controller.isMas == true ? masInput() : Container(),
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
                                                    '${benihState.dateFormat(datePicker.toString(), false)} | Jam ${selectedTime!.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}:00.000');

                                            // Define the format for formatting the date into the desired format
                                            String outputFormatStr =
                                                'yyyy-MM-ddTHH:mm:ss.SSS';
                                            String formattedDateTime =
                                                DateFormat(outputFormatStr)
                                                    .format(dateTime);

                                            inspect(DateTime.now().toString());

                                            benihState.selectedUsedDate
                                                .value = datePicker ==
                                                    null
                                                ? ''
                                                : '$formattedDateTime +0000';

                                            benihState.showedUsedDate
                                                .text = datePicker ==
                                                    null
                                                ? ''
                                                : '${benihState.dateFormat(datePicker.toString(), false)} | Jam ${selectedTime!.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}';

                                            inspect(benihState
                                                .selectedUsedDate.value);
                                          }
                                        }
                                      },
                                      child: TextFieldWidget(
                                        label: 'Pilih Tanggal',
                                        controller: benihState.showedUsedDate,
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
                        controller.isActivationProgress.value
                            ? Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                ),
                              )
                            : activationButton(),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),

              const SizedBox(
                height: 8,
              )
            ],
          ),
        ));
  }
}

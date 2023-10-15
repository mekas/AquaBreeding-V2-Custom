// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fish/service/activation_service.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:fish/controllers/fish_transfer/fish_transfer_entry_controller.dart';
import 'package:fish/controllers/fish_transfer/pond_list_item_controller.dart';
import 'package:fish/theme.dart';
import 'package:intl/intl.dart';

import '../../models/fish_model.dart';
import '../../models/new_sortir_model.dart';
import '../../widgets/new_Menu_widget.dart';
import '../component/deactivation_with_fish_transfer_input.dart';

class NewFishTransferInputPage extends StatefulWidget {
  int index;
  ListPondSortir pond;
  NewFishTransferInputPage({
    Key? key,
    required this.index,
    required this.pond,
  }) : super(key: key);
  @override
  State<NewFishTransferInputPage> createState() =>
      _NewFishTransferInputPageState();
}

class _NewFishTransferInputPageState extends State<NewFishTransferInputPage> {
  final FishTransferEntryController controller =
      Get.put(FishTransferEntryController());
  var isMenuTapped = false.obs;

  // final TransferController fishTransferController =
  //     Get.put(TransferController());

  final PondListController getpondlistcontroller =
      Get.put(PondListController());

  final pageController = PageController(initialPage: 0);
  var currDate = DateTime.now();
  @override
  void dispose() {
    controller.descController.clear();
    controller.sampleLongController.clear();
    controller.sampleWeightController.clear();
    controller.leleAmountActivationController.clear();
    controller.leleAmountController.clear();
    controller.leleAmountDeactivationController.clear();
    controller.leleWeightActivationController.clear();
    controller.leleWeightController.clear();
    controller.leleWeightDeactivationController.clear();
    controller.masAmountActivationController.clear();
    controller.masAmountController.clear();
    controller.masAmountDeactivationController.clear();
    controller.masWeightActivationController.clear();
    controller.masWeightController.clear();
    controller.masWeightDeactivationController.clear();
    controller.patinAmountActivationController.clear();
    controller.patinAmountController.clear();
    controller.patinAmountDeactivationController.clear();
    controller.patinWeightActivationController.clear();
    controller.patinWeightController.clear();
    controller.patinWeightDeactivationController.clear();
    controller.nilaMerahAmountActivationController.clear();
    controller.nilaMerahAmountController.clear();
    controller.nilaMerahAmountDeactivationController.clear();
    controller.nilaMerahWeightActivationController.clear();
    controller.nilaMerahWeightController.clear();
    controller.nilaMerahWeightDeactivationController.clear();
    controller.nilaHitamAmountActivationController.clear();
    controller.nilaHitamAmountController.clear();
    controller.nilaHitamAmountDeactivationController.clear();
    controller.nilaHitamWeightActivationController.clear();
    controller.nilaHitamWeightController.clear();
    controller.nilaHitamWeightDeactivationController.clear();
    pageController.dispose();
    controller.postDataLog(controller.fitur);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await controller.getPondActivations(
    //       pondId: controller.pond.id.toString());
    // });
    // controller.getHarvestedBool(controller.activation);
    controller.getPondsData(controller.methodController.toString());
    ActivationService().getActivations(pondId: controller.pond.id.toString()).then((value){
      if (value != null){
        for (var activation in value){
          if (!activation.isFinish!){
            controller.getAllInventory(
                controller.pond.lastActivationDate
                    .toString()
                    .split('-')
                    .reversed
                    .join('-'),
                currDate.toString().split(' ')[0],
                activation
            );
            controller.getHarvestedBool(activation);
          }
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    Widget sampleWeightInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Berat Sample (Gram)',
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
              child: Center(child: Obx(() {
                return TextFormField(
                  style: primaryTextStyle,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: controller.sampleWeightChanged,
                  onTap: controller.valsampleWeight,
                  controller: controller.sampleWeightController,
                  decoration: controller.validatesampleWeight.value == true
                      ? controller.sampleWeight == ''
                          ? InputDecoration(
                              errorText: 'ikan tidak boleh kosong',
                              isCollapsed: true)
                          : null
                      : null,
                );
              })),
            ),
          ],
        ),
      );
    }

    Widget sampleLongInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Panjang Sample (cm)',
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
              child: Center(child: Obx(() {
                return TextFormField(
                  style: primaryTextStyle,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: controller.sampleLongChanged,
                  onTap: controller.valsampleLong,
                  controller: controller.sampleLongController,
                  decoration: controller.validatesampleLong.value == true
                      ? controller.sampleLong == ''
                          ? InputDecoration(
                              errorText: 'jumlah ikan tidak boleh kosong',
                              isCollapsed: true)
                          : null
                      : null,
                );
              })),
            ),
          ],
        ),
      );
    }

    Widget destinationPondInput() {
      return Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.pondlistController.initialLenght.toInt(),
          itemBuilder: (context, index) {
            return Obx(() {
              return Container(
                margin: EdgeInsets.only(
                    top: defaultSpace,
                    right: defaultMargin,
                    left: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kolam Tujuan ${index + 1}',
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
                        child: Obx(() {
                          return DropdownButtonFormField<String>(
                            hint: Text(
                              "Pilih Kolam",
                              style: primaryTextStyle,
                            ),
                            onChanged: ((value) {
                              // controller.pondlistController
                              //     .setSelected(value.toString());
                              print(value);
                              // controller.getDestinationId(value.toString());
                              controller.pondlistController.setSelected(value!);
                            }),
                            // value: ,
                            items: controller.listPondName.map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(
                                  type,
                                  style: primaryTextStyle,
                                ),
                              );
                            }).toList(),
                            dropdownColor: backgroundColor5,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          );
                        }),
                      ),
                    ),
                    if (controller.pondlistController.initialLenght.toInt() ==
                        1) ...[
                      if (controller
                              .pondlistController.listPondSelected.length ==
                          controller.pondlistController.initialLenght
                              .toInt()) ...[
                        Column(
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  controller.pondlistController.initialLenght +
                                      1;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Tambah",
                                    style: primaryTextStyle,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        )
                      ] else ...[
                        SizedBox(
                          height: 16,
                        ),
                      ]
                    ] else ...[
                      if (controller.pondlistController.initialLenght.toInt() ==
                          index + 1) ...[
                        Column(
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      print("111");
                                      controller.pondlistController
                                              .initialLenght +
                                          1;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Tambah",
                                        style: primaryTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (controller.pondlistController
                                              .listPondSelected.length ==
                                          controller
                                              .pondlistController.initialLenght
                                              .toInt()) {
                                        controller
                                            .pondlistController.listPondSelected
                                            .removeLast();
                                      }
                                      controller.pondlistController
                                              .initialLenght -
                                          1;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Hapus",
                                        style: primaryTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ] else ...[
                        Container()
                      ]
                    ]
                  ],
                ),
              );
            });
          },
        );
      });
    }

    Widget transferTypeInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tipe Transfer',
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
                child: Obx(() {
                  return DropdownButtonFormField<String>(
                    onChanged: ((value) {
                      controller.typeController.setSelected(value.toString());
                    }),
                    value: controller.typeController.selected.value,
                    items: controller.typeController.listMethod.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(
                          type,
                          style: primaryTextStyle,
                        ),
                      );
                    }).toList(),
                    dropdownColor: backgroundColor5,
                    decoration: InputDecoration(border: InputBorder.none),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    }

    Widget checkBoxFishTransfer() {
      return Obx(() => Container(
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
                SizedBox(
                  height: 5,
                ),
                controller.isNilaHitam.value
                    ? Theme(
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
                          value: controller.isNilaHitamInput.value,
                          onChanged: (bool? value) {
                            controller.setInputNilaHitam(value!);
                            print("fish seed nila hitam: ${controller.fishSeed.value}");
                            print("fish category nila hitam: ${controller.fishCategory.value}");
                            print(controller.isNilaHitamInput.value);
                          },
                        ),
                      )
                    : Container(),
                controller.isNilaMerah.value
                    ? Theme(
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
                          value: controller.isNilaMerahInput.value,
                          onChanged: (bool? value) {
                            controller.setInputNilaMerah(value!);
                            print("fish seed nila merah: ${controller.fishSeed.value}");
                            print("fish category nila merah: ${controller.fishCategory.value}");
                          },
                        ),
                      )
                    : Container(),
                controller.isLele.value
                    ? Theme(
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
                          value: controller.isLeleInput.value,
                          onChanged: (bool? value) {
                            controller.setInputLele(value!);
                            print("fish seed lele: ${controller.fishSeed.value}");
                            print("fish category lele: ${controller.fishCategory.value}");

                          },
                        ),
                      )
                    : Container(),
                controller.isPatin.value
                    ? Theme(
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
                          value: controller.isPatinInput.value,
                          onChanged: (bool? value) {
                            controller.setInputPatin(value!);
                            print("fish seed patin: ${controller.fishSeed.value}");
                            print("fish category patin: ${controller.fishCategory.value}");
                          },
                        ),
                      )
                    : Container(),
                controller.isMas.value
                    ? Theme(
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
                          value: controller.isMasInput.value,
                          onChanged: (bool? value) {
                            controller.setInputMas(value!);
                            print("fish seed mas: ${controller.fishSeed.value}");
                            print("fish category mas: ${controller.fishCategory.value}");
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ));
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
                  onChanged: controller.leleAmountvalChanged,
                  onTap: controller.valleleAmountval,
                  controller: controller.leleAmountController,
                  decoration: controller.validateleleAmountval.value == true
                      ? controller.leleAmountval == ''
                          ? InputDecoration(
                              errorText: 'tidak boleh kosong',
                              isCollapsed: true)
                          : InputDecoration.collapsed(
                              hintText: 'Jumlah Ikan (Ekor)',
                              hintStyle: subtitleTextStyle)
                      : InputDecoration.collapsed(
                          hintText: 'Jumlah Ikan (Ekor)',
                          hintStyle: subtitleTextStyle),
                );
              })),
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
                    FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: controller.leleWeightvalChanged,
                  onTap: controller.valleleWeightval,
                  controller: controller.leleWeightController,
                  decoration: controller.validateleleWeightval.value == true
                      ? controller.leleWeightval == ''
                          ? InputDecoration(
                              errorText: 'tidak boleh kosong',
                              isCollapsed: true)
                          : InputDecoration.collapsed(
                              hintText: 'Berat Ikan (Kg)',
                              hintStyle: subtitleTextStyle)
                      : InputDecoration.collapsed(
                          hintText: 'Berat Ikan (Kg)',
                          hintStyle: subtitleTextStyle),
                );
              })),
            ),
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
                  onChanged: controller.nilaMerahAmountvalChanged,
                  onTap: controller.valnilaMerahAmountval,
                  controller: controller.nilaMerahAmountController,
                  decoration:
                      controller.validatenilaMerahAmountval.value == true
                          ? controller.nilaMerahAmountval == ''
                              ? InputDecoration(
                                  errorText: 'tidak boleh kosong',
                                  isCollapsed: true)
                              : InputDecoration.collapsed(
                                  hintText: 'Jumlah Ikan (Ekor)',
                                  hintStyle: subtitleTextStyle)
                          : InputDecoration.collapsed(
                              hintText: 'Jumlah Ikan (Ekor)',
                              hintStyle: subtitleTextStyle),
                );
              })),
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
                    FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: controller.nilaMerahWeightvalChanged,
                  onTap: controller.valnilaMerahWeightval,
                  controller: controller.nilaMerahWeightController,
                  decoration:
                      controller.validatenilaMerahWeightval.value == true
                          ? controller.nilaMerahWeightval == ''
                              ? InputDecoration(
                                  errorText: 'tidak boleh kosong',
                                  isCollapsed: true)
                              : InputDecoration.collapsed(
                                  hintText: 'Berat Ikan (Kg)',
                                  hintStyle: subtitleTextStyle)
                          : InputDecoration.collapsed(
                              hintText: 'Berat Ikan (Kg)',
                              hintStyle: subtitleTextStyle),
                );
              })),
            ),
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
                  onChanged: controller.nilaHitamAmountvalChanged,
                  onTap: controller.valnilaHitamAmountval,
                  controller: controller.nilaHitamAmountController,
                  decoration:
                      controller.validatenilaHitamAmountval.value == true
                          ? controller.nilaHitamAmountval == ''
                              ? InputDecoration(
                                  errorText: 'tidak boleh kosong',
                                  isCollapsed: true)
                              : InputDecoration.collapsed(
                                  hintText: 'Jumlah Ikan (Ekor)',
                                  hintStyle: subtitleTextStyle)
                          : InputDecoration.collapsed(
                              hintText: 'Jumlah Ikan (Ekor)',
                              hintStyle: subtitleTextStyle),
                );
              })),
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
                    FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: controller.nilaHitamWeightvalChanged,
                  onTap: controller.valnilaHitamWeightval,
                  controller: controller.nilaHitamWeightController,
                  decoration:
                      controller.validatenilaHitamWeightval.value == true
                          ? controller.nilaHitamWeightval == ''
                              ? InputDecoration(
                                  errorText: 'tidak boleh kosong',
                                  isCollapsed: true)
                              : InputDecoration.collapsed(
                                  hintText: 'Berat Ikan (Kg)',
                                  hintStyle: subtitleTextStyle)
                          : InputDecoration.collapsed(
                              hintText: 'Berat Ikan (Kg)',
                              hintStyle: subtitleTextStyle),
                );
              })),
            ),
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
                  onChanged: controller.patinAmountvalChanged,
                  onTap: controller.valpatinAmountval,
                  controller: controller.patinAmountController,
                  decoration: controller.validatepatinAmountval.value == true
                      ? controller.patinAmountval == ''
                          ? InputDecoration(
                              errorText: 'jumlah ikan tidak boleh kosong',
                              isCollapsed: true)
                          : InputDecoration.collapsed(
                              hintText: 'Jumlah Ikan (Ekor)',
                              hintStyle: subtitleTextStyle)
                      : InputDecoration.collapsed(
                          hintText: 'Jumlah Ikan (Ekor)',
                          hintStyle: subtitleTextStyle),
                );
              })),
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
                    FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: controller.patinWeightvalChanged,
                  onTap: controller.valpatinWeightval,
                  controller: controller.patinWeightController,
                  decoration: controller.validatepatinWeightval.value == true
                      ? controller.patinWeightval == ''
                          ? InputDecoration(
                              errorText: 'tidak boleh kosong',
                              isCollapsed: true)
                          : InputDecoration.collapsed(
                              hintText: 'Berat Ikan (Kg)',
                              hintStyle: subtitleTextStyle)
                      : InputDecoration.collapsed(
                          hintText: 'Berat Ikan (Kg)',
                          hintStyle: subtitleTextStyle),
                );
              })),
            ),
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
                  onChanged: controller.masAmountvalChanged,
                  onTap: controller.valmasAmountval,
                  controller: controller.masAmountController,
                  decoration: controller.validatemasAmountval.value == true
                      ? controller.masAmountval == ''
                          ? InputDecoration(
                              errorText: 'tidak boleh kosong',
                              isCollapsed: true)
                          : InputDecoration.collapsed(
                              hintText: 'Jumlah Ikan (Ekor)',
                              hintStyle: subtitleTextStyle)
                      : InputDecoration.collapsed(
                          hintText: 'Jumlah Ikan (Ekor)',
                          hintStyle: subtitleTextStyle),
                );
              })),
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
                    FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: controller.masWeightvalChanged,
                  onTap: controller.valmasWeightval,
                  controller: controller.masWeightController,
                  decoration: controller.validatemasWeightval.value == true
                      ? controller.masWeightval == ''
                          ? InputDecoration(
                              errorText: 'tidak boleh kosong',
                              isCollapsed: true)
                          : InputDecoration.collapsed(
                              hintText: 'Berat Ikan (Kg)',
                              hintStyle: subtitleTextStyle)
                      : InputDecoration.collapsed(
                          hintText: 'Berat Ikan (Kg)',
                          hintStyle: subtitleTextStyle),
                );
              })),
            ),
          ],
        ),
      );
    }

    // Widget listTransferInput() {
    //   return Container(
    //     width: double.infinity,
    //     margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
    //     child: ListView.builder(
    //       shrinkWrap: true,
    //       primary: false,
    //       itemBuilder: ((context, index) {
    //         return FishTransferInputCard(
    //             fish: controller.activation.fishLive![index]);
    //       }),
    //       itemCount: controller.activation.fishLive!.length,
    //     ),
    //   );
    // }

//input aktivasi
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
            SizedBox(
              height: 5,
            ),
            Theme(
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
                value: controller.isNilaHitamActivation.value,
                onChanged: (bool? value) {
                  controller.setNilaHitam(value!);
                  print(controller.isNilaHitamActivation.value);
                },
              ),
            ),
            Theme(
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
                value: controller.isNilaMerahActivation.value,
                onChanged: (bool? value) {
                  controller.setNilaMerah(value!);
                },
              ),
            ),
            Theme(
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
                value: controller.isLeleActivation.value,
                onChanged: (bool? value) {
                  controller.setLele(value!);
                },
              ),
            ),
            Theme(
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
                value: controller.isPatinActivation.value,
                onChanged: (bool? value) {
                  controller.setPatin(value!);
                },
              ),
            ),
            Theme(
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
                value: controller.isMasActivation.value,
                onChanged: (bool? value) {
                  controller.setMas(value!);
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

    Widget leleInputActivation() {
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
                  controller: controller.leleAmountActivationController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Jumlah Ikan',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
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
                  controller: controller.leleWeightActivationController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berat Total Ikan',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget nilaMerahInputActivation() {
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
                  controller: controller.nilaMerahAmountActivationController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Jumlah Ikan',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
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
                  controller: controller.nilaMerahWeightActivationController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berat Total Ikan',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget nilaHitamInputActivation() {
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
                  controller: controller.nilaHitamAmountActivationController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Jumlah Ikan',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
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
                  controller: controller.nilaHitamWeightActivationController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berat Total Ikan',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget patinInputActivation() {
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
                  controller: controller.patinAmountActivationController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Jumlah Ikan',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
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
                  controller: controller.patinWeightActivationController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berat Total Ikan',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget masInputActivation() {
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
                  controller: controller.masAmountActivationController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Jumlah Ikan',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
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
                  controller: controller.masWeightActivationController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berat Total Ikan',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
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
            // Get.back();
            // await controller.postFishTransferBasah(
            //   context,
            //   () {
            //     Navigator.pop(context);
            //     // fishTransferController.getTransfertData(context);
            //   },
            // );
           if (controller.lelePriceController.text.isNotEmpty){
             print("lele price controller ---------- : ${controller.lelePriceController.text}");
             controller.finalLelePrice.value = int.parse(controller.lelePriceController.text.toString().replaceAll('.', "").split(',')[0]);
           }

            if (controller.nilaMerahPriceController.text.isNotEmpty){
              controller.finalNilaMerahPrice.value = int.parse(controller.nilaMerahPriceController.text.toString().replaceAll('.', "").split(',')[0]);
            }

            if (controller.nilaHitamPriceController.text.isNotEmpty){
              controller.finalNilaHitamPrice.value = int.parse(controller.nilaHitamPriceController.text.toString().replaceAll('.', "").split(',')[0]);
              print("nila hitam price: ${controller.finalNilaHitamPrice.value}");
            }

            if (controller.masPriceController.text.isNotEmpty){
              controller.finalMasPrice.value = int.parse(controller.masPriceController.text.toString().replaceAll('.', "").split(',')[0]);
            }

            if (controller.patinPriceController.text.isNotEmpty){
              controller.finalPatinPrice.value = int.parse(controller.patinPriceController.text.toString().replaceAll('.', "").split(',')[0]);
            }

            if (controller.finalLelePrice.value != 0 && controller.finalLeleTotalPrice.value != 0){
              var formatHarga = NumberFormat("#,###");
              var temp = '${formatHarga.format(controller.finalLelePrice.value)}';
              var temp2 = '${formatHarga.format(controller.finalLeleTotalPrice.value)}';
              var harga = temp.replaceAll(',', '');
              var totalHarga = temp2.replaceAll(',', '');
              print("price each lele: ${harga}");
              print("total price lele: ${totalHarga }");
              print("lele price new_fish_transfer_input_page: ${controller.lelePriceController.text}");
              createData();
              controller.postDataLog(controller.fitur);
            } else if (controller.finalNilaMerahPrice.value != 0 && controller.finalNilaMerahTotalPrice.value != 0){
              var formatHarga = NumberFormat("#,###");
              var temp = '${formatHarga.format(controller.finalNilaMerahPrice.value)}';
              var temp2 = '${formatHarga.format(controller.finalNilaMerahTotalPrice.value)}';
              var harga = temp.replaceAll(',', '');
              var totalHarga = temp2.replaceAll(',', '');
              print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
              print("price each nila merah: ${harga}");
              print("total price nila merah: ${totalHarga }");
              print("nila merah price new_fish_transfer_input_page: ${controller.nilaMerahPriceController.text}");
              createData();
              controller.postDataLog(controller.fitur);
            } else if (controller.finalNilaHitamPrice.value != 0 && controller.finalNilaHitamTotalPrice.value != 0){
              var formatHarga = NumberFormat("#,###");
              var temp = '${formatHarga.format(controller.finalNilaHitamPrice.value)}';
              var temp2 = '${formatHarga.format(controller.finalNilaHitamTotalPrice.value)}';
              var harga = temp.replaceAll(',', '');
              var totalHarga = temp2.replaceAll(',', '');
              print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
              print("price each nila hitam: ${harga}");
              print("total price nila hitam: ${totalHarga }");
              print("nila hitam price new_fish_transfer_input_page: ${controller.nilaMerahPriceController.text}");
              createData();
              controller.postDataLog(controller.fitur);
            } else if (controller.finalPatinPrice.value != 0 && controller.finalPatinTotalPrice.value != 0){
              var formatHarga = NumberFormat("#,###");
              var temp = '${formatHarga.format(controller.finalPatinPrice.value)}';
              var temp2 = '${formatHarga.format(controller.finalPatinTotalPrice.value)}';
              var harga = temp.replaceAll(',', '');
              var totalHarga = temp2.replaceAll(',', '');
              print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
              print("price each patin: ${harga}");
              print("total price patin: ${totalHarga }");
              print("patin price new_fish_transfer_input_page: ${controller.nilaMerahPriceController.text}");
              createData();
              controller.postDataLog(controller.fitur);
            } else if (controller.finalMasPrice.value != 0 && controller.finalMasTotalPrice.value != 0){
              var formatHarga = NumberFormat("#,###");
              var temp = '${formatHarga.format(controller.finalMasPrice.value)}';
              var temp2 = '${formatHarga.format(controller.finalMasTotalPrice.value)}';
              var harga = temp.replaceAll(',', '');
              var totalHarga = temp2.replaceAll(',', '');
              print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
              print("price each mas: ${harga}");
              print("total price mas: ${totalHarga }");
              print("mas price new_fish_transfer_input_page: ${controller.nilaMerahPriceController.text}");
              createData();
              controller.postDataLog(controller.fitur);
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

    Widget submitKeringButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace * 3, right: defaultMargin, left: defaultMargin),
        child: TextButton(
          onPressed: () async {
            // Get.back();
            await controller.postSortirKering(
              context,
              () {
                Navigator.pop(context);
              },
            );
            // fishTransferController.getTransfertData(context);
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

    Widget previousSubmitButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace * 3, right: defaultMargin, left: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => pageController.previousPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Kembali',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextButton(
                onPressed: () async {
                  // Get.back();
                  await controller.postSortirKering(
                    context,
                    () {
                      Navigator.pop(context);
                      // fishTransferController.getTransfertData(context);
                    },
                  );
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
            )
          ],
        ),
      );
    }

    Widget previousNextButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace * 3, right: defaultMargin, left: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => pageController.previousPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Kembali',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextButton(
                onPressed: () => pageController.nextPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Berikutnya',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget nextButton() {
      return Obx(() {
        return Container(
          height: 50,
          width: double.infinity,
          margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
          child: TextButton(
            onPressed: () {
              controller.pondlistController.listPondSelected.isEmpty
                  ? null
                  : controller.pondlistController.initialLenght.toInt() !=
                          controller.pondlistController.listPondSelected.length
                      ? null
                      : pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
            },
            style: TextButton.styleFrom(
              backgroundColor: controller
                      .pondlistController.listPondSelected.isEmpty
                  ? Colors.grey
                  : controller.pondlistController.initialLenght.toInt() !=
                          controller.pondlistController.listPondSelected.length
                      ? Colors.grey
                      : Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Berikutnya',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
          ),
        );
      });
    }

    Widget previousButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace * 3, right: defaultMargin, left: defaultMargin),
        child: TextButton(
          onPressed: () => pageController.previousPage(
              duration: const Duration(seconds: 1), curve: Curves.easeInOut),
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Kembali',
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
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemBuilder: ((context, index) {
            return FishTransferDeactivationListCard(
                fish: controller.activation.fishLive![index]);
          }),
          itemCount: controller.activation.fishLive!.length,
        ),
      );
    }

    Widget destinationnNotActiveTransfer() {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
          child: Center(
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Kolam yang dituju belum aktif",
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
                "Silahkan aktifasi kolam terlebih dahulu",
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

    Widget listSelected() {
      return ListView.builder(
          itemCount: controller.pondlistController.listPondSelected.isEmpty
              ? 1
              : controller.pondlistController.listPondSelected.length,
          itemBuilder: ((context, index) {
            if (controller.pondlistController.listPondSelected.isEmpty) {
              return Container();
            } else {
              return Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: primaryColor),
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Kolam ${controller.pondlistController.listPondSelected[index].name}",
                          style: primaryTextStyle.copyWith(),
                        ),
                        if (controller.pondlistController
                                .listPondSelected[index].isInputed ==
                            false) ...[
                          Text(
                            "Data belum diisi",
                            style: primaryTextStyle.copyWith(color: Colors.red),
                          ),
                        ] else ...[
                          if (controller.pondlistController
                                  .listPondSelected[index].isInputed ==
                              false) ...[
                            Text(
                              "Data lengkap",
                              style: primaryTextStyle.copyWith(
                                  color: Colors.green),
                            ),
                          ]
                        ]
                      ]),
                ),
              );
            }
          }));
    }

    // Widget addButton() {
    //   return Padding(
    //     padding: EdgeInsets.all(16),
    //     child:
    //   );
    // }

    Widget deactivationTransfer() {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
          child: Center(
            child: Column(children: [
              SizedBox(height: 20),
              Text(
                "Silahkan masukan data ikan yang tidak disortir (panen)",
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

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: const Text("Entry Sortir"),
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
      body: Obx(() {
        return controller.isLoadingInventory.value
            ? Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ) : ListView(
          children: [
            if (isMenuTapped.value)
              Column(
                children: [
                  newMenu(),
                  SizedBox(height: 10,),
                ],
              ),
            transferTypeInput(),
            checkBoxFishTransfer(),
            controller.isNilaHitamInput == true
                ? nilaHitamInput()
                : Container(),
            controller.isNilaMerahInput == true
                ? nilaMerahInput()
                : Container(),
            controller.isLeleInput == true ? leleInput() : Container(),
            controller.isPatinInput == true ? patinInput() : Container(),
            controller.isMasInput == true ? masInput() : Container(),
            sampleLongInput(),
            sampleWeightInput(),
            widget.pond.isActive == false ? waterHeightInput() : Container(),
            submitButton()
          ],
        );
      }),
    );
  }

  void createData() {
    if (widget.pond.isInputed == true) {
      if (controller.isNilaMerahInput.value == true &&
          controller.nilamerahAmountChecker.value <
              (controller.nilamerahAmountComparator.value - int.parse(widget.pond.fish?.firstWhereOrNull((element) => element.type == "nila merah") == null ? "0" : widget.pond.fish!.firstWhereOrNull((element) => element.type == "nila merah")!.amount.toString())) +
                  int.parse(controller.nilaMerahAmountController.text)) {
        print(int.parse(widget.pond.fish?.firstWhereOrNull(
                    (element) => element.type == "nila merah") ==
                null
            ? "0"
            : widget.pond.fish!
                .firstWhereOrNull((element) => element.type == "nila merah")!
                .amount
                .toString()));
        print("awdawdaw");
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Input Error',
                      style: TextStyle(color: Colors.red)),
                  content: const Text(
                    'Jumlah ikan nila merah melebihi batas',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: backgroundColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      } else if (controller.isNilaHitamInput.value == true &&
          controller.nilahitamAmountChecker.value <
              (controller.nilahitamAmountComparator.value -
                      int.parse(widget.pond.fish!.firstWhereOrNull((element) => element.type == "nila hitam") ==
                              null
                          ? "0"
                          : widget.pond.fish!
                              .firstWhereOrNull(
                                  (element) => element.type == "nila hitam")!
                              .amount
                              .toString())) +
                  int.parse(controller.nilaHitamAmountController.text)) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Input Error',
                      style: TextStyle(color: Colors.red)),
                  content: const Text(
                    'Jumlah ikan nila hitam melebihi batas',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: backgroundColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      } else if (controller.isMasInput.value == true &&
          controller.masAmountChecker.value <
              (controller.masAmountComparator.value - int.parse(widget.pond.fish!.firstWhereOrNull((element) => element.type == "mas") == null ? "0" : widget.pond.fish!.firstWhereOrNull((element) => element.type == "mas")!.amount.toString())) +
                  int.parse(controller.masAmountController.text)) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Input Error',
                      style: TextStyle(color: Colors.red)),
                  content: const Text(
                    'Jumlah ikan mas melebihi batas',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: backgroundColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      } else if (controller.isLeleInput.value == true &&
          controller.leleAmountChecker.value <
              (controller.leleAmountComparator.value - int.parse(widget.pond.fish!.firstWhereOrNull((element) => element.type == "lele") == null ? "0" : widget.pond.fish!.firstWhereOrNull((element) => element.type == "lele")!.amount.toString())) +
                  int.parse(controller.leleAmountController.text)) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Input Error',
                      style: TextStyle(color: Colors.red)),
                  content: const Text(
                    'Jumlah ikan lele melebihi batas',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: backgroundColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      } else if (controller.isPatinInput.value == true &&
          controller.patinAmountChecker.value <
              (controller.patinAmountComparator.value -
                      int.parse(widget.pond.fish!.firstWhereOrNull((element) => element.type == "patin") == null ? "0" : widget.pond.fish!.firstWhereOrNull((element) => element.type == "patin")!.amount.toString())) +
                  int.parse(controller.patinAmountController.text)) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Input Error',
                      style: TextStyle(color: Colors.red)),
                  content: const Text(
                    'Jumlah ikan patin melebihi batas',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: backgroundColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      } else {
        final fish = controller.buildJsonFish();

        final data = {
          "destination_pond_id": widget.pond.id,
          "status":
              widget.pond.isActive == true ? "isActivated" : "isNotActivated",
          "fish": fish,
          "sample_weight": controller.sampleWeightController.text,
          "sample_long": controller.sampleLongController.text,
          "transfer_type": controller.typeController.selected.value,
          if (widget.pond.isActive == false) ...{
            "water_level": controller.waterHeightController.text
          }
        };
        List<Fish> inputedFish = Fish.createList(fish);
        // print(inputedFish[0].amount);
        ListPondSortir item = ListPondSortir(
            id: widget.pond.id,
            isInputed: true,
            name: widget.pond.name,
            isActive: widget.pond.isActive,
            dataInput: data,
            fish: inputedFish);
        replaceItemInArray(controller.listPondSelected, widget.index, item);
      }
    } else {
      if (controller.isNilaMerahInput.value == true &&
          controller.nilamerahAmountChecker.value <
              controller.nilamerahAmountComparator.value +
                  int.parse(controller.nilaMerahAmountController.text)) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Input Error',
                      style: TextStyle(color: Colors.red)),
                  content: const Text(
                    'Jumlah ikan nila merah melebihi batas',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: backgroundColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      } else if (controller.isNilaHitamInput.value == true &&
          controller.nilahitamAmountChecker.value <
              controller.nilahitamAmountComparator.value +
                  int.parse(controller.nilaHitamAmountController.text)) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Input Error',
                      style: TextStyle(color: Colors.red)),
                  content: const Text(
                    'Jumlah ikan nila hitam melebihi batas',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: backgroundColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      } else if (controller.isMasInput.value == true &&
          controller.masAmountChecker.value <
              controller.masAmountComparator.value +
                  int.parse(controller.masAmountController.text)) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Input Error',
                      style: TextStyle(color: Colors.red)),
                  content: const Text(
                    'Jumlah ikan mas melebihi batas',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: backgroundColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      } else if (controller.isLeleInput.value == true &&
          controller.leleAmountChecker.value <
              controller.leleAmountComparator.value +
                  int.parse(controller.leleAmountController.text)) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Input Error',
                      style: TextStyle(color: Colors.red)),
                  content: const Text(
                    'Jumlah ikan lele melebihi batas',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: backgroundColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      } else if (controller.isPatinInput.value == true &&
          controller.patinAmountChecker.value <
              controller.patinAmountComparator.value +
                  int.parse(controller.patinAmountController.text)) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Input Error',
                      style: TextStyle(color: Colors.red)),
                  content: const Text(
                    'Jumlah ikan patin melebihi batas',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: backgroundColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      } else {
        final fish = controller.buildJsonFish();
        var price = ''.obs;
        var totalPrice = ''.obs;
        print("fish new_fish_transfer_input_page: ${fish}");
        for (var eachItem in fish){
          if (jsonDecode(eachItem.toString())["type"] == "lele"){
            var formatHarga = NumberFormat("#,###");
            var temp = '${formatHarga.format(controller.finalLelePrice.value)}';
            var temp2 = '${formatHarga.format(controller.finalLeleTotalPrice.value)}';
            setState(() {
              price.value = temp.replaceAll(',', '');
              totalPrice.value = temp2.replaceAll(',', '');
            });
            print("price each lele: ${ price.value}");
            print("total price lele: ${totalPrice.value }");
          } else if (jsonDecode(eachItem.toString())["type"] == "nila hitam"){
            var formatHarga = NumberFormat("#,###");
            var temp = '${formatHarga.format(controller.finalNilaHitamPrice.value)}';
            var temp2 = '${formatHarga.format(controller.finalNilaHitamTotalPrice.value)}';
            setState(() {
              price.value = temp.replaceAll(',', '');
              totalPrice.value = temp2.replaceAll(',', '');
            });
            print("price each nila hitam: ${ price.value}");
            print("total price nila hitam: ${totalPrice.value }");
          } else if (jsonDecode(eachItem.toString())["type"] == "nila merah"){
            var formatHarga = NumberFormat("#,###");
            var temp = '${formatHarga.format(controller.finalNilaMerahPrice.value)}';
            var temp2 = '${formatHarga.format(controller.finalNilaMerahTotalPrice.value)}';
            setState(() {
              price.value = temp.replaceAll(',', '');
              totalPrice.value = temp2.replaceAll(',', '');
            });
            print("------------------------------------------------");
            print("price each nila merah: ${price.value}");
            print("total price nila merah: ${totalPrice.value }");
            print("lele price new_fish_transfer_input_page: ${controller.nilaMerahPriceController.text}");
          } else if (jsonDecode(eachItem.toString())["type"] == "patin"){
            var formatHarga = NumberFormat("#,###");
            var temp = '${formatHarga.format(controller.finalPatinPrice.value)}';
            var temp2 = '${formatHarga.format(controller.finalPatinTotalPrice.value)}';
            setState(() {
              price.value = temp.replaceAll(',', '');
              totalPrice.value = temp2.replaceAll(',', '');
            });
            print("price each patin: ${price.value}");
            print("total price patin: ${totalPrice.value }");
          } else if (jsonDecode(eachItem.toString())["type"] == "mas"){
            var formatHarga = NumberFormat("#,###");
            var temp = '${formatHarga.format(controller.finalMasPrice.value)}';
            var temp2 = '${formatHarga.format(controller.finalMasTotalPrice.value)}';
            setState(() {
              price.value = temp.replaceAll(',', '');
              totalPrice.value = temp2.replaceAll(',', '');
            });
            print("price each mas: ${ price.value}");
            print("total price mas: ${totalPrice.value }");
          }
        }

        print("FINAL PRICE: ${price.value}");
        final data = {
          "destination_pond_id": widget.pond.id,
          "status":
              widget.pond.isActive == true ? "isActivated" : "isNotActivated",
          "fish": fish,
          "fish_seed": controller.fishSeed.value,
          "fish_category": controller.fishCategory.value,
          "sample_weight": controller.sampleWeightController.text,
          "sample_long": controller.sampleLongController.text,
          "transfer_type": controller.typeController.selected.value,
          "price" : int.parse(price.value),
          "total_price" : int.parse(totalPrice.value),
          if (widget.pond.isActive == false) ...{
            "water_level": controller.waterHeightController.text
          }
        };
        List<Fish> inputedFish = Fish.createList(fish);
        // print(inputedFish[0].amount);
        print("data hasil input di page new_fish_transfer_input_page: ${data}");
        ListPondSortir item = ListPondSortir(
            id: widget.pond.id,
            isInputed: true,
            name: widget.pond.name,
            isActive: widget.pond.isActive,
            dataInput: data,
            fish: inputedFish);
        replaceItemInArray(controller.listPondSelected, widget.index, item);
      }
    }
  }

  void replaceItemInArray(
      List<ListPondSortir> arr, int index, ListPondSortir item) {
    if (index >= 0 && index < arr.length) {
      arr[index] = item;
      Get.back();
    } else {
      throw RangeError('Index out of bounds');
    }
  }
}

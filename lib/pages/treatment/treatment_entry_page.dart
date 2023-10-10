import 'package:another_flushbar/flushbar.dart';
import 'package:fish/models/fish_model.dart';
import 'package:fish/pages/component/treatment_berat_input_card.dart';
import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_state.dart';
import 'package:fish/pages/treatment/treatment_entry_controller.dart';
import 'package:fish/pages/treatment/treatment_controller.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:fish/pages/pond/detail_pond_controller.dart';
import 'package:fish/theme.dart';

import 'package:fish/pages/component/deactivation_list_input.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widgets/new_Menu_widget.dart';

class TreatmentEntryPage extends StatefulWidget {
  TreatmentEntryPage({Key? key}) : super(key: key);
  @override
  State<TreatmentEntryPage> createState() => _TreatmentEntryPageState();
}

class _TreatmentEntryPageState extends State<TreatmentEntryPage> {
  final TreatmentEntryController controller =
      Get.put(TreatmentEntryController());

  final TreatmentController treatmentTontroller =
      Get.put(TreatmentController());

  final InventarisBahanBudidayaState supState =
      Get.put(InventarisBahanBudidayaState());
  var isMenuTapped = false.obs;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await controller.getPondActivations(
    //       pondId: controller.pond.id.toString());
    // });
    controller.getHarvestedBool(controller.activation);
    supState.isProbSelected.value = false;
    supState.isCarbSelected.value = false;
    supState.carbCheck.value = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      supState.getAllData('Probiotik', () {
        if (supState.listCultureProbiotik.isNotEmpty) {
          supState.getProbDetail(
            supState.selectedCultureProbiotik.value['id'],
            () => null,
          );
          supState.probID.value =
              supState.selectedCultureProbiotik.value['suplemen_id'];
        }
      });

      supState.getAllData('Feed Additive', () {
        if (supState.listCarbon.isNotEmpty) {
          supState.getCarbDetail(
            supState.selectedCarbon.value['id'],
            () => null,
          );
          supState.carbID.value = supState.selectedCarbon.value['suplemen_id'];
        }
      });

      supState.getSaltDetail(() {
        if (supState.saltDetail.value.data!.isNotEmpty) {
          supState.calculatedSaltStock.value = double.parse(
              supState.saltDetail.value.data![0].amount!.toStringAsFixed(2));
          supState.saltStock.value = double.parse(
              supState.saltDetail.value.data![0].amount!.toStringAsFixed(2));
          supState.saltID.value =
              supState.saltDetail.value.data![0].sId.toString();
        }
      });
    });
  }

  @override
  void dispose() {
    controller.postDataLog(controller.fitur);
    controller.carbonController.clear();
    controller.descController.clear();
    controller.leleWeightController.clear();
    controller.masWeightController.clear();
    controller.nilaHitamWeightController.clear();
    controller.nilaMerahWeightController.clear();
    controller.patinWeightController.clear();
    controller.saltController.clear();
    controller.waterController.clear();
    controller.probioticController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    Widget descInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi',
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
                  controller: controller.descController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'ex: Ikan Sakit',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget carbonTypeNullInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi',
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
                  controller: controller.carbonTypeNullController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'ex: Ikan Sakit',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget waterChangeInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pergantian Air (%)',
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
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                  ],
                  keyboardType: TextInputType.number,
                  style: primaryTextStyle,
                  controller: controller.waterController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'ex: 100',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget saltDosisInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          children: [
            supState.saltDetail.value.data!.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dosis Garam',
                        style: headingText2,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: Text(
                          'Tidak ada data',
                          style: headingText3.copyWith(color: Colors.red),
                        ),
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldWidget(
                        label: 'Dosis Garam',
                        controller: controller.saltController,
                        numberOutput: true,
                        onChange: (v) {
                          if (supState.saltStock.value -
                                  double.parse(
                                      controller.saltController.text == ''
                                          ? '0'
                                          : controller.saltController.text) <
                              0) {
                            Flushbar(
                              message: "Tidak boleh kurang dari stok tersedia",
                              duration: Duration(seconds: 2),
                              leftBarIndicatorColor: Colors.red,
                            ).show(context);
                          }
                          setState(() {
                            supState.calculatedSaltStock.value =
                                supState.saltStock.value -
                                    double.parse(
                                        controller.saltController.text == ''
                                            ? '0'
                                            : controller.saltController.text);
                          });
                        },
                        suffixSection: Text(
                          'kg',
                          style: headingText3,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Sisa Stok : ${supState.calculatedSaltStock.value}',
                        style: headingText3.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
          ],
        ),
      );
    }

    Widget treatmentTypeInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis Treatment',
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
                          controller.typeController.setSelected(newValue!),
                      value: controller.typeController.selected.value,
                      items:
                          controller.typeController.listtreatment.map((type) {
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
                    )),
              ),
            ),
          ],
        ),
      );
    }

    Widget listTreatmentBeratInput() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemBuilder: ((context, index) {
            return TreatmentBeratCard(
                fish: controller.activation.fishLive![index]);
          }),
          itemCount: controller.activation.fishLive!.length,
        ),
      );
    }

    Widget probioticInput() {
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor3,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Kultur Probiotik',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            supState.listCultureProbiotik.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada data',
                      style: headingText3.copyWith(color: Colors.red),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: inputColor,
                        ),
                        child: StatefulBuilder(
                          builder: ((context, setState) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<Map<String, dynamic>>(
                                onChanged: (value) async {
                                  setState(() {
                                    supState.selectedCultureProbiotik.value =
                                        value!;
                                  });
                                  supState.selectedCultureProbiotik.value =
                                      value!;
                                  supState.probID.value = value['suplemen_id'];
                                  await supState.getProbDetail(
                                      value['id'], () => null);
                                  supState.resetVariables();
                                },
                                value: supState.selectedCultureProbiotik.value,
                                dropdownColor: inputColor,
                                items: supState.listCultureProbiotik.map<
                                    DropdownMenuItem<Map<String, dynamic>>>(
                                  (val) {
                                    return DropdownMenuItem<
                                        Map<String, dynamic>>(
                                      value: val,
                                      child: Text(
                                        val['suplemen_name'],
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
                      SizedBox(
                        height: 12,
                      ),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return TextFieldWidget(
                            label: 'Stok Probiotik',
                            controller: controller.probioticController,
                            hint: 'Ex: 100',
                            numberOutput: true,
                            onChange: (v) {
                              if (supState.probStock.value -
                                      double.parse(
                                          controller.probioticController.text ==
                                                  ''
                                              ? '0'
                                              : controller
                                                  .probioticController.text) <
                                  0) {
                                Flushbar(
                                  message:
                                      "Tidak boleh kurang dari stok tersedia",
                                  duration: Duration(seconds: 2),
                                  leftBarIndicatorColor: Colors.red,
                                ).show(context);
                              }
                              setState(() {
                                supState.calculatedProbStock.value = supState
                                        .probStock.value -
                                    double.parse(controller
                                                .probioticController.text ==
                                            ''
                                        ? '0'
                                        : controller.probioticController.text);
                              });
                            },
                            suffixSection: Text(
                              supState.probType.value,
                              style: headingText3,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Sisa Stok : ${supState.calculatedProbStock.value}',
                        style: headingText3.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )

            // Container(
            //   height: 50,
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 16,
            //   ),
            //   decoration: BoxDecoration(
            //     color: backgroundColor2,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Center(
            //     child: TextFormField(
            //       style: primaryTextStyle,
            //       inputFormatters: <TextInputFormatter>[
            //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
            //       ],
            //       keyboardType: TextInputType.number,
            //       controller: controller.probioticController,
            //       decoration: InputDecoration.collapsed(
            //         hintText: 'ex: 2',
            //         hintStyle: subtitleTextStyle,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    }

    Widget carbonInput() {
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor3,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Jenis Carbon',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            supState.listCarbon.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada data',
                      style: headingText3.copyWith(color: Colors.red),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: inputColor,
                        ),
                        child: StatefulBuilder(
                          builder: ((context, setState) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<Map<String, dynamic>>(
                                onChanged: (value) async {
                                  setState(() {
                                    supState.selectedCarbon.value = value!;
                                  });
                                  supState.selectedCarbon.value = value!;
                                  supState.carbID.value = value['suplemen_id'];
                                  await supState.getCarbDetail(
                                      value['id'], () => null);
                                  supState.resetVariables();
                                },
                                value: supState.selectedCarbon.value,
                                dropdownColor: inputColor,
                                items: supState.listCarbon.map<
                                    DropdownMenuItem<Map<String, dynamic>>>(
                                  (val) {
                                    return DropdownMenuItem<
                                        Map<String, dynamic>>(
                                      value: val,
                                      child: Text(
                                        val['suplemen_name'],
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
                      SizedBox(
                        height: 12,
                      ),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return TextFieldWidget(
                            label: 'Stok Carbon',
                            controller: controller.carbonController,
                            hint: 'Ex: 100',
                            numberOutput: true,
                            onChange: (v) {
                              if (supState.carbStock.value -
                                      double.parse(
                                          controller.carbonController.text == ''
                                              ? '0'
                                              : controller
                                                  .carbonController.text) <
                                  0) {
                                Flushbar(
                                  message:
                                      "Tidak boleh kurang dari stok tersedia",
                                  duration: Duration(seconds: 2),
                                  leftBarIndicatorColor: Colors.red,
                                ).show(context);
                              }
                              setState(() {
                                supState.calculatedCarbonStock.value = supState
                                        .carbStock.value -
                                    double.parse(
                                        controller.carbonController.text == ''
                                            ? '0'
                                            : controller.carbonController.text);
                              });
                            },
                            suffixSection: Text(
                              supState.carbType.value,
                              style: headingText3,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Sisa Stok : ${supState.calculatedCarbonStock.value}',
                        style: headingText3.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )

            // Container(
            //   height: 50,
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 16,
            //   ),
            //   decoration: BoxDecoration(
            //     color: backgroundColor2,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Center(
            //     child: TextFormField(
            //       style: primaryTextStyle,
            //       inputFormatters: <TextInputFormatter>[
            //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
            //       ],
            //       keyboardType: TextInputType.number,
            //       controller: controller.probioticController,
            //       decoration: InputDecoration.collapsed(
            //         hintText: 'ex: 2',
            //         hintStyle: subtitleTextStyle,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       'Karbon (gram)',
        //       style: primaryTextStyle.copyWith(
        //         fontSize: 16,
        //         fontWeight: medium,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 12,
        //     ),
        //     Container(
        //       height: 50,
        //       padding: EdgeInsets.symmetric(
        //         horizontal: 16,
        //       ),
        //       decoration: BoxDecoration(
        //         color: backgroundColor2,
        //         borderRadius: BorderRadius.circular(12),
        //       ),
        //       child: Center(
        //         child: TextFormField(
        //           style: primaryTextStyle,
        //           inputFormatters: <TextInputFormatter>[
        //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
        //           ],
        //           keyboardType: TextInputType.number,
        //           controller: controller.carbonController,
        //           decoration: InputDecoration.collapsed(
        //             hintText: 'ex: 2',
        //             hintStyle: subtitleTextStyle,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      );
    }
    Widget carbonTypeInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
                value: supState.carbCheck.value,
                onChanged: (v) {
                  supState.carbCheck.value = v!;
                }),
            Text(
              'Aktifkan Carbon',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            // Container(
            //   height: 50,
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 16,
            //   ),
            //   decoration: BoxDecoration(
            //     color: backgroundColor2,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Center(
            //     child: Obx(() => DropdownButtonFormField<String>(
            //           onChanged: (newValue) => controller.carbonTypeController
            //               .setSelected(newValue!),
            //           value: controller.carbonTypeController.selected.value,
            //           items: controller.carbonTypeController.listCarbon
            //               .map((carbohydrate_type) {
            //             return DropdownMenuItem<String>(
            //               value: carbohydrate_type,
            //               child: Text(
            //                 carbohydrate_type,
            //                 style: primaryTextStyle,
            //               ),
            //             );
            //           }).toList(),
            //           dropdownColor: backgroundColor5,
            //           decoration: InputDecoration(border: InputBorder.none),
            //         )),
            //   ),
            // ),
          ],
        ),
      );
    }
    // Widget carbonTypeInput() {
    //   return Container(
    //     margin: EdgeInsets.only(
    //         top: defaultSpace, right: defaultMargin, left: defaultMargin),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Jenis Karbon',
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
    //               controller: controller.carbonTypeController,
    //               decoration: InputDecoration.collapsed(
    //                 hintText: 'ex: molase',
    //                 hintStyle: subtitleTextStyle,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }



    // Widget widthInput() {
    //   return Container(
    //     margin: EdgeInsets.only(
    //         top: defaultSpace, right: defaultMargin, left: defaultMargin),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Lebar (meter)',
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
    //               controller: controller.widthController,
    //               decoration: InputDecoration.collapsed(
    //                 hintText: 'ex: 2',
    //                 hintStyle: subtitleTextStyle,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // Widget diameterInput() {
    //   return Container(
    //     margin: EdgeInsets.only(
    //         top: defaultSpace, right: defaultMargin, left: defaultMargin),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Diameter (meter)',
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
    //               controller: controller.diameterController,
    //               decoration: InputDecoration.collapsed(
    //                 hintText: 'ex: 2',
    //                 hintStyle: subtitleTextStyle,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    Widget submitButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace * 3, right: defaultMargin, left: defaultMargin),
        child: TextButton(
          onPressed: () async {
            // Get.back();
            controller.saltController.text == "" &&
                    controller.carbonController.text == "" &&
                    controller.waterController.text == "" &&
                    controller.probioticController.text == ""
                ? null
                : await controller.postPondTreatment(
                    context,
                    () {
                      Navigator.pop(context);
                      treatmentTontroller.getTreatmentData(context);
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
      );
    }

    Widget submitBeratButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace * 3, right: defaultMargin, left: defaultMargin),
        child: TextButton(
          onPressed: () async {
            // Get.back();
            await controller.postTreatmentBerat(
              context,
              () {
                Navigator.pop(context);
                treatmentTontroller.getTreatmentData(context);
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
      );
    }

    // Widget persegiInput() {
    //   return Container(
    //       child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [widthInput(), lengthInput()],
    //   ));
    // }

    // Widget bundarInput() {
    //   return Container(
    //       child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [diameterInput()],
    //   ));
    // }

    return Obx(() {
      if (controller.isLoading.value == false) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: backgroundColor2,
            title: const Text("Entry Treatment"),
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
              treatmentTypeInput(),
              descInput(),
              controller.typeController.selected.value == "berat"
                  ? listTreatmentBeratInput()
                  : waterChangeInput(),
              controller.typeController.selected.value == "berat"
                  ? Container()
                  : supState.isProbLoading.value
                      ? Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : probioticInput(),
              controller.typeController.selected.value == "berat"
                  ? Container()
                  : carbonTypeInput(),
              supState.carbCheck.value
                  ? supState.isCarbLoading.value
                      ? Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : carbonInput()
                  : Container(),
              controller.typeController.selected.value == "berat"
                  ? Container()
                  : saltDosisInput(),
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
                            supState.selectedUsedDate.value = '';
                            supState.showedUsedDate.clear();
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Aktifkan tanggal entry treatment manual',
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
                                          '${supState.dateFormat(datePicker.toString(), false)} | Jam ${selectedTime!.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}:00.000');

                                  // Define the format for formatting the date into the desired format
                                  String outputFormatStr =
                                      'yyyy-MM-ddTHH:mm:ss.SSS';
                                  String formattedDateTime =
                                      DateFormat(outputFormatStr)
                                          .format(dateTime);

                                  supState.selectedUsedDate.value =
                                      datePicker == null
                                          ? ''
                                          : '$formattedDateTime +0000';

                                  supState.showedUsedDate.text = datePicker ==
                                          null
                                      ? ''
                                      : '${supState.dateFormat(datePicker.toString(), false)} | Jam ${selectedTime!.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}';
                                }
                              }
                            },
                            child: TextFieldWidget(
                              label: 'Pilih Tanggal',
                              controller: supState.showedUsedDate,
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
              controller.typeController.selected.value == "berat"
                  ? submitBeratButton()
                  : submitButton(),
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

// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:developer';

import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_state.dart';
import 'package:fish/pages/pond/activation_breed_controller.dart';
import 'package:fish/pages/pond/detail_pond_controller.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
    controller.leleAmountController.text = '';
    controller.masAmountController.text = '';
    controller.patinAmountController.text = '';
    controller.nilaMerahAmountController.text = '';
    controller.nilaHitamAmountController.text = '';
  }

  @override
  Widget build(BuildContext context) {
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
                value: controller.isNilaHitam.value,
                onChanged: (bool? value) {
                  controller.setNilaHitam(value!);
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
                value: controller.isNilaMerah.value,
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
                value: controller.isLele.value,
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
                value: controller.isPatin.value,
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
                value: controller.isMas.value,
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
                    await benihState.getFishSeedDetail(
                        'Lele', newValue['id'], () => null);
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
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldWidget(
                            label: 'Berat Ikan',
                            controller: dump,
                            isLong: false,
                            isEdit: false,
                            hint: benihState.leleFishWeigth.value == ''
                                ? '-'
                                : benihState.leleFishWeigth.value,
                            isHintStyle: true,
                            styleHint: const TextStyle(color: Colors.white),
                            suffixSection: Text(
                              'kg',
                              style: headingText3,
                            ),
                          ),
                          TextFieldWidget(
                            label: 'Ukuran Sortir',
                            controller: dump,
                            isLong: false,
                            isEdit: false,
                            hint: benihState.leleFishSize.value == ''
                                ? '-'
                                : benihState.leleFishSize.value,
                            isHintStyle: true,
                            styleHint: const TextStyle(color: Colors.white),
                            suffixSection: Text(
                              'cm',
                              style: headingText3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          TextFieldWidget(
                            label: 'Jumlah Ikan',
                            controller: controller.leleAmountController,
                            isLong: false,
                            hint: 'Ex: 100',
                            suffixSection: Text(
                              'ekor',
                              style: headingText3,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
            const SizedBox(
              height: 12,
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
                    await benihState.getFishSeedDetail(
                        'Nila Merah', newValue['id'], () => null);
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
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldWidget(
                            label: 'Berat Ikan',
                            controller: dump,
                            isLong: false,
                            isEdit: false,
                            hint: benihState.nilaMerahFishWeigth.value == ''
                                ? '-'
                                : benihState.nilaMerahFishWeigth.value,
                            isHintStyle: true,
                            styleHint: const TextStyle(color: Colors.white),
                            suffixSection: Text(
                              'kg',
                              style: headingText3,
                            ),
                          ),
                          TextFieldWidget(
                            label: 'Ukuran Sortir',
                            controller: dump,
                            isLong: false,
                            isEdit: false,
                            hint: benihState.nilaMerahFishSize.value == ''
                                ? '-'
                                : benihState.nilaMerahFishSize.value,
                            isHintStyle: true,
                            styleHint: const TextStyle(color: Colors.white),
                            suffixSection: Text(
                              'cm',
                              style: headingText3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          TextFieldWidget(
                            label: 'Jumlah Ikan',
                            controller: controller.nilaMerahAmountController,
                            isLong: false,
                            hint: 'Ex: 100',
                            suffixSection: Text(
                              'ekor',
                              style: headingText3,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
            const SizedBox(
              height: 12,
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
                    await benihState.getFishSeedDetail(
                        'Nila Hitam', newValue['id'], () => null);
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
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldWidget(
                            label: 'Berat Ikan',
                            controller: dump,
                            isLong: false,
                            isEdit: false,
                            hint: benihState.nilaHitamFishWeigth.value == ''
                                ? '-'
                                : benihState.nilaHitamFishWeigth.value,
                            isHintStyle: true,
                            styleHint: const TextStyle(color: Colors.white),
                            suffixSection: Text(
                              'kg',
                              style: headingText3,
                            ),
                          ),
                          TextFieldWidget(
                            label: 'Ukuran Sortir',
                            controller: dump,
                            isLong: false,
                            isEdit: false,
                            hint: benihState.nilaHitamFishSize.value == ''
                                ? '-'
                                : benihState.nilaHitamFishSize.value,
                            isHintStyle: true,
                            styleHint: const TextStyle(color: Colors.white),
                            suffixSection: Text(
                              'cm',
                              style: headingText3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          TextFieldWidget(
                            label: 'Jumlah Ikan',
                            controller: controller.nilaHitamAmountController,
                            isLong: false,
                            hint: 'Ex: 100',
                            suffixSection: Text(
                              'ekor',
                              style: headingText3,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
            const SizedBox(
              height: 12,
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
                    await benihState.getFishSeedDetail(
                        'Patin', newValue['id'], () => null);
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
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldWidget(
                            label: 'Berat Ikan',
                            controller: dump,
                            isLong: false,
                            isEdit: false,
                            hint: benihState.patinFishWeigth.value == ''
                                ? '-'
                                : benihState.patinFishWeigth.value,
                            isHintStyle: true,
                            styleHint: const TextStyle(color: Colors.white),
                            suffixSection: Text(
                              'kg',
                              style: headingText3,
                            ),
                          ),
                          TextFieldWidget(
                            label: 'Ukuran Sortir',
                            controller: dump,
                            isLong: false,
                            isEdit: false,
                            hint: benihState.patinFishSize.value == ''
                                ? '-'
                                : benihState.patinFishSize.value,
                            isHintStyle: true,
                            styleHint: const TextStyle(color: Colors.white),
                            suffixSection: Text(
                              'cm',
                              style: headingText3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          TextFieldWidget(
                            label: 'Jumlah Ikan',
                            controller: controller.patinAmountController,
                            isLong: false,
                            hint: 'Ex: 100',
                            suffixSection: Text(
                              'ekor',
                              style: headingText3,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
            const SizedBox(
              height: 12,
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
                    await benihState.getFishSeedDetail(
                        'Mas', newValue['id'], () => null);
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
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldWidget(
                            label: 'Berat Ikan',
                            controller: dump,
                            isLong: false,
                            isEdit: false,
                            hint: benihState.masFishWeigth.value == ''
                                ? '-'
                                : benihState.masFishWeigth.value,
                            isHintStyle: true,
                            styleHint: const TextStyle(color: Colors.white),
                            suffixSection: Text(
                              'kg',
                              style: headingText3,
                            ),
                          ),
                          TextFieldWidget(
                            label: 'Ukuran Sortir',
                            controller: dump,
                            isLong: false,
                            isEdit: false,
                            hint: benihState.masFishSize.value == ''
                                ? '-'
                                : benihState.masFishSize.value,
                            isHintStyle: true,
                            styleHint: const TextStyle(color: Colors.white),
                            suffixSection: Text(
                              'cm',
                              style: headingText3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          TextFieldWidget(
                            label: 'Jumlah Ikan',
                            controller: controller.masAmountController,
                            isLong: false,
                            hint: 'Ex: 100',
                            suffixSection: Text(
                              'ekor',
                              style: headingText3,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
            const SizedBox(
              height: 12,
            ),
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
              'Kategori',
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
            await controller.pondActivation(
              () {
                Navigator.pop(context);
              },
            );
            detailPondController.getPondActivation(context);
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

    return Obx(() {
      if (controller.isActivationProgress.value == false) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor2,
            title: const Text("Aktivasi Kolam"),
          ),
          backgroundColor: backgroundColor1,
          body: ListView(
            children: [
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
                        waterHeightInput(),
                        activationButton(),
                      ],
                    ),
              const SizedBox(
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

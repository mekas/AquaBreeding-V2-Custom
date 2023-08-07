import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:fish/models/inventaris/pakan/inventaris_pakan_model.dart';
import 'package:fish/models/inventaris/pakan/inventaris_pakan_name_model.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RenderInventarisPakanListWidget extends StatefulWidget {
  const RenderInventarisPakanListWidget({Key? key}) : super(key: key);
  @override
  State<RenderInventarisPakanListWidget> createState() =>
      _RenderInventarisPakanListWidgetState();
}

class _RenderInventarisPakanListWidgetState
    extends State<RenderInventarisPakanListWidget> {
  final InventarisPakanState state = Get.put(InventarisPakanState());

  DateTime currDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                'List Merk',
                style: headingText2,
              ),
              Obx(() => state.feedNameList.value.data!.isEmpty
                  ? SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          'Tidak ada data',
                          style: headingText3.copyWith(color: Colors.red),
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height / 4.5,
                      margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: padding4XL),
                        itemCount: state.feedNameList.value.data!.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () async {
                              state.setSheetNameVariableEdit(false);
                              // inspect(state.feedNameList.value);
                              state.getDetailPakanNameData(
                                state.feedNameList.value.data![index].idInt!,
                                () {
                                  getNameBottomSheet(
                                      index,
                                      state.feedNameList.value.data![index]
                                          .idInt!);
                                },
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              decoration: BoxDecoration(
                                color: backgroundColor1,
                                border:
                                    Border.all(width: 2, color: primaryColor),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                      right: 12,
                                      bottom: 12,
                                      top: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Merk',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              state.feedNameList.value
                                                  .data![index].name
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Produser',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              '${state.feedNameList.value.data![index].producer}',
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Kadaluarsa',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              state.convertDaysToDate(
                                                  currDate,
                                                  state
                                                      .feedNameList
                                                      .value
                                                      .data![index]
                                                      .maxExpiredPeriod!),
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    )),
            ],
          ),
        ),
        Divider(
          thickness: 10,
          height: 10,
          color: backgroundColor2,
        ),
        Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Text(
              'List Pakan',
              style: headingText2,
            ),
            Obx(() => state.feedList.value.data!.isEmpty
                ? SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Tidak ada data',
                        style: headingText3.copyWith(color: Colors.red),
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: padding4XL),
                      itemCount: state.feedList.value.data!.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () async {
                            // state.setSheetNameVariableEdit(false);
                            state.setSheetFeedVariableEdit(false);

                            // inspect(state.feedNameList.value);
                            await state.getDataByID(
                                state.feedList.value.data![index].idInt!, () {
                              state.getDetailPakanNameData(
                                  state.feedList.value.data![index].feed!
                                      .idInt!, () {
                                getPakanBottomSheet(index,
                                    state.feedList.value.data![index].idInt!);
                              });

                              // getBottomSheet(index,
                              //     state.feedList.value.data![index].idInt!);
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            decoration: BoxDecoration(
                              color: backgroundColor1,
                              border: Border.all(width: 2, color: primaryColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Tanggal :',
                                        style: headingText3,
                                      ),
                                      Text(
                                        state.dateFormat(
                                            state.feedList.value.data![index]
                                                .createdAt!
                                                .toString(),
                                            true),
                                        style: headingText3,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12,
                                    right: 12,
                                    bottom: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Merk',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            state.feedList.value.data![index]
                                                .brandName!,
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Jumlah',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            '${state.feedList.value.data![index].amount!.toStringAsFixed(2)} kg',
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  )),
          ],
        ),
      ],
    );
  }

  getNameBottomSheet(int index, int id) {
    BottomSheetWidget.getBottomSheetWidget(
      context,
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                radius: 12,
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          'Edit Merk',
          style: headingText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 54,
        ),
        Text(
          'Kategori Merk : Pakan ${state.feedCategory.value}',
          style: headingText2,
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(
          () => TextFieldWidget(
            label: 'Nama Merk',
            controller: state.name,
            hint: 'Ex: Pelet',
            isLong: true,
            isEdit: state.nameEdit.value,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(
          () => TextFieldWidget(
            label: 'Deskripsi Pakan',
            controller: state.desc,
            hint: 'Ex: Bahan pakan ikan',
            isMoreText: true,
            isEdit: state.descEdit.value,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(
          () => TextFieldWidget(
            label: 'Produser Pakan',
            controller: state.producer,
            hint: 'Ex: Sinta',
            isEdit: state.producerEdit.value,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => TextFieldWidget(
                label: 'Protein',
                controller: state.protein,
                isLong: false,
                numberOutput: true,
                isEdit: state.proteinEdit.value,
                hint: 'Ex: 10',
                suffixSection: const Icon(
                  Icons.percent,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Obx(
              () => TextFieldWidget(
                label: 'Karbon',
                controller: state.carbo,
                isLong: false,
                numberOutput: true,
                isEdit: state.carboEdit.value,
                hint: 'Ex: 10',
                suffixSection: const Icon(
                  Icons.percent,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFieldWidget(
                label: 'Min. Expired',
                controller: state.minExp,
                isLong: false,
                numberOutput: true,
                isEdit: state.minExpEdit.value,
                hint: 'Ex: 10',
                suffixSection: Text(
                  'hari',
                  style: headingText3,
                ),
              ),
              TextFieldWidget(
                label: 'Max. Expired',
                controller: state.maxExp,
                isEdit: state.maxExpEdit.value,
                isLong: false,
                numberOutput: true,
                hint: 'Ex: 10',
                suffixSection: Text(
                  'hari',
                  style: headingText3,
                ),
              ),
            ],
          ),
        ),
        // const SizedBox(
        //   height: 16,
        // ),
        // Text(
        //   'Gambar (Struk)',
        //   style: headingText2,
        // ),
        // const SizedBox(
        //   height: 12,
        // ),
        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(12),
        //     color: Colors.grey,
        //   ),
        //   width: MediaQuery.of(context).size.width,
        //   height: 300,
        //   child: Image.network(
        //     'https://1.bp.blogspot.com/-9tt1qS0wO-8/X8uLEZd9HGI/AAAAAAAAAnQ/4uGdwluBvYg-cwgjFAf85P_MzITSUos1ACLcBGAsYHQ/s1078/Pakan.png',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        const SizedBox(
          height: 36,
        ),
        Obx(
          () => state.isSheetEditable.value
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: addButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    if (state.name.text == '' || state.producer.text == '') {
                      Flushbar(
                        message: "Gagal, Form tidak sesuai",
                        duration: Duration(seconds: 3),
                        leftBarIndicatorColor: Colors.red[400],
                      ).show(context);
                    } else {
                      await state.updatePakanNameData(
                        id,
                        () => {
                          state.getPakanNameData(
                            state.pageIdentifier.value,
                            () {},
                          ),
                          Navigator.pop(context),
                          state.resetNameVariables(),
                        },
                      );
                    }
                  },
                  child: Obx(
                    () => state.isLoadingPost.value
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Simpan',
                            style: headingText2,
                          ),
                  ),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Ubah Data'),
                            content: const Text(
                                'Apakah anda yakin ingin mengubah data ini?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Tidak'),
                                child: const Text('Tidak'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  state.setSheetNameVariableEdit(true);
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text('Ya'),
                              ),
                            ],
                          );
                        });
                  },
                  child: Text(
                    'Ubah',
                    style: headingText2,
                  ),
                ),
        ),
        const SizedBox(
          height: 12,
        ),
        ElevatedButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Hapus Data'),
                    content: const Text(
                        'Apakah anda yakin ingin menghapus data ini?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await state.deletePakanName(
                              state.feedNameList.value.data![index].idInt!,
                              () async {
                            await state.getPakanNameData(
                              state.pageIdentifier.value,
                              () {
                                // Flushbar(
                                //   message: "Merk telah dihapus",
                                //   duration: Duration(seconds: 3),
                                //   leftBarIndicatorColor: Colors.green[400],
                                // ).show(context);
                              },
                            );
                          });
                          if (context.mounted) Navigator.of(context).pop();
                          if (context.mounted) Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Obx(
            () => state.isLoadingDelete.value
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Hapus',
                    style: headingText2,
                  ),
          ),
        ),
      ],
    );
  }

  getPakanBottomSheet(int index, int id) {
    BottomSheetWidget.getBottomSheetWidget(
      context,
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                radius: 12,
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          'Edit Pakan',
          style: headingText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 54,
        ),
        Text(
          'Kategori Pakan : Pakan ${state.feedCategory.value}',
          style: headingText2,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'List Nama Pakan',
          style: headingText2,
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => state.isLoadingNameDetail.value
              ? Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : state.listPakanName.isEmpty
                  ? Center(
                      child: Text(
                        'Tidak ada data',
                        style: headingText3.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    )
                  : Container(
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
                                  state.selectedPakan.value = value!;
                                });
                                state.selectedPakan.value = value!;
                                state.isPakanSelected.value = true;
                                // state.name.text

                                state.resetFeedVariables();
                                await state.getDetailPakanNameData(
                                    state.selectedPakan.value['id'],
                                    () => null);
                              },
                              value: state.selectedPakan.value,
                              dropdownColor: inputColor,
                              items: state.listPakanName
                                  .map<DropdownMenuItem<Map<String, dynamic>>>(
                                      (material) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: material,
                                  child: Text(
                                    material['feed_name'],
                                    style: headingText3,
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }),
                      ),
                    ),
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFieldWidget(
                label: 'Jumlah',
                controller: state.amount,
                isLong: false,
                numberOutput: true,
                hint: 'Ex: 1.5',
                isEdit: state.amountEdit.value,
                suffixSection: Text(
                  'kg',
                  style: headingText3,
                ),
              ),
              TextFieldWidget(
                label: 'Harga Beli',
                controller: state.price,
                isLong: false,
                numberOutput: true,
                hint: 'Ex: 10',
                isEdit: state.priceEdit.value,
                prefixSection: Text(
                  'Rp',
                  style: headingText3,
                ),
              ),
            ],
          ),
        ),
        state.listPakanName.isEmpty
            ? Container()
            : Column(
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Divider(
                      thickness: 10,
                      height: 10,
                      color: backgroundColor2,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Obx(
                    () => state.isLoadingNameDetail.value
                        ? Center(
                            child: SizedBox(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                            width: 50,
                            height: 50,
                          ))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFieldWidget(
                                label: 'Produser Pakan',
                                controller: state.producer,
                                hint: 'Ex: Sinta',
                                isLong: true,
                                isEdit: false,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              TextFieldWidget(
                                label: 'Deskripsi Pakan',
                                controller: state.desc,
                                hint: 'Ex: Bahan pakan ikan',
                                isMoreText: true,
                                isEdit: false,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextFieldWidget(
                                    label: 'Protein',
                                    controller: state.protein,
                                    isLong: false,
                                    numberOutput: true,
                                    hint: 'Ex: 10',
                                    isEdit: false,
                                    suffixSection: const Icon(
                                      Icons.percent,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextFieldWidget(
                                    label: 'Karbon',
                                    controller: state.carbo,
                                    isLong: false,
                                    numberOutput: true,
                                    hint: 'Ex: 10',
                                    isEdit: false,
                                    suffixSection: const Icon(
                                      Icons.percent,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextFieldWidget(
                                    label: 'Min. Expired',
                                    controller: state.minExp,
                                    isLong: false,
                                    numberOutput: true,
                                    hint: 'Ex: 10',
                                    isEdit: false,
                                    suffixSection: Text(
                                      'hari',
                                      style: headingText3,
                                    ),
                                  ),
                                  TextFieldWidget(
                                    label: 'Max. Expired',
                                    controller: state.maxExp,
                                    isLong: false,
                                    numberOutput: true,
                                    hint: 'Ex: 10',
                                    isEdit: false,
                                    suffixSection: Text(
                                      'hari',
                                      style: headingText3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ],
              ),
        // const SizedBox(
        //   height: 16,
        // ),
        // Text(
        //   'Gambar (Struk)',
        //   style: headingText2,
        // ),
        // const SizedBox(
        //   height: 12,
        // ),
        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(12),
        //     color: Colors.grey,
        //   ),
        //   width: MediaQuery.of(context).size.width,
        //   height: 300,
        //   child: Image.network(
        //     'https://1.bp.blogspot.com/-9tt1qS0wO-8/X8uLEZd9HGI/AAAAAAAAAnQ/4uGdwluBvYg-cwgjFAf85P_MzITSUos1ACLcBGAsYHQ/s1078/Pakan.png',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        const SizedBox(
          height: 36,
        ),
        Obx(
          () => state.isSheetEditable.value
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: addButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    if (state.listPakanName.isEmpty ||
                        state.price.text == '' ||
                        state.amount.text == '') {
                      Flushbar(
                        message: "Gagal, Form tidak sesuai",
                        duration: Duration(seconds: 3),
                        leftBarIndicatorColor: Colors.red[400],
                      ).show(context);
                    } else {
                      await state.updateData(
                        id,
                        () => {
                          state.getAllData(
                            state.pageIdentifier.value,
                            () {},
                          ),
                          Navigator.pop(context),
                          state.resetFeedVariables(),
                        },
                      );
                    }
                  },
                  child: Obx(
                    () => state.isLoadingPost.value
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Simpan',
                            style: headingText2,
                          ),
                  ),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Ubah Data'),
                            content: const Text(
                                'Apakah anda yakin ingin mengubah data ini?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Tidak'),
                                child: const Text('Tidak'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  state.setSheetFeedVariableEdit(true);
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text('Ya'),
                              ),
                            ],
                          );
                        });
                  },
                  child: Text(
                    'Ubah',
                    style: headingText2,
                  ),
                ),
        ),
        const SizedBox(
          height: 12,
        ),
        ElevatedButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Hapus Data'),
                    content: const Text(
                        'Apakah anda yakin ingin menghapus data ini?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await state.deleteData(
                              state.feedList.value.data![index].idInt!,
                              () => {
                                    state.getAllData(
                                      state.pageIdentifier.value,
                                      () {},
                                    ),
                                  });
                          if (context.mounted) Navigator.of(context).pop();
                          if (context.mounted) Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Obx(
            () => state.isLoadingDelete.value
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Hapus',
                    style: headingText2,
                  ),
          ),
        ),
      ],
    );
  }
}

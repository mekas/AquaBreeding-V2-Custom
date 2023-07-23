import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:fish/models/inventaris/pakan/inventaris_pakan_model.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RenderInventarisPakanListWidget extends StatefulWidget {
  const RenderInventarisPakanListWidget({Key? key, required this.data})
      : super(key: key);

  final InventarisPakanModel data;

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
    return Obx(() => state.feedList.value.data!.isEmpty
        ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3,
            ),
          )
        : Container(
            margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: padding4XL),
              itemCount: widget.data.data!.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () async {
                    state.setSheetVariableEdit(false);
                    inspect(state.feedNameList.value);
                    await state.getDataByID(
                        state.feedList.value.data![index].idInt!, () {
                      getBottomSheet(
                          index, state.feedList.value.data![index].idInt!);
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tanggal :',
                                style: headingText3,
                              ),
                              Text(
                                state.dateFormat(
                                  state.feedList.value.data![index].createdAt!
                                      .toString(),
                                ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nama / Merek',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    widget.data.data![index].brandName!,
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
                                    '${widget.data.data![index].amount!.toStringAsFixed(2)} kg',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        widget.data.data![index]
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
          ));
  }

  getBottomSheet(int index, int id) {
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
          'Nama Suplemen',
          style: headingText2,
        ),
        const SizedBox(
          height: 12,
        ),
        state.listPakanName.isEmpty
            ? Center(
                child: Text(
                  'Tidak ada data',
                  style: headingText3.copyWith(
                    color: Colors.red,
                  ),
                ),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                        },
                        value: state.selectedPakan.value,
                        dropdownColor: inputColor,
                        items: state.listPakanName
                            .map<DropdownMenuItem<Map<String, dynamic>>>(
                                (material) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: material,
                            child: Text(
                              material['pakan_name'],
                              style: headingText3,
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
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
                label: 'Karbo',
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
                isEdit: state.amountEdit.value,
                hint: 'Ex: 1.5',
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
                isEdit: state.priceEdit.value,
                hint: 'Ex: 10',
                prefixSection: Text(
                  'Rp',
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
                          state.resetVariables(),
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
                                  state.setSheetVariableEdit(true);
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

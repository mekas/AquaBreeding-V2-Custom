import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/detail_inventaris_bahan_budidaya/detail_inventaris_bahan_budidaya_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_state.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/detail_inventaris_pakan/detail_inventaris_pakan_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';

import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/dialog_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventarisBahanBudidayaMainpage extends StatefulWidget {
  const InventarisBahanBudidayaMainpage({super.key});

  @override
  State<InventarisBahanBudidayaMainpage> createState() =>
      _InventarisBahanBudidayaMainpageState();
}

class _InventarisBahanBudidayaMainpageState
    extends State<InventarisBahanBudidayaMainpage> {
  InventarisBahanBudidayaState state = Get.put(InventarisBahanBudidayaState());

  DateTime currDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getAllData('obat', () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor1,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return DetailInventarisBahanBudidayaMainpage();
              })));
            },
            icon: const Icon(Icons.history),
          ),
        ],
        title: const Text('Suplemen'),
      ),
      body: Obx(
        () => Container(
          color: backgroundColor1,
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16),
                  height: 35,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: state.filterList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            state.currIndexFilter.value = index + 1;
                            state.functionCategory.value = state
                                    .filterList[state.currIndexFilter.value - 1]
                                ['title'];
                            state.pageIdentifier.value = state
                                    .filterList[state.currIndexFilter.value - 1]
                                ['key'];
                          });
                          await state.getAllData(
                              state.pageIdentifier.value, () {});
                        },
                        child: Container(
                          width: state.filterList[index]['title'] ==
                                      'Perawatan Air' ||
                                  state.filterList[index]['title'] ==
                                      'Feed Additive'
                              ? 150
                              : 100,
                          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: state.currIndexFilter.value ==
                                    state.filterList[index]['title_id']
                                ? Colors.white
                                : backgroundColor2,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            state.filterList[index]['title'],
                            style: headingText3.copyWith(
                              color: state.currIndexFilter.value ==
                                      state.filterList[index]['title_id']
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                state.isLoadingPage.value
                    ? Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 2,
                        ),
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
                    : state.suplemenList.value.data!.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 2,
                            ),
                            child: Center(
                              child: Text(
                                'Tidak ada data',
                                style: headingText3,
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              padding:
                                  const EdgeInsets.only(bottom: padding4XL),
                              itemCount: state.suplemenList.value.data!.length,
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    await state.getDataByID(
                                        state.suplemenList.value.data![index]
                                            .idInt!, () {
                                      getBottomSheet(
                                          index,
                                          state.suplemenList.value.data![index]
                                              .idInt!,
                                          true);
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 14),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: primaryColor),
                                      borderRadius: BorderRadius.circular(14),
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
                                              'Nama / Merek',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              state.suplemenList.value
                                                  .data![index].name!,
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
                                              '${state.suplemenList.value.data![index].amount!.toStringAsFixed(2)} ${state.suplemenList.value.data![index].type!}',
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
                                                      .suplemenList
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
                                );
                              }),
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade600,
        onPressed: () {
          state.resetVariables();
          getBottomSheet(0, 0, false);
        },
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }

  getBottomSheet(int index, int id, bool editable) {
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
          editable ? 'Edit Bahan' : 'Catat Bahan',
          style: headingText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 54,
        ),
        editable
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fungsi : ${state.functionCategory.value}',
                    style: headingText2,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              )
            : Container(),
        TextFieldWidget(
          label: 'Nama / Merek Bahan',
          controller: state.name,
          hint: 'Ex: Tepung',
        ),
        const SizedBox(
          height: 16,
        ),
        editable
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Fungsi',
                    style: headingText2,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: inputColor,
                    ),
                    child: StatefulBuilder(
                      builder: ((context, setState) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton(
                            onChanged: ((String? value) {
                              state.resetVariables();

                              setState(() {
                                state.functionCategory.value = value!;
                              });
                              state.functionCategory.value = value!;
                            }),
                            value: state.functionCategory.value,
                            dropdownColor: inputColor,
                            items: state.dropdownList.map(
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
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
        TextFieldWidget(
          label: 'Deskripsi Bahan',
          controller: state.desc,
          isMoreText: true,
          hint: 'Ex: Bahan kimia',
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: TextFieldWidget(
                          label: 'Jumlah',
                          controller: state.amount,
                          isLong: false,
                          numberOutput: true,
                          hint: 'Ex: 1',
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: inputColor,
                        ),
                        child: StatefulBuilder(
                          builder: ((context, setState) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton(
                                onChanged: ((String? value) {
                                  setState(() {
                                    state.typeCategory.value = value!;
                                  });
                                  state.typeCategory.value = value!;
                                }),
                                value: state.typeCategory.value,
                                dropdownColor: inputColor,
                                items: state.dropdownList2.map(
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
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  TextFieldWidget(
                    label: 'Harga Beli',
                    controller: state.price,
                    isLong: false,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    prefixSection: Text(
                      'Rp',
                      style: headingText3,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFieldWidget(
              label: 'Min. Expired',
              controller: state.minExp,
              isLong: false,
              numberOutput: true,
              hint: 'Ex: 10',
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
              suffixSection: Text(
                'hari',
                style: headingText3,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Gambar (Struk)',
          style: headingText2,
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey,
          ),
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Image.network(
            'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/06/28062837/vector_5.kesehatan-vitamin-dan-suplemen.jpg',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 36,
        ),
        editable
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: addButtonColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () async {
                      if (state.name.text == '' ||
                          state.price.text == '' ||
                          state.desc.text == '' ||
                          state.amount.text == '' ||
                          state.minExp.text == '' ||
                          state.image.value == '') {
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
                            state.resetVariables(),
                            Navigator.pop(context),
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
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await state.deleteData(
                                        state.suplemenList.value.data![index]
                                            .idInt!,
                                        () => {
                                              state.getAllData(
                                                state.pageIdentifier.value,
                                                () {},
                                              ),
                                            });
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
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
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: addButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () async {
                  if (state.name.text == '' ||
                      state.price.text == '' ||
                      state.desc.text == '' ||
                      state.amount.text == '' ||
                      state.minExp.text == '' ||
                      state.image.value == '') {
                    Flushbar(
                      message: "Gagal, Form tidak sesuai",
                      duration: Duration(seconds: 3),
                      leftBarIndicatorColor: Colors.red[400],
                    ).show(context);
                  } else {
                    await state.postData(
                      () => {
                        state.getAllData(
                          state.pageIdentifier.value,
                          () {},
                        ),
                        state.resetVariables(),
                        Navigator.pop(context),
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
                      : Icon(
                          Icons.add,
                        ),
                ),
              ),
      ],
    );
  }
}

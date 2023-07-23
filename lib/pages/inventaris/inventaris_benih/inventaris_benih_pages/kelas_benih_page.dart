import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/convert_to_rupiah_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KelasBenihPage extends StatefulWidget {
  KelasBenihPage({super.key});

  @override
  State<KelasBenihPage> createState() => _KelasBenihPageState();
}

class _KelasBenihPageState extends State<KelasBenihPage> {
  final InventarisBenihState state = Get.put(InventarisBenihState());

  @override
  void initState() {
    super.initState();
    state.pageIdentifier.value = 'benih';
    state.seedCategory.value = 'Benih';
    state.setSheetVariableEdit(false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getAllSeedData('benih');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => state.isLoadingPage.value
          ? Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          : state.seedList.value.data!.isEmpty
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
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: padding4XL),
                    itemCount: state.seedList.value.data!.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await state.getSeedDataByID(
                              state.seedList.value.data![index].idInt!, () {
                            getBottomSheet(index,
                                state.seedList.value.data![index].idInt!);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: primaryColor),
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
                                        state.seedList.value.data![index]
                                            .createdAt!
                                            .toString(),
                                      ),
                                      style: headingText3,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Tahun',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              state.seedList.value.data![index]
                                                  .createdAt
                                                  .toString()
                                                  .split('-')[0],
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
                                              'Jenis Ikan',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              state.seedList.value.data![index]
                                                  .fishType
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
                                          children: [
                                            Text(
                                              'Uk. Sortir',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              state.seedList.value.data![index]
                                                  .width
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
                                              '${state.seedList.value.data![index].amount} ekor',
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
                                    SizedBox(height: 8),
                                    Divider(color: Colors.white),
                                    SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Harga Satuan : ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          'Rp${ConvertToRupiah.formatToRupiah(state.seedList.value.data![index].price!)} / ekor',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Harga Total : ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          'Rp${ConvertToRupiah.formatToRupiah(state.seedList.value.data![index].totalPrice!)}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
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
                ),
    );
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
          'Edit Benih',
          style: headingText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 54,
        ),
        Text(
          'Kategori : ${state.seedCategory.value}',
          style: headingText2,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Jenis Ikan',
          style: headingText2,
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
          child: StatefulBuilder(
            builder: ((context, setState) {
              return DropdownButtonHideUnderline(
                child: DropdownButton(
                  onChanged: ((String? value) {
                    setState(() {
                      state.fishCategory.value = value!;
                    });
                  }),
                  value: state.fishCategory.value,
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
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Satuan Sortir',
                  style: headingText2,
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
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
                            setState(() {
                              state.sortSize.value = value!;
                            });
                          }),
                          value: state.sortSize.value,
                          dropdownColor: inputColor,
                          items: state.dropdownList3.map(
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
            Obx(
              () => TextFieldWidget(
                label: 'Jumlah',
                controller: state.fishAmount,
                hint: 'Ex: 1000',
                isLong: false,
                numberOutput: true,
                isEdit: state.fishAmountEdit.value,
                onChange: (String v) {
                  state.fishPriceTotal.text = (int.parse(
                              state.fishPrice.text == ''
                                  ? '0'
                                  : state.fishPrice.text) *
                          int.parse(state.fishAmount.text))
                      .round()
                      .toString();
                },
                suffixSection: Text(
                  'ekor',
                  style: headingText3,
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
                label: 'Harga Beli Satuan',
                controller: state.fishPrice,
                hint: 'Ex: 10000',
                isLong: false,
                numberOutput: true,
                isEdit: state.fishPriceEdit.value,
                prefixSection: Text(
                  'Rp',
                  style: headingText3,
                ),
                onChange: (String v) {
                  if (state.fishAmount.text == '') {
                    state.fishPrice.clear();
                    state.fishPriceTotal.clear();
                    Flushbar(
                      message: "Masukkan jumlah terlebih dahulu",
                      duration: Duration(seconds: 3),
                      leftBarIndicatorColor: Colors.red[400],
                    ).show(context);
                  } else {
                    state.fishPriceTotal.text = (int.parse(
                                state.fishPrice.text == ''
                                    ? '0'
                                    : state.fishPrice.text) *
                            int.parse(state.fishAmount.text))
                        .round()
                        .toString();
                  }
                },
              ),
              TextFieldWidget(
                label: 'Harga Beli Total',
                controller: state.fishPriceTotal,
                hint: 'Ex: 10000',
                isLong: false,
                numberOutput: true,
                isEdit: state.fishPriceTotalEdit.value,
                prefixSection: Text(
                  'Rp',
                  style: headingText3,
                ),
                onChange: (String v) {
                  if (state.fishAmount.text == '') {
                    state.fishPrice.clear();
                    state.fishPriceTotal.clear();
                    Flushbar(
                      message: "Masukkan jumlah terlebih dahulu",
                      duration: Duration(seconds: 3),
                      leftBarIndicatorColor: Colors.red[400],
                    ).show(context);
                  } else {
                    state.fishPrice.text = (int.parse(
                                state.fishPriceTotal.text == ''
                                    ? '0'
                                    : state.fishPriceTotal.text) /
                            int.parse(state.fishAmount.text))
                        .round()
                        .toString();
                  }
                },
              ),
            ],
          ),
        ),
        // const SizedBox(
        //   height: 16,
        // ),
        // Text(
        //   'Gambar',
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
        //     'https://www.hepper.com/wp-content/uploads/2022/09/red-male-betta-fish-in-aquarium_Grigorii-Pisotscki-Shutterstock.jpg',
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
                    if (state.fishAmount.text == '' ||
                        state.fishPrice.text == '' ||
                        state.fishPriceTotal.text == '') {
                      Flushbar(
                        message: "Gagal, Form tidak sesuai",
                        duration: Duration(seconds: 3),
                        leftBarIndicatorColor: Colors.red[400],
                      ).show(context);
                    } else {
                      await state.updateSeedData(
                        id,
                        () => {
                          state.getAllSeedData('benih'),
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
                          await state.deleteSeedData(
                              state.seedList.value.data![index].idInt!,
                              () => {
                                    state.getAllSeedData('Benih'),
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

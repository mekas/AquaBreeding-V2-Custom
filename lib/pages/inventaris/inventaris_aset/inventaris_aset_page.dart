import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/inventaris/inventaris_aset/add_asset.dart';
import 'package:fish/pages/inventaris/inventaris_aset/inventaris_aset_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/convert_to_rupiah_widget.dart';
import 'package:fish/widgets/dialog_widget.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/new_Menu_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class InventarisAsetPage extends StatefulWidget {
  const InventarisAsetPage({Key? key}) : super(key: key);

  @override
  State<InventarisAsetPage> createState() => _InventarisAsetPageState();
}

class _InventarisAsetPageState extends State<InventarisAsetPage> {
  final InventarisAsetState state = Get.put(InventarisAsetState());
  var isMenuTapped = false.obs;
  DateTime currDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id', null);
    state.setSheetVariableEdit(false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getAllData(
          'alat', state.firstDate.text, state.lastDate.text, () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text('Aset'),
        actions: [
          IconButton(
            onPressed: () {
              // scaffoldKey.currentState?.openEndDrawer();
              setState(() {
                isMenuTapped.value = !isMenuTapped.value;
              });
            },
            icon: Icon(Icons.card_travel_rounded),
          ),
          IconButton(
            onPressed: () {
              openDateDialogPicker(context);
            },
            icon: Icon(Icons.filter_list_rounded),
          )
        ],
      ),
      endDrawer: DrawerInvetarisList(),
      body: Obx(
        () => Container(
          color: backgroundColor1,
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: SafeArea(
            child: Column(
              children: [
                if (isMenuTapped.value)
                  Column(
                    children: [
                      newMenu(),
                      SizedBox(height: 10,),
                    ],
                  ),
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
                          state.resetVariables();
                          setState(() {
                            state.currIndexFilter.value = index + 1;
                            state.assetCategory.value = state
                                    .filterList[state.currIndexFilter.value - 1]
                                ['title'];
                            state.pageIdentifier.value = state
                                    .filterList[state.currIndexFilter.value - 1]
                                ['key'];
                          });
                          await state.getAllData(state.pageIdentifier.value,
                              state.firstDate.text, state.lastDate.text, () {});
                        },
                        child: Container(
                          width: state.filterList[index]['title'] ==
                                  'Perlengkapan Habis Pakai'
                              ? 200
                              : 150,
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
                    : state.assetList.value.data!.isEmpty
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
                            margin: const EdgeInsets.fromLTRB(4, 8, 4, 20),
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.only(bottom: padding4XL),
                              itemCount: state.assetList.value.data!.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    state.setSheetVariableEdit(false);

                                    await state.getDataByID(
                                        state.assetList.value.data![index]
                                            .idInt!, () {
                                      // getBottomSheet(
                                      //     index,
                                      //     state.assetList.value.data![index]
                                      //         .idInt!,
                                      //     true);
                                      Get.to(() => AddorEditAsset(index: index, id: state.assetList.value.data![index]
                                          .idInt!, isEditable: true));
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        16, 8, 16, 12),
                                    decoration: BoxDecoration(
                                      color: backgroundColor1,
                                      border: Border.all(
                                          width: 2, color: primaryColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
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
                                                state.dateFormat(state
                                                    .assetList
                                                    .value
                                                    .data![index]
                                                    .createdAt!
                                                    .toString()),
                                                style: headingText3,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Nama : ',
                                                    style: headingText3,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '.' * 100000,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    state.assetList.value
                                                        .data![index].name
                                                        .toString(),
                                                    style: headingText3,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Harga Beli : ',
                                                    style: headingText3,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '.' * 100000,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Rp${ConvertToRupiah.formatToRupiah(state.assetList.value.data![index].price!)}',
                                                    style: headingText3,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Jumlah : ',
                                                    style: headingText3,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '.' * 100000,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${state.assetList.value.data![index].amount.toString()} buah',
                                                    style: headingText3,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Umur Aset : ',
                                                    style: headingText3,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '.' * 100000,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    state.findDateRange(
                                                        currDate,
                                                        state
                                                            .assetList
                                                            .value
                                                            .data![index]
                                                            .createdAt
                                                            .toString()),
                                                    style: headingText3,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                'Deskripsi :',
                                                style: headingText3,
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color: backgroundColor2,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  state
                                                              .assetList
                                                              .value
                                                              .data![index]
                                                              .description
                                                              .toString() ==
                                                          ''
                                                      ? '-'
                                                      : state
                                                          .assetList
                                                          .value
                                                          .data![index]
                                                          .description
                                                          .toString(),
                                                  style: headingText3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
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
          state.setSheetVariableEdit(true);
          // getBottomSheet(0, 0, false);
          Get.to(() => AddorEditAsset(index: 0, id: 0, isEditable: false));
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
          editable ? 'Edit Aset' : 'Catat Aset',
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
                    'Kategori : ${state.assetCategory.value}',
                    style: headingText2,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              )
            : Container(),
        editable
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Kategori Aset',
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
                              setState(() {
                                state.assetCategory.value = value!;
                              });
                            }),
                            value: state.assetCategory.value,
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
        Obx(
          () => TextFieldWidget(
            label: 'Nama Aset',
            controller: state.name,
            hint: 'Ex: Filter Air',
            isEdit: state.nameEdit.value,
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
                hint: 'Ex: 2',
                isEdit: state.amountEdit.value,
                suffixSection: Text(
                  'buah',
                  style: headingText3,
                ),
              ),
              TextFieldWidget(
                label: 'Harga Beli',
                controller: state.price,
                hint: 'Ex: 50000',
                isLong: false,
                isEdit: state.priceEdit.value,
                prefixSection: Text(
                  'Rp',
                  style: headingText2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(
          () => TextFieldWidget(
            label: 'Deskripsi',
            controller: state.desc,
            isMoreText: true,
            hint: 'Ex: memfilter air kolam',
            isEdit: state.descEdit.value,
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
        //     'https://lh3.googleusercontent.com/p/AF1QipPgPgQ17AeKRLeQWWb3sZYRtkyoJndsRMKE8rNc=w1080-h608-p-no-v0',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        const SizedBox(
          height: 36,
        ),
        editable
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                              if (state.name.text == '' ||
                                  state.price.text == '' ||
                                  state.amount.text == '' ||
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
                                      state.firstDate.text,
                                      state.lastDate.text,
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
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await state.deleteData(
                                        state.assetList.value.data![index]
                                            .idInt!,
                                        () => {
                                              state.getAllData(
                                                state.pageIdentifier.value,
                                                state.firstDate.text,
                                                state.lastDate.text,
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
                      state.amount.text == '' ||
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
                          state.firstDate.text,
                          state.lastDate.text,
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

  openDateDialogPicker(BuildContext context) {
    DialogWidget.open(
      context,
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                size: 20,
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 12),
              child: Text(
                'Pilih Tanggal',
                style: headingText2,
                textAlign: TextAlign.center,
              ),
            ),
            Container(),
          ],
        ),
        SizedBox(
          height: 36,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                final DateTime? datePicker = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                state.firstDate.text = datePicker.toString().split(' ')[0];
              },
              child: TextFieldWidget(
                label: 'Tanggal Awal',
                controller: state.firstDate,
                isLong: false,
                isEdit: false,
                suffixSection: Icon(
                  Icons.arrow_drop_down_circle_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final DateTime? datePicker = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                state.lastDate.text = datePicker.toString().split(' ')[0];
              },
              child: TextFieldWidget(
                label: 'Tanggal Akhir',
                controller: state.lastDate,
                isLong: false,
                isEdit: false,
                suffixSection: Icon(
                  Icons.arrow_drop_down_circle_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: addButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () async {
            await state.getAllData(
              state.pageIdentifier.value,
              state.firstDate.text,
              state.lastDate.text,
              () {
                Navigator.pop(context);
              },
            );
          },
          child: Icon(
            Icons.navigate_next_rounded,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

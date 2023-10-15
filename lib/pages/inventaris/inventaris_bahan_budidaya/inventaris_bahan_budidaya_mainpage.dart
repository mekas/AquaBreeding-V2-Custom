import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/add_or_edit_bahan_budidaya/add_bahan_budidaya.dart';
import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/detail_inventaris_bahan_budidaya/detail_inventaris_bahan_budidaya_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_state.dart';

import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/new_Menu_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'add_or_edit_bahan_budidaya/edit_bahan_budidaya.dart';

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
  var isMenuTapped = false.obs;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id', null);
    state.functionCategory.value = 'Obat';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getAllData('obat', () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor1,
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
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return DetailInventarisBahanBudidayaMainpage();
              })));
            },
            icon: const Icon(Icons.history),
          ),
        ],
        title: const Text('Suplemen'),
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
                          setState(() {
                            state.setSheetVariableEdit(false);
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
                                    state.setSheetVariableEdit(false);
                                    await state.getDataByID(
                                        state.suplemenList.value.data![index]
                                            .idInt!, () {
                                      // getBottomSheetEdit(
                                      //     index,
                                      //     state.suplemenList.value.data![index]
                                      //         .idInt!);
                                      Get.to(() => EditBahanBudidaya(index: index, id: state.suplemenList.value.data![index]
                                          .idInt!, isEditable: true));
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 14),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: primaryColor),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                                  state.suplemenList.value
                                                      .data![index].createdAt!
                                                      .toString(),
                                                  true,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  SizedBox(height: 6),
                                                  Text(
                                                    state.suplemenList.value
                                                        .data![index].name!,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  SizedBox(height: 6),
                                                  Text(
                                                    '${state.suplemenList.value.data![index].amount!.toStringAsFixed(2)} ${state.suplemenList.value.data![index].type!}',
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                          ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.green.shade600,
      //   onPressed: () {
      //     state.resetVariables();
      //     getBottomSheet(0, 0, false);
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     size: 32,
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          state.resetVariables();
          // getBottomSheet(0, 0, false);
          Get.to(() => AddBahanBudidaya(index: 0, id: 0, isEditable: false));

        },
        backgroundColor: Colors.green.shade600,
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }

  // getListNameBottomSheet() {
  //   state.resetVariables();

  //   BottomSheetWidget.getBottomSheetWidget(context, [
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         GestureDetector(
  //           onTap: () {
  //             Navigator.pop(context);
  //           },
  //           child: const CircleAvatar(
  //             backgroundColor: Colors.red,
  //             radius: 12,
  //             child: Icon(
  //               Icons.arrow_back_ios_new_rounded,
  //               size: 14,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     const SizedBox(
  //       height: 18,
  //     ),
  //     Text(
  //       'List Semua Nama Suplemen',
  //       style: headingText1,
  //       textAlign: TextAlign.center,
  //     ),
  //     const SizedBox(
  //       height: 54,
  //     ),
  //     Obx(
  //       () => state.isLoadingDetail.value
  //           ? Center(
  //               child: SizedBox(
  //                 width: 20,
  //                 height: 20,
  //                 child: CircularProgressIndicator(
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             )
  //           : ListView.builder(
  //               itemBuilder: (context, index) {
  //                 return Container(
  //                   margin: EdgeInsets.only(bottom: 8),
  //                   decoration: BoxDecoration(
  //                     color: backgroundColor2,
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: ListTile(
  //                     title: Text(
  //                       state.suplemenNameList.value.data![index].name!,
  //                       style: headingText3,
  //                     ),
  //                     trailing: IconButton(
  //                       onPressed: () async {
  //                         await state.deleteSuplemenName(
  //                             state.suplemenNameList.value.data![index].idInt!,
  //                             () async {
  //                           Flushbar(
  //                             message: "Nama berhasil dihapus",
  //                             duration: Duration(seconds: 2),
  //                             leftBarIndicatorColor: Colors.green,
  //                           ).show(context);
  //                           await state.getSuplemenNameData('');
  //                         });
  //                       },
  //                       icon: Icon(
  //                         Icons.delete,
  //                         color: Colors.red.shade900,
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //               shrinkWrap: true,
  //               // padding: const EdgeInsets.only(bottom: padding4XL),
  //               itemCount: state.suplemenNameList.value.data!.length,
  //             ),
  //     )
  //   ]);
  // }

  // addNameBottomSheet() {
  //   state.resetVariables();
  //   state.suplemenName.clear();
  //   BottomSheetWidget.getBottomSheetWidget(context, [
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         GestureDetector(
  //           onTap: () {
  //             Navigator.pop(context);
  //           },
  //           child: const CircleAvatar(
  //             backgroundColor: Colors.red,
  //             radius: 12,
  //             child: Icon(
  //               Icons.arrow_back_ios_new_rounded,
  //               size: 14,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),
  //         GestureDetector(
  //           onTap: () async {
  //             await state.getSuplemenNameData('');
  //             getListNameBottomSheet();
  //           },
  //           child: const CircleAvatar(
  //             backgroundColor: Colors.white,
  //             radius: 12,
  //             child: Icon(
  //               Icons.list,
  //               size: 14,
  //               color: Colors.black,
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //     const SizedBox(
  //       height: 18,
  //     ),
  //     Text(
  //       'Catat Nama Suplemen',
  //       style: headingText1,
  //       textAlign: TextAlign.center,
  //     ),
  //     const SizedBox(
  //       height: 54,
  //     ),
  //     Text(
  //       'Fungsi',
  //       style: headingText2,
  //     ),
  //     const SizedBox(
  //       height: 12,
  //     ),
  //     Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8),
  //         color: inputColor,
  //       ),
  //       child: StatefulBuilder(
  //         builder: ((context, setState) {
  //           return DropdownButtonHideUnderline(
  //             child: DropdownButton(
  //               onChanged: ((String? value) {
  //                 setState(() {
  //                   state.functionCategory.value = value!;
  //                 });
  //                 state.functionCategory.value = value!;
  //                 state.resetVariables();
  //               }),
  //               value: state.functionCategory.value,
  //               dropdownColor: inputColor,
  //               items: state.dropdownList.map(
  //                 (String val) {
  //                   return DropdownMenuItem(
  //                     value: val,
  //                     child: Text(
  //                       val,
  //                       style: headingText3,
  //                     ),
  //                   );
  //                 },
  //               ).toList(),
  //             ),
  //           );
  //         }),
  //       ),
  //     ),
  //     const SizedBox(
  //       height: 16,
  //     ),
  //     TextFieldWidget(
  //       label: 'Nama Suplemen',
  //       controller: state.suplemenName,
  //       hint: 'Input nama suplemen',
  //     ),
  //     const SizedBox(
  //       height: 36,
  //     ),
  //     ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: addButtonColor,
  //         padding: const EdgeInsets.symmetric(vertical: 12),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8.0),
  //         ),
  //       ),
  //       onPressed: () async {
  //         await state.postSuplemenNameData(() async {
  //           Flushbar(
  //             message: "Nama berhasil ditambahkan",
  //             duration: Duration(seconds: 2),
  //             leftBarIndicatorColor: Colors.green,
  //           ).show(context);
  //           await state.getSuplemenNameData('');
  //         });
  //       },
  //       child: Obx(
  //         () => state.isLoadingPost.value
  //             ? SizedBox(
  //                 width: 20,
  //                 height: 20,
  //                 child: CircularProgressIndicator(
  //                   color: Colors.white,
  //                 ),
  //               )
  //             : Icon(
  //                 Icons.add,
  //               ),
  //       ),
  //     ),
  //   ]);
  // }

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
        Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: inputColor,
              ),
              child: StatefulBuilder(
                builder: ((context, setState) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton(
                      onChanged: ((String? value) async {
                        state.resetVariables();

                        setState(() {
                          state.functionCategory.value = value!;
                        });
                        state.functionCategory.value = value!;
                        inspect(state.functionCategory.value);
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
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //     color: inputColor,
        //   ),
        //   child: StatefulBuilder(
        //     builder: ((context, setState) {
        //       return DropdownButtonHideUnderline(
        //         child: DropdownButton<Map<String, dynamic>>(
        //           onChanged: (value) async {
        //             setState(() {
        //               state.selectedSuplemen.value = value!;
        //             });
        //             state.selectedSuplemen.value = value!;
        //             state.isSuplemenSelected.value = true;
        //             // state.name.text
        //             state.resetVariables();
        //           },
        //           value: state.selectedSuplemen.value,
        //           dropdownColor: inputColor,
        //           items: state.listSuplemenName
        //               .map<DropdownMenuItem<Map<String, dynamic>>>((material) {
        //             return DropdownMenuItem<Map<String, dynamic>>(
        //               value: material,
        //               child: Text(
        //                 material['suplemen_name'],
        //                 style: headingText3,
        //               ),
        //             );
        //           }).toList(),
        //         ),
        //       );
        //     }),
        //   ),
        // ),
        Obx(
          () => state.functionCategory.value == 'Feed Additive'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Nama Suplemen',
                      style: headingText2,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
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
                            child: DropdownButton(
                              onChanged: ((String? value) {
                                setState(() {
                                  state.selectedFeedAdditive.value = value!;
                                });
                                state.selectedFeedAdditive.value = value!;
                              }),
                              value: state.selectedFeedAdditive.value,
                              dropdownColor: inputColor,
                              items: state.listFeedAdditive.map(
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
                    )
                  ],
                )
              : TextFieldWidget(
                  label: 'Nama Suplemen',
                  controller: state.name,
                  isLong: true,
                  hint: 'Ex: garam',
                ),
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
        Obx(
          () => TextFieldWidget(
            isEnableSwitch: true,
            switchOnChange: (v) {
              state.descSwitchValue.value = v;
            },
            switchValue: state.descSwitchValue.value,
            label: 'Deskripsi Bahan',
            controller: state.desc,
            isMoreText: true,
            hint: 'Ex: Bahan kimia',
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
                isEnableSwitch: true,
                switchOnChange: (v) {
                  state.minSwitchValue.value = v;
                },
                switchValue: state.minSwitchValue.value,
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
                isEnableSwitch: true,
                switchOnChange: (v) {
                  state.maxSwitchValue.value = v;
                },
                switchValue: state.maxSwitchValue.value,
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
        //     'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/06/28062837/vector_5.kesehatan-vitamin-dan-suplemen.jpg',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        const SizedBox(
          height: 36,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: addButtonColor,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () async {
            if (state.price.text == '' || state.amount.text == '') {
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

  getBottomSheetEdit(int index, int id) {
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
          'Edit Bahan',
          style: headingText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 54,
        ),
        Column(
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
        ),
        Obx(
          () => state.functionCategory.value == 'Feed Additive'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Nama Suplemen',
                      style: headingText2,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
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
                            child: DropdownButton(
                              onChanged: ((String? value) {
                                setState(() {
                                  state.selectedFeedAdditive.value = value!;
                                });
                                state.selectedFeedAdditive.value = value!;
                              }),
                              value: state.selectedFeedAdditive.value,
                              dropdownColor: inputColor,
                              items: state.listFeedAdditive.map(
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
                    )
                  ],
                )
              : TextFieldWidget(
                  label: 'Nama Suplemen',
                  controller: state.name,
                  hint: 'Ex: garam',
                  isEdit: state.nameEdit.value,
                ),
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(
          () => TextFieldWidget(
            label: 'Deskripsi Bahan',
            controller: state.desc,
            isMoreText: true,
            hint: 'Ex: Bahan kimia',
            isEdit: state.descEdit.value,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(
          () => Row(
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
                      isEdit: state.amountEdit.value,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
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
                isEdit: state.priceEdit.value,
                prefixSection: Text(
                  'Rp',
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
                isLong: false,
                numberOutput: true,
                hint: 'Ex: 10',
                isEdit: state.maxExpEdit.value,
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
        //     'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/06/28062837/vector_5.kesehatan-vitamin-dan-suplemen.jpg',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        const SizedBox(
          height: 36,
        ),
        Column(
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
                              await state.deleteData(
                                  state.suplemenList.value.data![index].idInt!,
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
      ],
    );
  }
}

import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/add_name_and_feed_screens/add_custom_feed.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/detail_inventaris_pakan/detail_inventaris_pakan_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_pages/pakan_alami_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_pages/pakan_industri_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/pakan_custom_controller.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'add_name_and_feed_screens/add_feed.dart';
import 'add_name_and_feed_screens/add_feed_name.dart';
import 'inventaris_pakan_pages/new_pakan_campuran_page.dart';

class InventarisPakanMainpage extends StatefulWidget {
  const InventarisPakanMainpage({super.key});

  @override
  State<InventarisPakanMainpage> createState() =>
      _InventarisPakanMainpageState();
}

class _InventarisPakanMainpageState extends State<InventarisPakanMainpage> {
  InventarisPakanState state = Get.put(InventarisPakanState());
  final PakanCustomController controller =
  Get.put(PakanCustomController());
  var isMenuTapped = false.obs;
  var page = ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting('id', null);
    state.isProbSelected.value = false;
    state.isCarbSelected.value = false;
    state.carbCheck.value = false;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getAllSuplementData('obat', () {});
      state.getAllSuplementData('Probiotik', () {
        if (state.listCultureProbiotik.isNotEmpty) {
          state.getProbDetail(
            state.selectedCultureProbiotik.value['id'],
                () => null,
          );
          state.probID.value =
          state.selectedCultureProbiotik.value['suplemen_id'];
        }
      });

      state.getAllSuplementData('Feed Additive', () {
        if (state.listCarbon.isNotEmpty) {
          state.getCarbDetail(
            state.selectedCarbon.value['id'],
                () => null,
          );
          state.carbID.value = state.selectedCarbon.value['suplemen_id'];
        }
      });

      state.getSaltDetail(() {
        if (state.saltDetail.value.data!.isNotEmpty) {
          state.calculatedSaltStock.value = double.parse(
              state.saltDetail.value.data![0].amount!.toStringAsFixed(2));
          state.saltStock.value = double.parse(
              state.saltDetail.value.data![0].amount!.toStringAsFixed(2));
          state.saltID.value =
              state.saltDetail.value.data![0].sId.toString();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor2,
          elevation: 0,
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
                  return DetailInventarisPakanMainpage();
                })));
              },
              icon: const Icon(Icons.history),
            ),
          ],
          title: const Text('Pakan'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            onTap: (value) {
              setState(() {
                page.value = state.pageList[value];
              });
              print("page: ${page.value}");
            },
            tabs: [
              Tab(
                  child: Text(
                'Industri',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Tab(
                child: Text(
                  'Alami',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Custom',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        endDrawer: DrawerInvetarisList(),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            PakanIndustriPage(
              isMenuTapped: isMenuTapped.value,
            ),
            PakanAlamiPage(
              isMenuTapped: isMenuTapped.value,
            ),
            NewPakanCampuranPage(
              isMenuTapped: isMenuTapped.value,
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          backgroundColor: Colors.green.shade600,
          overlayColor: Colors.black,
          overlayOpacity: 0.6,
          spacing: 5,
          spaceBetweenChildren: 4,
          children: [
            SpeedDialChild(
              backgroundColor: Colors.green,
              labelStyle: headingText3,
              labelBackgroundColor: Colors.green,
              label: 'Tambah Pakan (+)',
              onTap: () async {
                print("current_page: ${page.value}");
                state.resetFeedVariables();
                state.resetNameVariables();
                if (page.value == "Custom") {
                  print("mengambil data pakan industri...");
                  await state.getPakanNameData('industri', () async {
                    await state.getDetailPakanNameData(
                        state.selectedPakan.value['id'], () => null);
                  });
                  Get.to(() => AddCustomFeed());
                } else {
                  await state.getPakanNameData(state.category.text, () async {
                    await state.getDetailPakanNameData(
                        state.selectedPakan.value['id'], () => null);
                  });
                  Get.to(() => AddFeed());
                }
              },
            ),
            if (page.value != "Custom")
              SpeedDialChild(
                backgroundColor: Colors.green,
                labelStyle: headingText3,
                labelBackgroundColor: Colors.green,
                label: 'Tambah Merk (+)',
                onTap: () {
                  state.resetNameVariables();
                  state.descSwitchValue.value = false;
                  state.proteinSwitchValue.value = false;
                  state.carbSwitchValue.value = false;
                  state.maxSwitchValue.value = false;
                  Get.to(() => AddFeedName());
                },
              ),
          ],
        ),
      ),
    );
  }

  addFeedBottomSheet() {
    state.resetFeedVariables();
    BottomSheetWidget.getBottomSheetWidget(context, [
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
        'Catat Pakan',
        style: headingText1,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 54,
      ),
      // Text(
      //   'Kategori Pakan',
      //   style: headingText2,
      // ),
      // const SizedBox(
      //   height: 12,
      // ),
      // Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(8),
      //     color: inputColor,
      //   ),
      //   child: StatefulBuilder(
      //     builder: ((context, setState) {
      //       return DropdownButtonHideUnderline(
      //         child: DropdownButton(
      //           onChanged: ((String? value) async {
      //             setState(() {
      //               state.feedCategory.value = value!;
      //             });
      //             state.feedCategory.value = value!;
      //             state.resetFeedVariables();
      //           }),
      //           value: state.feedCategory.value,
      //           dropdownColor: inputColor,
      //           items: state.dropdownList.map(
      //             (String val) {
      //               return DropdownMenuItem(
      //                 value: val,
      //                 child: Text(
      //                   val,
      //                   style: headingText3,
      //                 ),
      //               );
      //             },
      //           ).toList(),
      //         ),
      //       );
      //     }),
      //   ),
      // ),
      TextFieldWidget(
        label: 'Kategori Pakan',
        controller: state.category,
        isEdit: false,
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

                              state.resetFeedVariables();
                              await state.getDetailPakanNameData(
                                  state.selectedPakan.value['id'], () => null);
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFieldWidget(
            label: 'Jumlah',
            controller: state.amount,
            isLong: false,
            numberOutput: true,
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
            hint: 'Ex: 10',
            prefixSection: Text(
              'Rp',
              style: headingText3,
            ),
          ),
        ],
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
                          child: CircularProgressIndicator(color: Colors.white),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          if (state.listPakanName.isEmpty ||
              state.price.text == '' ||
              state.amount.text == '') {
            Flushbar(
              message: "Gagal, Form tidak sesuai",
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.red[400],
            ).show(context);
          } else {
            await state.postData(() async {
              Flushbar(
                message: "Pakan berhasil ditambahkan",
                duration: Duration(seconds: 2),
                leftBarIndicatorColor: Colors.green,
              ).show(context);
              await state.getAllData(state.feedCategory.value, () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
            });
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
    ]);
  }

  // addCustomFeedBottomSheet() {
  //   state.resetFeedVariables();
  //   BottomSheetWidget.getBottomSheetWidget(context, [
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         GestureDetector(
  //           onTap: () {
  //             Navigator.pop(context);
  //           },
  //           child: const CircleAvatar(
  //             backgroundColor: Colors.red,
  //             radius: 12,
  //             child: Icon(
  //               Icons.close,
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
  //       'Catat Pakan',
  //       style: headingText1,
  //       textAlign: TextAlign.center,
  //     ),
  //     const SizedBox(
  //       height: 54,
  //     ),
  //     // Text(
  //     //   'Kategori Pakan',
  //     //   style: headingText2,
  //     // ),
  //     // const SizedBox(
  //     //   height: 12,
  //     // ),
  //     // Container(
  //     //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //     //   decoration: BoxDecoration(
  //     //     borderRadius: BorderRadius.circular(8),
  //     //     color: inputColor,
  //     //   ),
  //     //   child: StatefulBuilder(
  //     //     builder: ((context, setState) {
  //     //       return DropdownButtonHideUnderline(
  //     //         child: DropdownButton(
  //     //           onChanged: ((String? value) async {
  //     //             setState(() {
  //     //               state.feedCategory.value = value!;
  //     //             });
  //     //             state.feedCategory.value = value!;
  //     //             state.resetFeedVariables();
  //     //           }),
  //     //           value: state.feedCategory.value,
  //     //           dropdownColor: inputColor,
  //     //           items: state.dropdownList.map(
  //     //             (String val) {
  //     //               return DropdownMenuItem(
  //     //                 value: val,
  //     //                 child: Text(
  //     //                   val,
  //     //                   style: headingText3,
  //     //                 ),
  //     //               );
  //     //             },
  //     //           ).toList(),
  //     //         ),
  //     //       );
  //     //     }),
  //     //   ),
  //     // ),
  //     TextFieldWidget(
  //       label: 'Kategori Pakan',
  //       controller: state.category,
  //       isEdit: false,
  //     ),
  //     const SizedBox(
  //       height: 16,
  //     ),
  //     Text(
  //       'List Pakan Industri',
  //       style: headingText2,
  //     ),
  //     const SizedBox(
  //       height: 12,
  //     ),
  //     Obx(
  //       () => state.isLoadingNameDetail.value
  //           ? Center(
  //               child: SizedBox(
  //                 width: 20,
  //                 height: 20,
  //                 child: CircularProgressIndicator(
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             )
  //           : state.listPakanName.isEmpty
  //               ? Center(
  //                   child: Text(
  //                     'Tidak ada data',
  //                     style: headingText3.copyWith(
  //                       color: Colors.red,
  //                     ),
  //                   ),
  //                 )
  //               : Container(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(8),
  //                     color: inputColor,
  //                   ),
  //                   child: StatefulBuilder(
  //                     builder: ((context, setState) {
  //                       return DropdownButtonHideUnderline(
  //                         child: DropdownButton<Map<String, dynamic>>(
  //                           onChanged: (value) async {
  //                             setState(() {
  //                               state.selectedPakan.value = value!;
  //                             });
  //                             state.selectedPakan.value = value!;
  //                             state.isPakanSelected.value = true;
  //                             // state.name.text
  //
  //                             state.resetFeedVariables();
  //                             await state.getDetailPakanNameData(
  //                                 state.selectedPakan.value['id'], () => null);
  //                           },
  //                           value: state.selectedPakan.value,
  //                           dropdownColor: inputColor,
  //                           items: state.listPakanName
  //                               .map<DropdownMenuItem<Map<String, dynamic>>>(
  //                                   (material) {
  //                             return DropdownMenuItem<Map<String, dynamic>>(
  //                               value: material,
  //                               child: Text(
  //                                 material['feed_name'],
  //                                 style: headingText3,
  //                               ),
  //                             );
  //                           }).toList(),
  //                         ),
  //                       );
  //                     }),
  //                   ),
  //                 ),
  //     ),
  //     const SizedBox(
  //       height: 12,
  //     ),
  //     TextFieldWidget(
  //       label: 'Jumlah',
  //       controller: state.amount,
  //       isLong: false,
  //       numberOutput: true,
  //       hint: 'Ex: 1.5',
  //       suffixSection: Text(
  //         'kg',
  //         style: headingText3,
  //       ),
  //     ),
  //     const SizedBox(
  //       height: 12,
  //     ),
  //     state.isProbLoading.value
  //         ? Padding(
  //       padding: const EdgeInsets.only(top: 24.0),
  //       child: Center(
  //         child: SizedBox(
  //           width: 30,
  //           height: 30,
  //           child: CircularProgressIndicator(
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //     )
  //         : probioticInput(),
  //     carbonTypeInput(),
  //     state.carbCheck.value
  //         ? state.isCarbLoading.value
  //         ? Padding(
  //       padding: const EdgeInsets.only(top: 24.0),
  //       child: Center(
  //         child: SizedBox(
  //           width: 30,
  //           height: 30,
  //           child: CircularProgressIndicator(
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //     )
  //         : carbonInput()
  //         : Container(),
  //     saltDosisInput(),
  //     const SizedBox(
  //       height: 16,
  //     ),
  //     state.listPakanName.isEmpty
  //         ? Container()
  //         : Obx(
  //             () => state.isLoadingNameDetail.value
  //                 ? Center(
  //                     child: SizedBox(
  //                     child: CircularProgressIndicator(color: Colors.white),
  //                     width: 50,
  //                     height: 50,
  //                   ))
  //                 : Column(
  //                     crossAxisAlignment: CrossAxisAlignment.stretch,
  //                     children: [
  //                       const SizedBox(
  //                         height: 16,
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           TextFieldWidget(
  //                             label: 'Min. Expired',
  //                             controller: state.minExp,
  //                             isLong: false,
  //                             numberOutput: true,
  //                             hint: 'Ex: 10',
  //                             isEdit: false,
  //                             suffixSection: Text(
  //                               'hari',
  //                               style: headingText3,
  //                             ),
  //                           ),
  //                           TextFieldWidget(
  //                             label: 'Max. Expired',
  //                             controller: state.maxExp,
  //                             isLong: false,
  //                             numberOutput: true,
  //                             hint: 'Ex: 10',
  //                             isEdit: false,
  //                             suffixSection: Text(
  //                               'hari',
  //                               style: headingText3,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //           ),
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
  //         if (state.listPakanName.isEmpty ||
  //             state.price.text == '' ||
  //             state.amount.text == '') {
  //           Flushbar(
  //             message: "Gagal, Form tidak sesuai",
  //             duration: Duration(seconds: 3),
  //             leftBarIndicatorColor: Colors.red[400],
  //           ).show(context);
  //         } else {
  //           await state.postData(() async {
  //             Flushbar(
  //               message: "Pakan berhasil ditambahkan",
  //               duration: Duration(seconds: 2),
  //               leftBarIndicatorColor: Colors.green,
  //             ).show(context);
  //             await state.getAllData(state.feedCategory.value, () {
  //               Navigator.pop(context);
  //               Navigator.pop(context);
  //             });
  //           });
  //         }
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

  addNameBottomSheet() {
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
          'Tambah Merk Pakan',
          style: headingText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 54,
        ),
        TextFieldWidget(
          label: 'Kategori Pakan',
          controller: state.category,
          isEdit: false,
        ),

        const SizedBox(
          height: 16,
        ),
        TextFieldWidget(
          label: 'Merk Pakan',
          controller: state.name,
          hint: 'Ex: Pelet',
          isLong: true,
        ),

        const SizedBox(
          height: 16,
        ),
        TextFieldWidget(
          label: 'Produser Pakan',
          controller: state.producer,
          hint: 'Ex: Sinta',
          isLong: true,
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFieldWidget(
                isEnableSwitch: true,
                switchOnChange: (v) {
                  state.minSwitchValue.value = true;
                },
                switchValue: true,
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
        const SizedBox(
          height: 16,
        ),
        Obx(
          () => TextFieldWidget(
            isEnableSwitch: true,
            switchOnChange: (v) {
              state.descSwitchValue.value = v;
            },
            switchValue: state.descSwitchValue.value,
            label: 'Deskripsi Pakan',
            controller: state.desc,
            hint: 'Ex: Bahan pakan ikan',
            isMoreText: true,
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
                  state.proteinSwitchValue.value = v;
                },
                switchValue: state.proteinSwitchValue.value,
                label: 'Protein',
                controller: state.protein,
                isLong: false,
                numberOutput: true,
                hint: 'Ex: 10',
                suffixSection: const Icon(
                  Icons.percent,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              TextFieldWidget(
                isEnableSwitch: true,
                switchOnChange: (v) {
                  state.carbSwitchValue.value = v;
                  if (state.feedCategory.value == 'Industri') {
                    state.carbo.text = '50';
                  }
                },
                switchValue: state.carbSwitchValue.value,
                label: 'Karbon',
                controller: state.carbo,
                isLong: false,
                numberOutput: true,
                hint: 'Ex: 10',
                isEdit: state.feedCategory.value == 'Industri' ? false : true,
                suffixSection: const Icon(
                  Icons.percent,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
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
                state.producer.text == '' ||
                state.minExp.text == '') {
              Flushbar(
                message: "Gagal, Form tidak sesuai",
                duration: Duration(seconds: 3),
                leftBarIndicatorColor: Colors.red[400],
              ).show(context);
            } else {
              await state.postPakanNameData(
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
                : Icon(
                    Icons.add,
                  ),
          ),
        ),
      ],
    );
  }

}

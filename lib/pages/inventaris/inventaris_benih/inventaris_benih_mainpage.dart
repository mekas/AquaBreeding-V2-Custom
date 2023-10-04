import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/inventaris/inventaris_benih/add_seed.dart';
import 'package:fish/pages/inventaris/inventaris_benih/detail_inventaris_benih_page.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_pages/kelas_benih_page.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_pages/kelas_pembesaran_page.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class InventarisBenihMainpage extends StatefulWidget {
  const InventarisBenihMainpage({super.key});

  @override
  State<InventarisBenihMainpage> createState() =>
      _InventarisBenihMainpageState();
}

class _InventarisBenihMainpageState extends State<InventarisBenihMainpage> {
  final InventarisBenihState state = Get.put(InventarisBenihState());
  var isMenuTapped = false.obs;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id', null);
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor1,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor2,
          elevation: 0,
          title: Text(
            'Benih',
            style: headingText2,
          ),
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
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return DetailInventarisBenihPage();
                })));
              },
              icon: const Icon(
                Icons.history,
              ),
            )
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'Kelas Benih',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Kelas Pembesaran',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            KelasBenihPage(isMenuTapped: isMenuTapped.value,),
            KelasPembesaranPage(isMenuTapped: isMenuTapped.value,),
          ],
        ),
        endDrawer: DrawerInvetarisList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green.shade600,
          onPressed: () {
            state.fishAmount.clear();
            state.fishWeight.clear();
            state.fishPrice.clear();
            state.fishPriceTotal.clear();
            // getBottomSheet();
            Get.to(() => AddSeed());
          },
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ),
    );
  }

  getBottomSheet() {
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
          'Catat Benih',
          style: headingText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 54,
        ),
        Text(
          'Kategori',
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
                      state.seedCategory.value = value!;
                    });
                    state.fishCategory.value = 'Lele';

                    state.resetVariables();
                  }),
                  value: state.seedCategory.value,
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
        Text(
          'Jenis Ikan',
          style: headingText2,
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => state.seedCategory.value == 'Benih'
              ? Container(
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
                              state.fishCategory.value = value!;
                            });
                          }),
                          value: state.fishCategory.value,
                          dropdownColor: inputColor,
                          items: state.dropdownList22.map(
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
        ),
        // const SizedBox(
        //   height: 16,
        // ),
        // TextFieldWidget(
        //   label: 'Nama',
        //   controller: state.fishName,
        //   hint: 'Ex: Ikan01',
        // ),
        const SizedBox(
          height: 16,
        ),
        Obx(
          () => state.seedCategory.value == 'Benih'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                        TextFieldWidget(
                          // isEnableSwitch: true,
                          // switchValue: state.switchValue.value,
                          // switchOnChange: (v) {
                          //   setState(() {
                          //     state.switchValue.value = v;
                          //   });
                          //   inspect(state.switchValue.value);
                          // },
                          label: 'Jumlah',
                          controller: state.fishAmount,
                          isLong: false,
                          hint: 'Ex: 1000',
                          numberOutput: true,
                          suffixSection: Text(
                            'ekor',
                            style: headingText3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldWidget(
                          label: 'Berat / ekor',
                          controller: state.fishWeight,
                          isLong: false,
                          hint: 'Ex: 100',
                          numberOutput: true,
                          suffixSection: Text(
                            'kg',
                            style: headingText3,
                          ),
                        ),
                        TextFieldWidget(
                          label: 'Jumlah',
                          controller: state.fishAmount,
                          hint: 'Ex: 1000',
                          isLong: false,
                          numberOutput: true,
                          suffixSection: Text(
                            'ekor',
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
              label: 'Harga Beli Satuan',
              controller: state.fishPrice,
              hint: 'Ex: 10000',
              isLong: false,
              numberOutput: true,
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
        ElevatedButton(
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
              await state.postSeedData(
                () => {
                  state.getAllSeedData(state.pageIdentifier.value),
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

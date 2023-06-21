import 'dart:developer';

import 'package:fish/pages/inventaris/inventaris_benih/detail_inventaris_benih_page.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_pages/kelas_benih_page.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_pages/kelas_pembesaran_page.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class InventarisBenihMainpage extends StatefulWidget {
  const InventarisBenihMainpage({super.key});

  @override
  State<InventarisBenihMainpage> createState() =>
      _InventarisBenihMainpageState();
}

class _InventarisBenihMainpageState extends State<InventarisBenihMainpage> {
  final InventarisBenihState state = Get.put(InventarisBenihState());
  final TextEditingController controller = TextEditingController();

  String dropdownValue = 'Benih';
  String dropdownValue2 = 'Lele';
  String dropdownValue3 = '1 - 2 cm';

  static var dropdownList = ['Benih', 'Pembesaran'];
  static var dropdownList2 = [
    'Lele',
    'Nila Merah',
    'Nila Hitam',
    'Patin',
    'Mas'
  ];
  static var dropdownList3 = [
    '1 - 2 cm',
    '2 - 3 cm',
    '3 - 4 cm',
    '4 - 5 cm',
    '5 - 6 cm',
    '6 - 7 cm',
    '7 - 8 cm',
    '8 - 9 cm',
    '9 - 10 cm',
    '10 - 11 cm',
    '11 - 12 cm',
    '12 - 13 cm',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor1,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor1,
          elevation: 0,
          title: Text(
            'Benih',
            style: headingText2,
          ),
          actions: [
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
          bottom: TabBar(
            indicator: BoxDecoration(
              color: primaryColor,
            ),
            tabs: const [
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
            KelasBenihPage(),
            KelasPembesaranPage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green.shade600,
          onPressed: () {
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
                              dropdownValue = value!;
                            });
                            state.seedCategory.value = value!;
                            state.resetVariables();
                          }),
                          value: dropdownValue,
                          dropdownColor: inputColor,
                          items: dropdownList.map(
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
                              dropdownValue2 = value!;
                            });
                            state.fishCategory.value = value!;
                          }),
                          value: dropdownValue2,
                          dropdownColor: inputColor,
                          items: dropdownList2.map(
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
                TextFieldWidget(
                  label: 'Nama',
                  controller: state.fishName,
                  hint: 'Ex: Ikan01',
                ),
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
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
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
                                                  dropdownValue3 = value!;
                                                });
                                                state.sortSize.value = value!;
                                              }),
                                              value: dropdownValue3,
                                              dropdownColor: inputColor,
                                              items: dropdownList3.map(
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
                                  label: 'Berat',
                                  controller: state.fishWeight,
                                  isLong: false,
                                  hint: 'Ex: 100',
                                  numberOutput: true,
                                  suffixSection: Text(
                                    'gram',
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
                TextFieldWidget(
                  label: 'Harga Beli',
                  controller: state.fishPrice,
                  hint: 'Ex: 10000',
                  isLong: true,
                  numberOutput: true,
                  prefixSection: Text(
                    'Rp',
                    style: headingText3,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Gambar',
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
                    'https://www.hepper.com/wp-content/uploads/2022/09/red-male-betta-fish-in-aquarium_Grigorii-Pisotscki-Shutterstock.jpg',
                    fit: BoxFit.cover,
                  ),
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
                    await state.postSeedData(
                      () => {
                        state.getAllSeedData('Benih'),
                        state.resetVariables(),
                        Navigator.pop(context),
                      },
                    );
                  },
                  child: Obx(
                    () => state.isLoadingPost.value
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          )
                        : Icon(
                            Icons.add,
                          ),
                  ),
                ),
              ],
            );
          },
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ),
    );
  }
}

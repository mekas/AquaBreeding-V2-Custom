import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/detail_inventaris_bahan_budidaya/detail_inventaris_bahan_budidaya_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_pages/bahan_budidaya_obat.dart';
import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_pages/bahan_budidaya_perawatan_air.dart';
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

  String dropdownValue = 'Perawatan Air';
  String dropdownValue2 = 'kg';

  static var dropdownList = [
    'Perawatan Air',
    'Obat-obatan',
  ];

  static var dropdownList2 = ['kg', 'ltr'];

  TextEditingController testControl = TextEditingController();
  TextEditingController testControl2 = TextEditingController();
  TextEditingController testControl3 = TextEditingController();
  TextEditingController testControl4 = TextEditingController();
  TextEditingController testControl5 = TextEditingController();
  TextEditingController testControl6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor1,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return DetailInventarisBahanBudidayaMainpage(
                    pageIdentifier: state.pageDetail.value,
                  );
                })));
              },
              icon: const Icon(Icons.history),
            ),
          ],
          title: const Text('Suplemen'),
          bottom: TabBar(
            indicator: BoxDecoration(
              color: primaryColor,
            ),
            tabs: const [
              Tab(
                child: Text(
                  'Perawatan Air',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Obat-obatan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BahanBudidayaPerawatanAirPage(),
            BahanBudidayaObatPage(),
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
                  'Catat Bahan',
                  style: headingText1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 54,
                ),
                TextFieldWidget(
                  label: 'Nama / Merek Bahan',
                  controller: testControl,
                  hint: 'Ex: Tepung',
                ),
                const SizedBox(
                  height: 16,
                ),
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
                            setState(() {
                              dropdownValue = value!;
                            });
                            state.selectedDropdownValue.value = value!;
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
                SizedBox(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFieldWidget(
                                label: 'Jumlah',
                                controller: testControl4,
                                isLong: false,
                                hint: 'Ex: 100',
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
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
                                            dropdownValue2 = value!;
                                          });
                                          state.selectedDropdownValue2.value =
                                              value!;
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
                            ],
                          ),
                          TextFieldWidget(
                            label: 'Periode Kadaluarsa',
                            controller: testControl5,
                            isLong: false,
                            hint: 'Ex: 100',
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
                    ],
                  ),
                ),
                TextFieldWidget(
                  label: 'Harga Beli',
                  controller: testControl6,
                  hint: 'Ex: 10000',
                  prefixSection: Text(
                    'Rp',
                    style: headingText3,
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
                  onPressed: () {},
                  child: const Icon(Icons.add),
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

import 'package:fish/pages/inventaris/inventaris_pakan/detail_inventaris_pakan/detail_inventaris_pakan_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_pages/pakan_alami_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_pages/pakan_campuran_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_pages/pakan_industri_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/dialog_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventarisPakanMainpage extends StatefulWidget {
  const InventarisPakanMainpage({super.key});

  @override
  State<InventarisPakanMainpage> createState() =>
      _InventarisPakanMainpageState();
}

class _InventarisPakanMainpageState extends State<InventarisPakanMainpage> {
  InventarisPakanState state = Get.put(InventarisPakanState());

  String dropdownValue = 'Pakan Industri';

  static var dropdownList = [
    'Pakan Industri',
    'Pakan Alami',
    'Pakan Campuran',
  ];

  TextEditingController testControl = TextEditingController();
  TextEditingController testControl2 = TextEditingController();
  TextEditingController testControl3 = TextEditingController();
  TextEditingController testControl4 = TextEditingController();
  TextEditingController testControl5 = TextEditingController();
  TextEditingController testControl6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor1,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return DetailInventarisPakanMainpage(
                    pageIdentifier: state.pageDetail.value,
                  );
                })));
              },
              icon: const Icon(Icons.history),
            ),
          ],
          title: const Text('Pakan'),
          bottom: TabBar(
            indicator: BoxDecoration(
              color: primaryColor,
            ),
            tabs: const [
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       pageTitleValue = 'Industri';
              //     });
              //     print(pageTitleValue);
              //   },
              //   child: Tab(
              //     child: Text(
              //       'Industri',
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              Tab(
                child: Text(
                  'Industri',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Alami',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Campuran',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PakanIndustriPage(),
            PakanAlamiPage(),
            PakanCampuranPage(),
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
                  'Catat Pakan',
                  style: headingText1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 54,
                ),
                Text(
                  'Kategori Pakan',
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
                TextFieldWidget(
                  label: 'Nama / Merek Pakan',
                  controller: testControl,
                  hint: 'Ex: Pelet/Tumbuhan Air/Tepung',
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldWidget(
                      label: 'Protein',
                      controller: testControl2,
                      isLong: false,
                      hint: 'Ex: 10',
                      suffixSection: const Icon(
                        Icons.percent,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    TextFieldWidget(
                      label: 'Karbon',
                      controller: testControl3,
                      isLong: false,
                      hint: 'Ex: 10',
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
                Obx(
                  () => state.selectedDropdownValue.value == 'Pakan Alami'
                      ? Container()
                      : SizedBox(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextFieldWidget(
                                    label: 'Jumlah',
                                    controller: testControl4,
                                    isLong: false,
                                    hint: 'Ex: 100',
                                    suffixSection: Text(
                                      'gram',
                                      style: headingText3,
                                    ),
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

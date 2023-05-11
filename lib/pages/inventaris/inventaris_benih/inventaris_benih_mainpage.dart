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

  String dropdownValue = 'Kelas Benih';
  String dropdownValue2 = 'Ikan Lele';
  String dropdownValue3 = '1 - 2 cm';

  static var dropdownList = ['Kelas Benih', 'Kelas Pembesaran'];
  static var dropdownList2 = ['Ikan Lele', 'Ikan Nila'];
  static var dropdownList3 = ['1 - 2 cm', '3 - 4 cm', '5 - 6 cm'];

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
                  return DetailInventarisBenihPage(
                    pageIdentifier: state.selectedPage.value,
                  );
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
                  'Kategori Benih',
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
                            state.selectedDropdown.value = value!;
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
                            state.selectedDropdown2.value = value!;
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
                Obx(
                  () => state.selectedDropdown.value == 'Kelas Benih'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Satuan Sortir',
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
                                          dropdownValue3 = value!;
                                        });
                                        state.selectedDropdown3.value = value!;
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
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextFieldWidget(
                                  label: 'Jumlah',
                                  controller: controller,
                                  isLong: false,
                                  hint: 'Ex: 10',
                                  suffixSection: Text(
                                    'ekor',
                                    style: headingText3,
                                  ),
                                ),
                                TextFieldWidget(
                                  label: 'Berat',
                                  controller: controller,
                                  isLong: false,
                                  hint: 'Ex: 10',
                                  suffixSection: Text(
                                    'gram',
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
                                  label: 'Panjang',
                                  controller: controller,
                                  isLong: false,
                                  hint: 'Ex: 10',
                                  prefixSection: Text(
                                    'P :',
                                    style: headingText3,
                                  ),
                                  suffixSection: Text(
                                    'cm',
                                    style: headingText3,
                                  ),
                                ),
                                TextFieldWidget(
                                  label: 'Jumlah',
                                  controller: controller,
                                  isLong: false,
                                  hint: 'Ex: 10',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextFieldWidget(
                                  label: 'Lebar',
                                  controller: controller,
                                  isLong: false,
                                  hint: 'Ex: 10',
                                  prefixSection: Text(
                                    'L :',
                                    style: headingText3,
                                  ),
                                  suffixSection: Text(
                                    'cm',
                                    style: headingText3,
                                  ),
                                ),
                                TextFieldWidget(
                                  label: 'Berat',
                                  controller: controller,
                                  isLong: false,
                                  hint: 'Ex: 10',
                                  suffixSection: Text(
                                    'gram',
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
                  controller: controller,
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

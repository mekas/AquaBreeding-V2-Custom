import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/pakan_alami_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/pakan_campuran_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/pakan_industri_page.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/dialog_widget.dart';
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
              onPressed: () {},
              icon: const Icon(Icons.history),
            ),
          ],
          title: const Text('Pakan'),
          bottom: TabBar(
            indicator: BoxDecoration(
              color: primaryColor,
            ),
            tabs: const [
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
            DialogWidget.open(
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
                const Text('Catat Pakan'),
                const SizedBox(
                  height: 20,
                ),
                const Text('Kategori Pakan'),
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
                            print(state.selectedDropdownValue.value);
                          }),
                          value: dropdownValue,
                          dropdownColor: inputColor,
                          items: dropdownList.map(
                            (String val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Text(
                                  val,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      );
                    }),
                  ),
                ),
                Obx(
                  () => state.selectedDropdownValue.value == 'Pakan Alami'
                      ? Container()
                      : Container(
                          width: double.infinity,
                          color: Colors.red,
                          child: Text('TEST VALUE'),
                        ),
                )
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

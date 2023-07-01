import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/detail_inventaris_pakan/detail_inventaris_pakan_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_pages/pakan_alami_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_pages/pakan_campuran_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_pages/pakan_industri_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
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
                  return DetailInventarisPakanMainpage();
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
            state.resetVariables();
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
                              state.feedCategory.value = value!;
                            });
                            state.feedCategory.value = value!;
                            state.resetVariables();
                          }),
                          value: state.feedCategory.value,
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
                TextFieldWidget(
                  label: 'Nama / Merek Pakan',
                  controller: state.name,
                  hint: 'Ex: Pelet/Tumbuhan Air/Tepung',
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFieldWidget(
                  label: 'Produser Pakan',
                  controller: state.producer,
                  hint: 'Ex: Sinta',
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => TextFieldWidget(
                    isEnableSwitch: true,
                    switchValue: state.switchValue.value,
                    switchOnChange: (v) {
                      setState(() {
                        state.switchValue.value = v;
                      });
                    },
                    label: 'Deskripsi Pakan',
                    controller: state.desc,
                    hint: 'Ex: Bahan pakan ikan',
                    isMoreText: true,
                  ),
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
                      suffixSection: const Icon(
                        Icons.percent,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    TextFieldWidget(
                      label: 'Karbo',
                      controller: state.carbo,
                      isLong: false,
                      numberOutput: true,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldWidget(
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
                      hint: 'Ex: 10',
                      suffixSection: Text(
                        'gram',
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
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Gambar (Struk)',
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
                    'https://1.bp.blogspot.com/-9tt1qS0wO-8/X8uLEZd9HGI/AAAAAAAAAnQ/4uGdwluBvYg-cwgjFAf85P_MzITSUos1ACLcBGAsYHQ/s1078/Pakan.png',
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
                    if (state.name.text == '' ||
                        state.price.text == '' ||
                        state.desc.text == '' ||
                        state.amount.text == '' ||
                        state.producer.text == '' ||
                        state.protein.text == '' ||
                        state.carbo.text == '' ||
                        state.minExp.text == '' ||
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

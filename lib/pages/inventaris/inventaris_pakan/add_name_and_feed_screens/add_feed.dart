import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/pakan_custom_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../theme.dart';
import '../../../../widgets/new_Menu_widget.dart';
import '../../../../widgets/text_field_widget.dart';
import '../inventaris_pakan_state.dart';

class AddFeed extends StatefulWidget {
  const AddFeed({super.key});

  @override
  State<AddFeed> createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
  InventarisPakanState state = Get.put(InventarisPakanState());
  final PakanCustomController controller =
  Get.put(PakanCustomController());
  var isMenuTapped = false.obs;
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state.resetFeedVariables();
    state.resetNameVariables();
    state.setSheetFeedVariableEdit(false);
    state.setSheetNameVariableEdit(false);
    initSharedPrefs();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (prefs.getString("page") == "Alami"){
        print("page: true alami");
        state.getAllData('alami', () {});
        state.getPakanNameData('alami', () {});
      } else {
        print("page: true industri");
        state.getAllData('industri', () {});
        state.getPakanNameData('industri', () {});
      }
    });
  }

  @override
  void dispose() {
    controller.postDataLog(controller.fitur);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (state.isLoadingPage.value == false) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor2,
            title: const Text("Catat Pakan"),
            actions: [
              IconButton(
                onPressed: () {
                  // scaffoldKey.currentState?.openEndDrawer();
                  setState(() {
                    isMenuTapped.value = !isMenuTapped.value;
                  });
                },
                icon: Icon(Icons.card_travel_rounded),
              )
            ],
          ),
          backgroundColor: backgroundColor1,
          body: Container(
            margin: EdgeInsets.only(
                top: defaultSpace, right: defaultMargin, left: defaultMargin),
            child: ListView(
              children: [
                if (isMenuTapped.value)
                  Column(
                    children: [
                      SizedBox(height: 12,),
                      newMenu(),
                      SizedBox(height: 12,),
                    ],
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
                  height: 12,
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
                            height: 5,
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
                const SizedBox(
                  height: 36,
                ),
              ],
            ),
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: secondaryColor,
          ),
        );
      }
    });
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    inspect(prefs);
  }
}

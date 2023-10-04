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

class AddFeedName extends StatefulWidget {
  const AddFeedName({super.key});

  @override
  State<AddFeedName> createState() => _AddFeedNameState();
}

class _AddFeedNameState extends State<AddFeedName> {
  InventarisPakanState state = Get.put(InventarisPakanState());
  final PakanCustomController controller =
  Get.put(PakanCustomController());
  var isMenuTapped = false.obs;
  late SharedPreferences prefs;
  @override
  void initState(){
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
            title: const Text("Tambah Merk Pakan"),
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
                const SizedBox(
                  height: 12,
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

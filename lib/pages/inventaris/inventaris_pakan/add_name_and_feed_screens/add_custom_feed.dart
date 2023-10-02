import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_pages/new_pakan_campuran_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/pakan_custom_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme.dart';
import '../../../../widgets/new_Menu_widget.dart';
import '../../../../widgets/text_field_widget.dart';
import '../inventaris_pakan_mainpage.dart';
import '../inventaris_pakan_state.dart';

class AddCustomFeed extends StatefulWidget {
  const AddCustomFeed({super.key});

  @override
  State<AddCustomFeed> createState() => _AddCustomFeedState();
}

class _AddCustomFeedState extends State<AddCustomFeed> {
  InventarisPakanState state = Get.put(InventarisPakanState());
  final PakanCustomController controller =
  Get.put(PakanCustomController());
  var isMenuTapped = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state.resetFeedVariables();
    state.resetNameVariables();
    state.pageIdentifier.value = 'custom';
    state.feedCategory.value = 'Custom';
    state.category.text = 'Custom';
    state.isProbSelected.value = false;
    state.isCarbSelected.value = false;
    state.carbCheck.value = false;
    state.isCustomInput2.value = false;
    state.isCustomInput3.value = false;
    state.isCustomInput4.value = false;
    state.isCustomInput5.value = false;
    controller.feedDosisController.text = '0';
    controller.probioticController.text = '0';
    controller.carbonController.text = '0';
    state.finalAmount.text = '0.0';
    state.finalObatAmount.text = '0.0';
    state.finalProbiotikAmount.text = '0.0';
    state.finalCarbonAmount.text = '0.0';
    state.finalCarbon2Amount.text = '0.0';
    state.finalCarbon3Amount.text = '0.0';
    state.finalCarbon4Amount.text = '0.0';
    state.finalCarbon5Amount.text = '0.0';
    state.obatPrice.text = '0';
    state.carbonPrice.text = '0';
    state.probiotikPrice.text = '0';
    state.obatPrice.text = '0';
    state.selectedObat.clear();
    state.selectedCultureProbiotik.clear();
    state.selectedCarbon.clear();
    state.selectedCarbon2.clear();
    state.selectedCarbon3.clear();
    state.selectedCarbon4.clear();
    state.selectedCarbon5.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getAllData('industri', () {
        if (state.selectedFeedList.isNotEmpty) {
          state.getDataByID(state.selectedFeedName.value['id'], () {
            controller.calculatedStock.value =
                double.parse(state.amount.text);
          });
        }
      });
      state.getPakanNameData('industri', () {});
      state.getAllCustomData(() {});
      state.getAllSuplementData('Obat', () {
        if (state.listObat.isNotEmpty){
          state.getObatDetail(
            state.selectedObat.value['id'],
                () => null,
          );
        }
      });
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
          print("carb id: ${state.carbID.value}");
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
  void dispose() {
    controller.postDataLog(controller.fitur);
    controller.carbonController.clear();
    controller.saltController.clear();
    controller.probioticController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (state.isLoadingPage.value == false) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor2,
            title: const Text("Catat Pakan Custom"),
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
                  'List Pakan Industri',
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
                              print("value: $value");
                              state.selectedFeedName.value = value!;
                              state.setStatusDetailFeed.value = true;
                              state.customPakanName.text += value['feed_name'];
                              state.fishFeedId.value = value['feed_id'];
                              print("pakan name: ${state.customPakanName.text}");
                              print("id = ${value['feed_id']}");

                              await state.getDataByID(value['id'], () {
                                print("price = ${state.price.text}");

                                controller.calculatedStock.value =
                                    double.parse(state.amount.text);
                              });
                            },
                            value: state.selectedFeedName.value,
                            dropdownColor: inputColor,
                            items: state.selectedFeedList
                                .map<DropdownMenuItem<Map<String, dynamic>>>(
                                    (val) {
                                  return DropdownMenuItem<Map<String, dynamic>>(
                                    value: val,
                                    child: Text(
                                      val['feed_name'],
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
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   StatefulBuilder(
                     builder: (context, setState) {
                       return  TextFieldWidget(
                         label: 'Dosis Pakan',
                         controller: controller.feedDosisController,
                         isLong: false,
                         numberOutput: true,
                         hint: 'Ex: 1.5',
                         suffixSection: Text(
                           'kg',
                           style: headingText3,
                         ),
                         onChange: (v) {
                           if (double.parse(state.amount.text) -
                               double.parse(controller
                                   .feedDosisController.text ==
                                   ''
                                   ? '0.0'
                                   : controller.feedDosisController.text) <
                               0) {
                             Flushbar(
                               message:
                               "Tidak boleh kurang dari stok tersedia",
                               duration: Duration(seconds: 2),
                               leftBarIndicatorColor: Colors.red,
                             ).show(context);
                           }
                           setState(() {
                             controller.calculatedStock.value =
                                 double.parse(state.amount.text) -
                                     double.parse(
                                         controller.feedDosisController.text ==
                                             ''
                                             ? '0.0'
                                             : controller
                                             .feedDosisController.text);
                             state.finalAmount.text = controller.feedDosisController.text;
                           });
                         },
                       );
                     },
                   ),
                   const SizedBox(
                     height: 8,
                   ),
                   Text(
                     'Sisa Stok : ${controller.calculatedStock.value.toStringAsFixed(2)}',
                     style: headingText3.copyWith(
                       color: Colors.grey,
                       fontSize: 12,
                     ),
                   ),
                 ],
               ),
                const SizedBox(
                  height: 12,
                ),
                customInput(),
                const SizedBox(
                  height: 36,
                ),
                if(state.isCustomInput2.value)
                  customInput2(),
                  const SizedBox(
                  height: 36,
                  ),
                if(state.isCustomInput3.value)
                  customInput3(),
                const SizedBox(
                  height: 36,
                ),
                if(state.isCustomInput4.value)
                  customInput4(),
                const SizedBox(
                  height: 36,
                ),
                if(state.isCustomInput5.value)
                  customInput5(),
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
                    print("pakan name: ${state.listPakanName}");
                    print("price: ${state.price.text}");
                    print("amount: ${state.amount.text}");
                    print("pakan name: ${state.customPakanName.text}");
                    if (state.listPakanName.isEmpty ||
                        state.price.text == '' ||
                        state.amount.text == '') {
                      Flushbar(
                        message: "Gagal, Form tidak sesuai",
                        duration: Duration(seconds: 3),
                        leftBarIndicatorColor: Colors.red[400],
                      ).show(context);
                    } else {
                      await state.postDataCustom(() async {
                        Flushbar(
                          message: "Pakan berhasil ditambahkan",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.green,
                        ).show(context);
                        state.selectedCultureProbiotik.clear();
                        state.selectedObat.clear();
                        state.selectedCarbon.clear();
                        state.customPakanName.clear();
                        // await state.getAllData("Custom", () {});
                        // WidgetsBinding.instance.addPostFrameCallback((_) {
                        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => InventarisPakanMainpage()));
                        // });
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
                        : Text("Submit")
                  ),
                ),
                SizedBox(height: 12,)
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




  Widget customInput() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pilih Kategori Bahan Budidaya',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: inputColor,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: ((String? value) async {
                      setState(() {
                        state.selectedCategory.value = value!;
                      });
                    }),
                    value: state.selectedCategory.value,
                    dropdownColor: inputColor,
                    items: state.kategoriBahanBudidaya.map(
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
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (state.selectedCategory.value == "Obat")
                obatInput(),
              if (state.selectedCategory.value == "Probiotik")
                probioticInput(),
              if (state.selectedCategory.value == "Feed Additive")
                carbonInput(),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: addButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    state.isCustomInput2.value = true;
                  });
                },
                child: Icon(
                    Icons.add,
                  ),
                ),
              SizedBox(
                height: 12,
              )
            ],
          )
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget customInput2() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pilih Kategori Bahan Budidaya',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: inputColor,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: ((String? value) async {
                      setState(() {
                        state.selectedCategory2.value = value!;
                      });
                    }),
                    value: state.selectedCategory2.value,
                    dropdownColor: inputColor,
                    items: state.kategoriBahanBudidaya.map(
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
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (state.selectedCategory2.value == "Obat")
                obatInput2(),
              if (state.selectedCategory2.value == "Probiotik")
                probioticInput2(),
              if (state.selectedCategory2.value == "Feed Additive")
                carbonInput2(),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: addButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    state.isCustomInput3.value = true;
                  });
                },
                child:Icon(
                    Icons.add,
                  ),
                ),
              SizedBox(
                height: 12,
              )
            ],
          )
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget customInput3() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pilih Kategori Bahan Budidaya',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: inputColor,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: ((String? value) async {
                      setState(() {
                        state.selectedCategory3.value = value!;
                      });
                    }),
                    value: state.selectedCategory3.value,
                    dropdownColor: inputColor,
                    items: state.kategoriBahanBudidaya.map(
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
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (state.selectedCategory3.value == "Obat")
                obatInput3(),
              if (state.selectedCategory3.value == "Probiotik")
                probioticInput3(),
              if (state.selectedCategory3.value == "Feed Additive")
                carbonInput3(),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: addButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    state.isCustomInput4.value = true;
                  });
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
              SizedBox(
                height: 12,
              )
            ],
          )
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget customInput4() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pilih Kategori Bahan Budidaya',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: inputColor,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: ((String? value) async {
                      setState(() {
                        state.selectedCategory4.value = value!;
                      });
                    }),
                    value: state.selectedCategory4.value,
                    dropdownColor: inputColor,
                    items: state.kategoriBahanBudidaya.map(
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
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (state.selectedCategory4.value == "Obat")
                obatInput4(),
              if (state.selectedCategory4.value == "Probiotik")
                probioticInput4(),
              if (state.selectedCategory4.value == "Feed Additive")
                carbonInput4(),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: addButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    state.isCustomInput5.value = true;
                  });
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
              SizedBox(
                height: 12,
              )
            ],
          )
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget customInput5() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pilih Kategori Bahan Budidaya',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: inputColor,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: ((String? value) async {
                      setState(() {
                        state.selectedCategory5.value = value!;
                      });
                    }),
                    value: state.selectedCategory5.value,
                    dropdownColor: inputColor,
                    items: state.kategoriBahanBudidaya.map(
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
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (state.selectedCategory5.value == "Obat")
                obatInput5(),
              if (state.selectedCategory5.value == "Probiotik")
                probioticInput5(),
              if (state.selectedCategory5.value == "Feed Additive")
                carbonInput5(),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: addButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    state.isCustomInput6.value = true;
                  });
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
              SizedBox(
                height: 12,
              )
            ],
          )
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget customInput6() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pilih Kategori Bahan Budidaya',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: inputColor,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: ((String? value) async {
                      setState(() {
                        state.selectedCategory.value = value!;
                      });
                    }),
                    value: state.selectedCategory.value,
                    dropdownColor: inputColor,
                    items: state.kategoriBahanBudidaya.map(
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
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (state.selectedCategory.value == "Obat")
                obatInput(),
              if (state.selectedCategory.value == "Probiotik")
                probioticInput(),
              if (state.selectedCategory.value == "Feed Additive")
                carbonInput(),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: addButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    state.isCustomInput7.value = true;
                  });
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
              SizedBox(
                height: 12,
              )
            ],
          )
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget customInput7() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pilih Kategori Bahan Budidaya',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: inputColor,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: ((String? value) async {
                      setState(() {
                        state.selectedCategory.value = value!;
                      });
                    }),
                    value: state.selectedCategory.value,
                    dropdownColor: inputColor,
                    items: state.kategoriBahanBudidaya.map(
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
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (state.selectedCategory.value == "Obat")
                obatInput(),
              if (state.selectedCategory.value == "Probiotik")
                probioticInput(),
              if (state.selectedCategory.value == "Feed Additive")
                carbonInput(),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: addButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    state.isCustomInput8.value = true;
                  });
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
              SizedBox(
                height: 12,
              )
            ],
          )
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget customInput8() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pilih Kategori Bahan Budidaya',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: inputColor,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: ((String? value) async {
                      setState(() {
                        state.selectedCategory.value = value!;
                      });
                    }),
                    value: state.selectedCategory.value,
                    dropdownColor: inputColor,
                    items: state.kategoriBahanBudidaya.map(
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
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (state.selectedCategory.value == "Obat")
                obatInput(),
              if (state.selectedCategory.value == "Probiotik")
                probioticInput(),
              if (state.selectedCategory.value == "Feed Additive")
                carbonInput(),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: addButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    state.isCustomInput9.value = true;
                  });
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
              SizedBox(
                height: 12,
              )
            ],
          )
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget customInput9() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pilih Kategori Bahan Budidaya',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: inputColor,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: ((String? value) async {
                      setState(() {
                        state.selectedCategory.value = value!;
                      });
                    }),
                    value: state.selectedCategory.value,
                    dropdownColor: inputColor,
                    items: state.kategoriBahanBudidaya.map(
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
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (state.selectedCategory.value == "Obat")
                obatInput(),
              if (state.selectedCategory.value == "Probiotik")
                probioticInput(),
              if (state.selectedCategory.value == "Feed Additive")
                carbonInput(),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: addButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    state.isCustomInput10.value = true;
                  });
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
              SizedBox(
                height: 12,
              )
            ],
          )
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget customInput10() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pilih Kategori Bahan Budidaya',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: inputColor,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: ((String? value) async {
                      setState(() {
                        state.selectedCategory.value = value!;
                      });
                    }),
                    value: state.selectedCategory.value,
                    dropdownColor: inputColor,
                    items: state.kategoriBahanBudidaya.map(
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
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (state.selectedCategory.value == "Obat")
                obatInput(),
              if (state.selectedCategory.value == "Probiotik")
                probioticInput(),
              if (state.selectedCategory.value == "Feed Additive")
                carbonInput(),
              SizedBox(
                height: 12,
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
              SizedBox(
                height: 12,
              )
            ],
          )
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }



  Widget probioticInput() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Kultur Probiotik',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listCultureProbiotik.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedCultureProbiotik.value =
                            value!;
                          });
                          state.selectedCultureProbiotik.value =
                          value!;
                          state.probID.value = value['suplemen_id'];
                          print("prob id: ${state.probID.value}");
                          await state.getProbDetail(
                              value['id'], () => null);
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.probiotikPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.probiotikPrice.text = temp.toString();
                            print("probiotik price: ${state.probiotikPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedCultureProbiotik.value,
                        dropdownColor: inputColor,
                        items: state.listCultureProbiotik.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok Probiotik',
                    controller: controller.probioticController,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.probStock.value -
                          double.parse(
                              controller.probioticController.text ==
                                  ''
                                  ? '0'
                                  : controller
                                  .probioticController.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedProbStock.value = state
                            .probStock.value -
                            double.parse(controller
                                .probioticController.text ==
                                ''
                                ? '0'
                                : controller.probioticController.text);
                        state.finalProbiotikAmount.text = controller.probioticController.text;
                      });
                    },
                    suffixSection: Text(
                      state.probType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedProbStock.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
  Widget obatInput() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Obat',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listObat.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          print("obatinputwidget value: $value");
                          setState(() {
                            state.selectedObat.value =
                            value!;
                          });
                          state.selectedObat.value =
                          value!;
                          state.probID.value = value['suplemen_id'];
                          state.getObatDetail(
                            state.selectedObat.value['id'],
                                () => null,
                          );
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.obatPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.obatPrice.text = temp.toString();
                            print("obat price: ${state.carbonPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedObat.value,
                        dropdownColor: inputColor,
                        items: state.listObat.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok Obat',
                    controller: controller.obatController,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.obatStock.value -
                          double.parse(
                              controller.obatController.text ==
                                  ''
                                  ? '0'
                                  : controller
                                  .obatController.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedObatStock.value = state
                            .obatStock.value -
                            double.parse(controller
                                .obatController.text ==
                                ''
                                ? '0'
                                : controller.obatController.text);
                        state.finalObatAmount.text = controller.obatController.text;
                      });
                    },
                    suffixSection: Text(
                      state.obatType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedObatStock.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
  Widget carbonInput() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Feed Aditives',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listCarbon.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedCarbon.value = value!;
                          });
                          state.selectedCarbon.value = value!;
                          state.carbID.value = value['suplemen_id'];
                          print("carb id: ${state.carbID.value}");
                          await state.getCarbDetail(
                              value['id'], () => null);
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.carbonPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.carbonPrice.text = temp.toString();
                            print("carbon price: ${state.carbonPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedCarbon.value,
                        dropdownColor: inputColor,
                        items: state.listCarbon.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok',
                    controller: controller.carbonController,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.carbStock.value -
                          double.parse(
                              controller.carbonController.text == ''
                                  ? '0'
                                  : controller
                                  .carbonController.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedCarbonStock.value = state
                            .carbStock.value -
                            double.parse(
                                controller.carbonController.text == ''
                                    ? '0'
                                    : controller.carbonController.text);
                        state.finalCarbonAmount.text = controller.carbonController.text;
                      });
                    },
                    suffixSection: Text(
                      state.carbType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedCarbonStock.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget probioticInput2() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Kultur Probiotik',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listCultureProbiotik.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedCultureProbiotik.value =
                            value!;
                          });
                          state.selectedCultureProbiotik.value =
                          value!;
                          state.probID.value = value['suplemen_id'];
                          print("prob id: ${state.probID.value}");
                          await state.getProbDetail(
                              value['id'], () => null);
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.probiotikPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.probiotikPrice.text = temp.toString();
                            print("probiotik price: ${state.probiotikPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedCultureProbiotik.value,
                        dropdownColor: inputColor,
                        items: state.listCultureProbiotik.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok Probiotik',
                    controller: controller.probioticController2,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.probStock.value -
                          double.parse(
                              controller.probioticController2.text ==
                                  ''
                                  ? '0'
                                  : controller
                                  .probioticController2.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedProbStock.value = state
                            .probStock.value -
                            double.parse(controller
                                .probioticController2.text ==
                                ''
                                ? '0'
                                : controller.probioticController2.text);
                        state.finalProbiotikAmount.text = controller.probioticController2.text;
                      });
                    },
                    suffixSection: Text(
                      state.probType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedProbStock.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
  Widget obatInput2() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Obat',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listObat.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedObat.value =
                            value!;
                          });
                          state.selectedObat.value =
                          value!;
                          state.probID.value = value['suplemen_id'];
                          state.getObatDetail(
                            state.selectedObat.value['id'],
                                () => null,
                          );
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.obatPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.obatPrice.text = temp.toString();
                            print("obat price: ${state.carbonPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedObat.value,
                        dropdownColor: inputColor,
                        items: state.listObat.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok Obat',
                    controller: controller.obatController2,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.obatStock.value -
                          double.parse(
                              controller.obatController2.text ==
                                  ''
                                  ? '0'
                                  : controller
                                  .obatController2.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedObatStock.value = state
                            .obatStock.value -
                            double.parse(controller
                                .obatController2.text ==
                                ''
                                ? '0'
                                : controller.obatController2.text);
                        state.finalObatAmount.text = controller.obatController2.text;
                      });
                    },
                    suffixSection: Text(
                      state.obatType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedObatStock.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
  Widget carbonInput2() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Feed Aditives',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listCarbon.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedCarbon2.value = value!;
                          });
                          state.selectedCarbon2.value = value!;
                          state.carbID2.value = value['suplemen_id'];
                          print("carb id: ${state.carbID2.value}");
                          await state.getCarbDetail(
                              value['id'], () => null);
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.carbonPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.carbonPrice.text = temp.toString();
                            print("carbon price: ${state.carbonPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedCarbon2.value,
                        dropdownColor: inputColor,
                        items: state.listCarbon2.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok',
                    controller: controller.carbonController2,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.carbStock2.value -
                          double.parse(
                              controller.carbonController2.text == ''
                                  ? '0'
                                  : controller
                                  .carbonController2.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedCarbonStock2.value = state
                            .carbStock2.value -
                            double.parse(
                                controller.carbonController2.text == ''
                                    ? '0'
                                    : controller.carbonController2.text);
                        state.finalCarbon2Amount.text = controller.carbonController2.text;
                      });
                    },
                    suffixSection: Text(
                      state.carbType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedCarbonStock2.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget probioticInput3() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Kultur Probiotik',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listCultureProbiotik.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedCultureProbiotik.value =
                            value!;
                          });
                          state.selectedCultureProbiotik.value =
                          value!;
                          state.probID.value = value['suplemen_id'];
                          print("prob id: ${state.probID.value}");
                          await state.getProbDetail(
                              value['id'], () => null);
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.probiotikPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.probiotikPrice.text = temp.toString();
                            print("probiotik price: ${state.probiotikPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedCultureProbiotik.value,
                        dropdownColor: inputColor,
                        items: state.listCultureProbiotik.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok Probiotik',
                    controller: controller.probioticController3,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.probStock.value -
                          double.parse(
                              controller.probioticController3.text ==
                                  ''
                                  ? '0'
                                  : controller
                                  .probioticController3.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedProbStock.value = state
                            .probStock.value -
                            double.parse(controller
                                .probioticController3.text ==
                                ''
                                ? '0'
                                : controller.probioticController3.text);
                        state.finalProbiotikAmount.text = controller.probioticController3.text;
                      });
                    },
                    suffixSection: Text(
                      state.probType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedProbStock.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
  Widget obatInput3() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Obat',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listObat.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedObat.value =
                            value!;
                          });
                          state.selectedObat.value =
                          value!;
                          state.probID.value = value['suplemen_id'];
                          state.getObatDetail(
                            state.selectedObat.value['id'],
                                () => null,
                          );
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.obatPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.obatPrice.text = temp.toString();
                            print("obat price: ${state.carbonPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedObat.value,
                        dropdownColor: inputColor,
                        items: state.listObat.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok Obat',
                    controller: controller.obatController3,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.obatStock.value -
                          double.parse(
                              controller.obatController3.text ==
                                  ''
                                  ? '0'
                                  : controller
                                  .obatController3.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedObatStock.value = state
                            .obatStock.value -
                            double.parse(controller
                                .obatController3.text ==
                                ''
                                ? '0'
                                : controller.obatController3.text);
                        state.finalObatAmount.text = controller.obatController3.text;
                      });
                    },
                    suffixSection: Text(
                      state.obatType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedObatStock.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
  Widget carbonInput3() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Feed Aditives',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listCarbon.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedCarbon3.value = value!;
                          });
                          state.selectedCarbon3.value = value!;
                          state.carbID3.value = value['suplemen_id'];
                          print("carb id: ${state.carbID3.value}");
                          await state.getCarbDetail(
                              value['id'], () => null);
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.carbonPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.carbonPrice.text = temp.toString();
                            print("carbon price: ${state.carbonPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedCarbon3.value,
                        dropdownColor: inputColor,
                        items: state.listCarbon3.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok',
                    controller: controller.carbonController3,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.carbStock3.value -
                          double.parse(
                              controller.carbonController3.text == ''
                                  ? '0'
                                  : controller
                                  .carbonController3.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedCarbonStock3.value = state
                            .carbStock3.value -
                            double.parse(
                                controller.carbonController3.text == ''
                                    ? '0'
                                    : controller.carbonController3.text);
                        state.finalCarbon3Amount.text = controller.carbonController3.text;
                      });
                    },
                    suffixSection: Text(
                      state.carbType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedCarbonStock3.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }


  Widget probioticInput4() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Kultur Probiotik',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listCultureProbiotik.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedCultureProbiotik.value =
                            value!;
                          });
                          state.selectedCultureProbiotik.value =
                          value!;
                          state.probID.value = value['suplemen_id'];
                          print("prob id: ${state.probID.value}");
                          await state.getProbDetail(
                              value['id'], () => null);
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.probiotikPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.probiotikPrice.text = temp.toString();
                            print("probiotik price: ${state.probiotikPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedCultureProbiotik.value,
                        dropdownColor: inputColor,
                        items: state.listCultureProbiotik.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok Probiotik',
                    controller: controller.probioticController4,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.probStock.value -
                          double.parse(
                              controller.probioticController4.text ==
                                  ''
                                  ? '0'
                                  : controller
                                  .probioticController4.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedProbStock.value = state
                            .probStock.value -
                            double.parse(controller
                                .probioticController4.text ==
                                ''
                                ? '0'
                                : controller.probioticController4.text);
                        state.finalProbiotikAmount.text = controller.probioticController4.text;
                      });
                    },
                    suffixSection: Text(
                      state.probType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedProbStock.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
  Widget obatInput4() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Obat',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listObat.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedObat.value =
                            value!;
                          });
                          state.selectedObat.value =
                          value!;
                          state.probID.value = value['suplemen_id'];
                          state.getObatDetail(
                            state.selectedObat.value['id'],
                                () => null,
                          );
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.obatPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.obatPrice.text = temp.toString();
                            print("obat price: ${state.carbonPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedObat.value,
                        dropdownColor: inputColor,
                        items: state.listObat.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok Probiotik',
                    controller: controller.obatController4,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.obatStock.value -
                          double.parse(
                              controller.obatController4.text ==
                                  ''
                                  ? '0'
                                  : controller
                                  .obatController4.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedObatStock.value = state
                            .obatStock.value -
                            double.parse(controller
                                .obatController4.text ==
                                ''
                                ? '0'
                                : controller.obatController4.text);
                      });
                    },
                    suffixSection: Text(
                      state.obatType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedObatStock.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
  Widget carbonInput4() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Feed Aditives',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listCarbon.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedCarbon4.value = value!;
                          });
                          state.selectedCarbon4.value = value!;
                          state.carbID4.value = value['suplemen_id'];
                          print("carb id: ${state.carbID4.value}");
                          await state.getCarbDetail(
                              value['id'], () => null);
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.carbonPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.carbonPrice.text = temp.toString();
                            print("carbon price: ${state.carbonPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedCarbon4.value,
                        dropdownColor: inputColor,
                        items: state.listCarbon4.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok',
                    controller: controller.carbonController4,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.carbStock4.value -
                          double.parse(
                              controller.carbonController4.text == ''
                                  ? '0'
                                  : controller
                                  .carbonController4.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedCarbonStock4.value = state
                            .carbStock4.value -
                            double.parse(
                                controller.carbonController4.text == ''
                                    ? '0'
                                    : controller.carbonController4.text);
                        state.finalCarbon4Amount.text = controller.carbonController4.text;
                      });
                    },
                    suffixSection: Text(
                      state.carbType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedCarbonStock4.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget probioticInput5() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Kultur Probiotik',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listCultureProbiotik.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedCultureProbiotik.value =
                            value!;
                          });
                          state.selectedCultureProbiotik.value =
                          value!;
                          state.probID.value = value['suplemen_id'];
                          print("prob id: ${state.probID.value}");
                          await state.getProbDetail(
                              value['id'], () => null);
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.probiotikPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.probiotikPrice.text = temp.toString();
                            print("probiotik price: ${state.probiotikPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedCultureProbiotik.value,
                        dropdownColor: inputColor,
                        items: state.listCultureProbiotik.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok Probiotik',
                    controller: controller.probioticController5,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.probStock.value -
                          double.parse(
                              controller.probioticController5.text ==
                                  ''
                                  ? '0'
                                  : controller
                                  .probioticController5.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedProbStock.value = state
                            .probStock.value -
                            double.parse(controller
                                .probioticController5.text ==
                                ''
                                ? '0'
                                : controller.probioticController5.text);
                        state.finalProbiotikAmount.text = controller.probioticController5.text;
                      });
                    },
                    suffixSection: Text(
                      state.probType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedProbStock.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
  Widget obatInput5() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Obat',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listObat.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedObat.value =
                            value!;
                          });
                          state.selectedObat.value =
                          value!;
                          state.probID.value = value['suplemen_id'];
                          state.getObatDetail(
                            state.selectedObat.value['id'],
                                () => null,
                          );
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.obatPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.obatPrice.text = temp.toString();
                            print("obat price: ${state.carbonPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedObat.value,
                        dropdownColor: inputColor,
                        items: state.listObat.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok Probiotik',
                    controller: controller.obatController5,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.obatStock.value -
                          double.parse(
                              controller.obatController5.text ==
                                  ''
                                  ? '0'
                                  : controller
                                  .obatController5.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedObatStock.value = state
                            .obatStock.value -
                            double.parse(controller
                                .obatController5.text ==
                                ''
                                ? '0'
                                : controller.obatController5.text);
                        state.finalObatAmount.text = controller.obatController5.text;
                      });
                    },
                    suffixSection: Text(
                      state.obatType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedObatStock.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
  Widget carbonInput5() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Feed Aditives',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          state.listCarbon.isEmpty
              ? Center(
            child: Text(
              'Tidak ada data',
              style: headingText3.copyWith(color: Colors.red),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedCarbon5.value = value!;
                          });
                          state.selectedCarbon5.value = value!;
                          state.carbID5.value = value['suplemen_id'];
                          print("carb id: ${state.carbID5.value}");
                          await state.getCarbDetail(
                              value['id'], () => null);
                          await state.getSuplementDataByID(value['id'], (){
                            var temp = int.parse(state.carbonPrice.text);
                            temp += int.parse(state.suplementPrice.text);
                            state.carbonPrice.text = temp.toString();
                            print("carbon price: ${state.carbonPrice.text}");
                          });
                          // state.resetVariables();
                          state.customPakanName.text += value['suplemen_name'];
                          print("pakan name: ${state.customPakanName.text}");
                        },
                        value: state.selectedCarbon5.value,
                        dropdownColor: inputColor,
                        items: state.listCarbon5.map<
                            DropdownMenuItem<Map<String, dynamic>>>(
                              (val) {
                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value: val,
                              child: Text(
                                val['suplemen_name'],
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
              SizedBox(
                height: 12,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextFieldWidget(
                    label: 'Stok',
                    controller: controller.carbonController5,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    onChange: (v) {
                      if (state.carbStock5.value -
                          double.parse(
                              controller.carbonController5.text == ''
                                  ? '0'
                                  : controller
                                  .carbonController5.text) <
                          0) {
                        Flushbar(
                          message:
                          "Tidak boleh kurang dari stok tersedia",
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                      setState(() {
                        state.calculatedCarbonStock5.value = state
                            .carbStock5.value -
                            double.parse(
                                controller.carbonController5.text == ''
                                    ? '0'
                                    : controller.carbonController5.text);
                        state.finalCarbon5Amount.text = controller.carbonController5.text;
                      });
                    },
                    suffixSection: Text(
                      state.carbType.value,
                      style: headingText3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedCarbonStock5.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )

          // Container(
          //   height: 50,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 16,
          //   ),
          //   decoration: BoxDecoration(
          //     color: backgroundColor2,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: TextFormField(
          //       style: primaryTextStyle,
          //       inputFormatters: <TextInputFormatter>[
          //         FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
          //       ],
          //       keyboardType: TextInputType.number,
          //       controller: controller.probioticController,
          //       decoration: InputDecoration.collapsed(
          //         hintText: 'ex: 2',
          //         hintStyle: subtitleTextStyle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Karbon (gram)',
      //       style: primaryTextStyle.copyWith(
      //         fontSize: 16,
      //         fontWeight: medium,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     Container(
      //       height: 50,
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: backgroundColor2,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Center(
      //         child: TextFormField(
      //           style: primaryTextStyle,
      //           inputFormatters: <TextInputFormatter>[
      //             FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
      //           ],
      //           keyboardType: TextInputType.number,
      //           controller: controller.carbonController,
      //           decoration: InputDecoration.collapsed(
      //             hintText: 'ex: 2',
      //             hintStyle: subtitleTextStyle,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }


  Widget saltDosisInput() {
    return Container(
      child: Column(
        children: [
          state.saltDetail.value.data!.isEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dosis Garam',
                style: headingText2,
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  'Tidak ada data',
                  style: headingText3.copyWith(color: Colors.red),
                ),
              )
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget(
                label: 'Dosis Garam',
                controller: controller.saltController,
                numberOutput: true,
                onChange: (v) {
                  if (state.saltStock.value -
                      double.parse(
                          controller.saltController.text == ''
                              ? '0'
                              : controller.saltController.text) <
                      0) {
                    Flushbar(
                      message: "Tidak boleh kurang dari stok tersedia",
                      duration: Duration(seconds: 2),
                      leftBarIndicatorColor: Colors.red,
                    ).show(context);
                  }
                  setState(() {
                    state.calculatedSaltStock.value =
                        state.saltStock.value -
                            double.parse(
                                controller.saltController.text == ''
                                    ? '0'
                                    : controller.saltController.text);
                  });
                },
                suffixSection: Text(
                  'kg',
                  style: headingText3,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Sisa Stok : ${state.calculatedSaltStock.value}',
                style: headingText3.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

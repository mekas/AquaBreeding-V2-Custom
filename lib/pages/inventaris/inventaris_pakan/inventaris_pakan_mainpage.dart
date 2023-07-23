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
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class InventarisPakanMainpage extends StatefulWidget {
  const InventarisPakanMainpage({super.key});

  @override
  State<InventarisPakanMainpage> createState() =>
      _InventarisPakanMainpageState();
}

class _InventarisPakanMainpageState extends State<InventarisPakanMainpage> {
  InventarisPakanState state = Get.put(InventarisPakanState());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting('id', null);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor2,
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
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
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
                  'Custom',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            PakanIndustriPage(),
            PakanAlamiPage(),
            PakanCampuranPage(),
          ],
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          backgroundColor: addButtonColor,
          overlayColor: Colors.black,
          overlayOpacity: 0.6,
          spacing: 5,
          spaceBetweenChildren: 4,
          children: [
            SpeedDialChild(
              backgroundColor: Colors.green,
              labelStyle: headingText3,
              labelBackgroundColor: Colors.green,
              label: 'Tambah Pakan (+)',
              onTap: () async {
                state.resetVariables();
                await state.getPakanNameData(state.feedCategory.value);
                addFeedBottomSheet();
              },
            ),
            SpeedDialChild(
              backgroundColor: Colors.green,
              labelStyle: headingText3,
              labelBackgroundColor: Colors.green,
              label: 'Tambah Merk (+)',
              onTap: () {
                state.resetVariables();
                addNameBottomSheet();
              },
            ),
          ],
        ),
      ),
    );
  }

  getListNameBottomSheet() {
    state.resetVariables();
    BottomSheetWidget.getBottomSheetWidget(context, [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 12,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 14,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 18,
      ),
      Text(
        'List Semua Nama Suplemen',
        style: headingText1,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 54,
      ),
      Obx(
        () => state.isLoadingDetail.value
            ? Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: backgroundColor2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        state.feedNameList.value.data![index].name!,
                        style: headingText3,
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await state.deletePakanName(
                              state.feedNameList.value.data![index].idInt!,
                              () async {
                            Flushbar(
                              message: "Nama berhasil dihapus",
                              duration: Duration(seconds: 2),
                              leftBarIndicatorColor: Colors.green,
                            ).show(context);
                            await state.getPakanNameData('');
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade900,
                        ),
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                // padding: const EdgeInsets.only(bottom: padding4XL),
                itemCount: state.feedNameList.value.data!.length,
              ),
      )
    ]);
  }

  addNameBottomSheet() {
    state.resetVariables();
    state.pakanName.clear();
    BottomSheetWidget.getBottomSheetWidget(context, [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 12,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 14,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await state.getPakanNameData('');
              getListNameBottomSheet();
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 12,
              child: Icon(
                Icons.list,
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
        'Catat Nama Pakan',
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
        label: 'Nama Pakan',
        controller: state.pakanName,
        hint: 'Input nama pakan',
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
          await state.postPakanNameData(() async {
            Flushbar(
              message: "Nama berhasil ditambahkan",
              duration: Duration(seconds: 2),
              leftBarIndicatorColor: Colors.green,
            ).show(context);
            await state.getPakanNameData('');
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
    ]);
  }

  addFeedBottomSheet() {
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: inputColor,
          ),
          child: StatefulBuilder(
            builder: ((context, setState) {
              return DropdownButtonHideUnderline(
                child: DropdownButton(
                  onChanged: ((String? value) async {
                    state.resetVariables();

                    setState(() {
                      state.feedCategory.value = value!;
                    });
                    state.feedCategory.value = value!;
                    await state.getPakanNameData(state.feedCategory.value);
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
        Text(
          'Nama Pakan',
          style: headingText2,
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => state.isLoadingDetail.value
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
                                  state.selectedPakan.value = value!;
                                });
                                state.selectedPakan.value = value!;
                                state.isPakanSelected.value = true;
                                // state.name.text
                                state.resetVariables();
                              },
                              value: state.selectedPakan.value,
                              dropdownColor: inputColor,
                              items: state.listPakanName
                                  .map<DropdownMenuItem<Map<String, dynamic>>>(
                                      (material) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: material,
                                  child: Text(
                                    material['pakan_name'],
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
                },
                switchValue: state.carbSwitchValue.value,
                label: 'Karbon',
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
                  state.minSwitchValue.value = v;
                },
                switchValue: state.minSwitchValue.value,
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
            if (state.listPakanName.isEmpty ||
                state.price.text == '' ||
                state.amount.text == '' ||
                state.producer.text == '') {
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
                  Navigator.pop(context),
                  state.resetVariables(),
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

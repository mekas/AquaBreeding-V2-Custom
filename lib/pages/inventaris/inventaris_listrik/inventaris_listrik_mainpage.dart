import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/inventaris/inventaris_listrik/inventaris_listrik_pages/pascabayar_page.dart';
import 'package:fish/pages/inventaris/inventaris_listrik/inventaris_listrik_pages/prabayar_page.dart';
import 'package:fish/pages/inventaris/inventaris_listrik/inventaris_listrik_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/dialog_widget.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class InventarisListrikPage extends StatefulWidget {
  const InventarisListrikPage({Key? key}) : super(key: key);

  @override
  State<InventarisListrikPage> createState() => _InventarisListrikPageState();
}

class _InventarisListrikPageState extends State<InventarisListrikPage> {
  final InventarisListrikState state = Get.put(InventarisListrikState());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting('id', null);
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor1,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor2,
          elevation: 0,
          title: Text(
            'Listrik',
            style: headingText2,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
                icon: Icon(Icons.card_travel_rounded),
              ),
            IconButton(
              onPressed: () {
                openDateDialogPicker(context);
              },
              icon: const Icon(Icons.filter_list_rounded),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'Prabayar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Pascabayar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            PrabayarPage(),
            PascabayarPage(),
          ],
        ),
        endDrawer: DrawerInvetarisList(),
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
                  'Catat Listrik',
                  style: headingText1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 54,
                ),
                TextFieldWidget(
                  label: 'Nama',
                  controller: state.name,
                  hint: 'Ex: Token50',
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Kategori',
                  style: headingText2,
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
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
                              state.electricCategory.value = value!;
                            });
                            state.resetVariables();
                          }),
                          value: state.electricCategory.value,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => state.electricCategory.value == 'Prabayar'
                        ? Column(
                            children: [
                              TextFieldWidget(
                                label: 'Nomor Token',
                                controller: state.idToken,
                                hint: 'Ex: 1111',
                                isLong: false,
                                numberOutput: true,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final DateTime? datePicker =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  );

                                  if (datePicker != null) {
                                    var dateTime =
                                        DateTime.parse(datePicker.toString());
                                    var formatter = DateFormat('MMMM', 'id');
                                    var formattedDate =
                                        formatter.format(dateTime);
                                    state.monthPicked.text = formattedDate;
                                  } else {
                                    state.monthPicked.text = '';
                                  }
                                },
                                child: TextFieldWidget(
                                  label: 'Bulan Pembelian',
                                  controller: state.monthPicked,
                                  isLong: false,
                                  isEdit: false,
                                  suffixSection: Icon(
                                    Icons.arrow_drop_down_circle_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    Obx(
                      () => state.electricCategory.value == 'Prabayar'
                          ? TextFieldWidget(
                              label: 'Harga Beli',
                              controller: state.price,
                              isLong: false,
                              numberOutput: true,
                              hint: 'Ex: 10000',
                              prefixSection: Text(
                                'Rp',
                                style: headingText3,
                              ),
                            )
                          : TextFieldWidget(
                              label: 'Daya',
                              controller: state.power,
                              numberOutput: true,
                              isLong: false,
                              hint: 'Ex: 450',
                              suffixSection: Text(
                                'kwh',
                                style: headingText3,
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => state.electricCategory.value == 'Prabayar'
                      ? Container()
                      : Column(
                          children: [
                            TextFieldWidget(
                              label: 'Harga Beli',
                              controller: state.price,
                              hint: 'Ex: 10000',
                              numberOutput: true,
                              prefixSection: Text(
                                'Rp',
                                style: headingText3,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                ),
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
                //     'https://media.istockphoto.com/id/1183169839/vector/lightning-isolated-vector-icon-electric-bolt-flash-icon-power-energy-symbol-thunder-icon.jpg?s=612x612&w=0&k=20&c=kFdwoQHmrv8EzCofbdzL7EVW8vtgiHvhrGkOl0_N0io=',
                //     fit: BoxFit.cover,
                //   ),
                // ),
                const SizedBox(
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
                  onPressed: () async {
                    if (state.name.text == '' || state.price.text == '') {
                      Flushbar(
                        message: "Gagal, Form tidak sesuai",
                        duration: Duration(seconds: 3),
                        leftBarIndicatorColor: Colors.red[400],
                      ).show(context);
                    } else {
                      await state.postData(
                        () => {
                          state.getAllData(
                            state.firstDate.text,
                            state.lastDate.text,
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

  openDateDialogPicker(BuildContext context) {
    DialogWidget.open(
      context,
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                size: 20,
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 12),
              child: Text(
                'Pilih Tanggal',
                style: headingText2,
                textAlign: TextAlign.center,
              ),
            ),
            Container(),
          ],
        ),
        SizedBox(
          height: 36,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                final DateTime? datePicker = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                state.firstDate.text = datePicker.toString().split(' ')[0];
              },
              child: TextFieldWidget(
                label: 'Tanggal Awal',
                controller: state.firstDate,
                isLong: false,
                isEdit: false,
                suffixSection: Icon(
                  Icons.arrow_drop_down_circle_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final DateTime? datePicker = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                state.lastDate.text = datePicker.toString().split(' ')[0];
              },
              child: TextFieldWidget(
                label: 'Tanggal Akhir',
                controller: state.lastDate,
                isLong: false,
                isEdit: false,
                suffixSection: Icon(
                  Icons.arrow_drop_down_circle_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: addButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () async {
            await state.getAllData(
              state.firstDate.text,
              state.lastDate.text,
              state.pageIdentifier.value,
              () {
                Navigator.pop(context);
              },
            );
          },
          child: Icon(
            Icons.navigate_next_rounded,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

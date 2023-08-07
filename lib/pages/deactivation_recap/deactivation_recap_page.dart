import 'package:fish/pages/deactivation_recap/deactivation_recap_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/convert_to_rupiah_widget.dart';
import 'package:fish/widgets/dialog_widget.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class DeactivationRecapPage extends StatefulWidget {
  const DeactivationRecapPage({super.key});

  @override
  State<DeactivationRecapPage> createState() => _DeactivationRecapPageState();
}

class _DeactivationRecapPageState extends State<DeactivationRecapPage> {
  final DeactivationRecapState state = Get.put(DeactivationRecapState());

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id', null);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getRecap('benih', state.firstDate.text, state.lastDate.text, () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text('Rekap Panen'),
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
            icon: Icon(Icons.filter_list_rounded),
          )
        ],
      ),
      endDrawer: DrawerInvetarisList(),
      body: Obx(
        () => Container(
          color: backgroundColor1,
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: inputColor,
                  ),
                  child: StatefulBuilder(
                    builder: ((context, setState) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                          onChanged: ((String? value) async {
                            setState(() {
                              state.selectedType.value = value!;
                            });
                            state.selectedType.value = value!;
                            await state.getRecap(
                                state.selectedType.value,
                                state.firstDate.text,
                                state.lastDate.text,
                                () => null);
                          }),
                          value: state.selectedType.value,
                          dropdownColor: inputColor,
                          items: state.dropdownType.map(
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
                state.isLoadingPage.value
                    ? Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 2,
                        ),
                        child: Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : state.deactRecapList.value.data!.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 2,
                            ),
                            child: Center(
                              child: Text(
                                'Tidak ada data',
                                style: headingText3,
                              ),
                            ),
                          )
                        : Flexible(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(4, 8, 4, 20),
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.only(bottom: padding4XL),
                                itemCount:
                                    state.deactRecapList.value.data!.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                    onTap: () async {},
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          16, 8, 16, 12),
                                      decoration: BoxDecoration(
                                        color: backgroundColor1,
                                        border: Border.all(
                                            width: 2, color: primaryColor),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Tanggal Panen :',
                                                  style: headingText3,
                                                ),
                                                Text(
                                                  state.dateFormat(state
                                                      .deactRecapList
                                                      .value
                                                      .data![index]
                                                      .createdAt!
                                                      .toString()),
                                                  style: headingText3,
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Nama Kolam : ',
                                                      style: headingText3,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '.' * 100000,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${state.deactRecapList.value.data![index].pondDetail!.alias}',
                                                      style: headingText3,
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Kategori : ',
                                                      style: headingText3,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '.' * 100000,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      state
                                                          .deactRecapList
                                                          .value
                                                          .data![index]
                                                          .fishCategory
                                                          .toString(),
                                                      style: headingText3,
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Tipe Ikan : ',
                                                      style: headingText3,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '.' * 100000,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      state.deactRecapList.value
                                                          .data![index].fishType
                                                          .toString(),
                                                      style: headingText3,
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Total Berat : ',
                                                      style: headingText3,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '.' * 100000,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${state.deactRecapList.value.data![index].fishWeight} kg',
                                                      style: headingText3,
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Jumlah : ',
                                                      style: headingText3,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '.' * 100000,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${state.deactRecapList.value.data![index].fishAmount} ekor',
                                                      style: headingText3,
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: backgroundColor2,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Harga Ikan : ',
                                                        style: headingText3,
                                                      ),
                                                      Text(
                                                        'Rp${ConvertToRupiah.formatToRupiah(state.deactRecapList.value.data![index].fishPrice!)} / ekor',
                                                        style: headingText3,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
              ],
            ),
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
            await state.getRecap(
              state.selectedType.value,
              state.firstDate.text,
              state.lastDate.text,
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

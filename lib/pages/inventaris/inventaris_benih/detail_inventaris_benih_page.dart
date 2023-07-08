import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/dialog_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailInventarisBenihPage extends StatefulWidget {
  const DetailInventarisBenihPage({super.key});

  @override
  State<DetailInventarisBenihPage> createState() =>
      _DetailInventarisBenihPageState();
}

class _DetailInventarisBenihPageState extends State<DetailInventarisBenihPage> {
  final InventarisBenihState state = Get.put(InventarisBenihState());

  DateTime currDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    state.getHistorySeedData(state.firstDate.text, state.lastDate.text, () {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: backgroundColor1,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor1,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                openDateDialogPicker(context);
              },
              icon: const Icon(
                Icons.filter_list_rounded,
              ),
            )
          ],
          title: Text(
            'Riwayat Benih',
            style: headingText2,
          ),
        ),
        body: state.isLoadingHistory.value
            ? Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : state.seedHistoryList.value.data!.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada data',
                      style: headingText3,
                    ),
                  )
                : Container(
                    color: backgroundColor1,
                    child: SafeArea(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: state.seedHistoryList.value.data!.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                            decoration: BoxDecoration(
                              color: backgroundColor1,
                              border: Border.all(width: 2, color: primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Tanggal :',
                                        style: headingText3,
                                      ),
                                      Text(
                                        state.seedHistoryList.value.data![index]
                                            .createdAt!
                                            .toString()
                                            .split(' ')[0]
                                            .split('-')
                                            .reversed
                                            .join('-'),
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Tipe',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            state
                                                .seedHistoryList
                                                .value
                                                .data![index]
                                                .seed!
                                                .fishSeedCategory
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Nama',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            state.seedHistoryList.value
                                                .data![index].seed!.brandName
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Jumlah',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            '-${state.seedHistoryList.value.data![index].usage.toString()} ekor',
                                            style: TextStyle(
                                              color: Colors.red.shade900,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Kolam',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            state.seedHistoryList.value
                                                .data![index].pond
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          );
                        }),
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
            await state.getHistorySeedData(
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

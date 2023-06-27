import 'dart:developer';

import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/dialog_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class DetailInventarisPakanMainpage extends StatelessWidget {
  DetailInventarisPakanMainpage({
    Key? key,
  }) : super(key: key);

  final TextEditingController firstDate = TextEditingController();
  final TextEditingController lastDate = TextEditingController();

  final InventarisPakanState state = Get.put(InventarisPakanState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Riwayat Pakan',
          style: headingText2,
        ),
      ),
      body: Container(
        color: backgroundColor1,
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: 1,
            physics: BouncingScrollPhysics(),
            itemBuilder: ((context, index) {
              // return Container(
              //   margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              //   decoration: BoxDecoration(
              //     color: backgroundColor1,
              //     border: Border.all(width: 2, color: primaryColor),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Column(
              //     children: [
              //       Container(
              //         padding: const EdgeInsets.all(8),
              //         decoration: BoxDecoration(
              //           color: primaryColor,
              //           borderRadius: BorderRadius.circular(6),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Tanggal :',
              //               style: headingText3,
              //             ),
              //             Text(
              //               usedList[index]['date_input'],
              //               style: headingText3,
              //             )
              //           ],
              //         ),
              //       ),
              //       Container(
              //         margin: const EdgeInsets.all(12),
              //         padding: const EdgeInsets.all(12),
              //         decoration: BoxDecoration(
              //           color: greyBackgroundColor,
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child: Column(
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   'Kategori :',
              //                   style: headingText3,
              //                 ),
              //                 Text(
              //                   '${usedList[index]['category']}',
              //                   style: headingText3,
              //                 )
              //               ],
              //             ),
              //             SizedBox(
              //               height: 12,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   'Jenis Ikan :',
              //                   style: headingText3,
              //                 ),
              //                 Text(
              //                   'Ikan ${usedList[index]['fish_type']}',
              //                   style: headingText3,
              //                 )
              //               ],
              //             ),
              //             SizedBox(
              //               height: 12,
              //             ),
              //             usedList[index]['category'] == 'Kelas Benih'
              //                 ? Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Text(
              //                         'Satuan Sortir :',
              //                         style: headingText3,
              //                       ),
              //                       Text(
              //                         '${usedList[index]['sortir']} cm',
              //                         style: headingText3,
              //                       )
              //                     ],
              //                   )
              //                 : Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Text(
              //                         'Panjang & Lebar :',
              //                         style: headingText3,
              //                       ),
              //                       Text(
              //                         '${usedList[index]['panjang']}x${usedList[index]['panjang']} cm',
              //                         style: headingText3,
              //                       )
              //                     ],
              //                   ),
              //           ],
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 4,
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 12,
              //         ),
              //         child: Column(
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   'Jumlah :',
              //                   style: headingText3,
              //                 ),
              //                 Text(
              //                   '${usedList[index]['amount']} ekor',
              //                   style: headingText3,
              //                 )
              //               ],
              //             ),
              //             const SizedBox(
              //               height: 12,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   'Berat :',
              //                   style: headingText3,
              //                 ),
              //                 Text(
              //                   '${usedList[index]['weight']} gram',
              //                   style: headingText3,
              //                 )
              //               ],
              //             ),
              //             const SizedBox(
              //               height: 12,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   'Harga :',
              //                   style: headingText3,
              //                 ),
              //                 Text('Rp${usedList[index]['price']}',
              //                     style: headingText3)
              //               ],
              //             ),
              //             const SizedBox(
              //               height: 12,
              //             ),
              //           ],
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 12,
              //       ),
              //     ],
              //   ),
              // );
              return Container(
                margin: const EdgeInsets.fromLTRB(12, 14, 12, 0),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: primaryColor),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Tanggal',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Tanggal',
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
                          'Nama',
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
                          'Jumlah',
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
                          'Kolam',
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
              );
            }),
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
                firstDate.text = datePicker
                    .toString()
                    .split(' ')[0]
                    .split('-')
                    .reversed
                    .join('-');
              },
              child: TextFieldWidget(
                label: 'Tanggal Awal',
                controller: firstDate,
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
                lastDate.text = datePicker
                    .toString()
                    .split(' ')[0]
                    .split('-')
                    .reversed
                    .join('-');
              },
              child: TextFieldWidget(
                label: 'Tanggal Akhir',
                controller: lastDate,
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
          onPressed: () {
            Navigator.pop(context);
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

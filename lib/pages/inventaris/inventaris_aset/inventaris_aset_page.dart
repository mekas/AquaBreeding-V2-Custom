import 'dart:developer';

import 'package:fish/pages/inventaris/inventaris_aset/inventaris_aset_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/dialog_widget.dart';
import 'package:fish/widgets/render_inventaris_aset_list_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventarisAsetPage extends StatefulWidget {
  const InventarisAsetPage({Key? key}) : super(key: key);

  @override
  State<InventarisAsetPage> createState() => _InventarisAsetPageState();
}

class _InventarisAsetPageState extends State<InventarisAsetPage> {
  final InventarisAsetState state = Get.put(InventarisAsetState());

  String dropdownValue = 'Aset Tukang';

  static var dropdownList = [
    'Aset Tukang',
    'Aset Peralatan Budidaya',
    'Aset Kolam',
    'Aset Living',
  ];

  TextEditingController testControl = TextEditingController();
  TextEditingController testControl2 = TextEditingController();
  TextEditingController testControl3 = TextEditingController();
  TextEditingController testControl4 = TextEditingController();

  final TextEditingController firstDate = TextEditingController();
  final TextEditingController lastDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text('Aset'),
        actions: [
          IconButton(
            onPressed: () {
              openDateDialogPicker(context);
            },
            icon: Icon(Icons.filter_list_rounded),
          )
        ],
      ),
      body: Container(
        color: backgroundColor1,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16),
                height: 35,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: state.filterList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          state.currIndexFilter.value = index + 1;
                          state.selectedFilter.value =
                              state.filterList[state.currIndexFilter.value - 1]
                                  ['key'];
                          inspect(state.selectedFilter.value);
                        });
                      },
                      child: Container(
                        width: state.filterList[index]['title'] ==
                                'Peralatan Budidaya'
                            ? 150
                            : 100,
                        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: state.currIndexFilter.value ==
                                  state.filterList[index]['title_id']
                              ? Colors.white
                              : backgroundColor2,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          state.filterList[index]['title'],
                          style: headingText3.copyWith(
                            color: state.currIndexFilter.value ==
                                    state.filterList[index]['title_id']
                                ? Colors.black
                                : Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              RenderInventarisAsetListWidget(data: state.dummyDataValue2),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade600,
        onPressed: () {
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
                'Catat Aset',
                style: headingText1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 54,
              ),
              Text(
                'Kategori Aset',
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
                            dropdownValue = value!;
                          });
                          state.selectedDropdownValue.value = value!;
                        }),
                        value: dropdownValue,
                        dropdownColor: inputColor,
                        items: dropdownList.map(
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
                label: 'Nama Aset',
                controller: testControl,
                hint: 'Ex: Filter Air',
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFieldWidget(
                    label: 'Harga Beli',
                    controller: testControl2,
                    hint: 'Ex: 50000',
                    isLong: false,
                    prefixSection: Text(
                      'Rp',
                      style: headingText2,
                    ),
                  ),
                  TextFieldWidget(
                    label: 'Jumlah',
                    controller: testControl3,
                    isLong: false,
                    hint: 'Ex: 2',
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldWidget(
                label: 'Fungsi',
                controller: testControl4,
                hint: 'Fungsi Alat',
                isMoreText: true,
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
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            ],
          );
        },
        child: const Icon(
          Icons.add,
          size: 32,
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

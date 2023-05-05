import 'dart:developer';

import 'package:fish/pages/inventaris/inventaris_pakan/detail_inventaris_pakan/detail_inventaris_pakan_input_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/detail_inventaris_pakan/detail_inventaris_pakan_output_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/dialog_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class DetailInventarisPakanMainpage extends StatelessWidget {
  DetailInventarisPakanMainpage({
    Key? key,
    required this.pageIdentifier,
  }) : super(key: key);

  final String pageIdentifier;
  final TextEditingController firstDate = TextEditingController();
  final TextEditingController lastDate = TextEditingController();

  final InventarisPakanState state = Get.put(InventarisPakanState());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor1,
          elevation: 0,
          title: Column(
            children: [
              Text(
                'Detail Pakan',
                style: headingText2,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                '($pageIdentifier)',
                style: hoverText,
              ),
            ],
          ),
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
          bottom: TabBar(
            indicator: BoxDecoration(
              color: primaryColor,
            ),
            tabs: const [
              Tab(
                child: Text(
                  'Pemasukan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Pengeluaran',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DetailInventarisPakanInputPage(
              pageIdentifier: pageIdentifier,
            ),
            const DetailInventarisPakanOutputPage(),
          ],
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

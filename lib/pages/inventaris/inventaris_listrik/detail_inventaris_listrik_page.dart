import 'package:fish/pages/inventaris/inventaris_listrik/inventaris_listrik_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/dialog_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailInventarisListrikPage extends StatefulWidget {
  const DetailInventarisListrikPage({
    Key? key,
    required this.pageIdentifier,
  }) : super(key: key);

  final String pageIdentifier;

  @override
  State<DetailInventarisListrikPage> createState() =>
      _DetailInventarisListrikPageState();
}

class _DetailInventarisListrikPageState
    extends State<DetailInventarisListrikPage> {
  final InventarisListrikState state = Get.put(InventarisListrikState());
  final TextEditingController firstDate = TextEditingController();
  final TextEditingController lastDate = TextEditingController();

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
        title: Column(
          children: [
            Text(
              'Detail Tagihan',
              style: headingText2,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              '(${widget.pageIdentifier})',
              style: hoverText,
            ),
          ],
        ),
      ),
      body: Container(
        color: backgroundColor1,
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: state.dummyDataValue2.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: ((context, index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                decoration: BoxDecoration(
                  color: backgroundColor2,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tanggal :',
                            style: headingText3,
                          ),
                          Text(
                            state.dummyDataValue2[index]['date_input'],
                            style: headingText3,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jumlah :',
                                style: headingText3,
                              ),
                              Text(
                                '${state.dummyDataValue2[index]['amount']}',
                                style: headingText3,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Harga Beli :',
                                style: headingText3,
                              ),
                              Text(
                                'Rp${state.dummyDataValue2[index]['price']}',
                                style: headingText3,
                              )
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
                  initialDate: DateTime(state.selectedDetailYear.value,
                      state.selectedDetailMonth.value),
                  firstDate: DateTime(state.selectedDetailYear.value,
                      state.selectedDetailMonth.value),
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
                  initialDate: DateTime(state.selectedDetailYear.value,
                      state.selectedDetailMonth.value),
                  firstDate: DateTime(state.selectedDetailYear.value,
                      state.selectedDetailMonth.value),
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

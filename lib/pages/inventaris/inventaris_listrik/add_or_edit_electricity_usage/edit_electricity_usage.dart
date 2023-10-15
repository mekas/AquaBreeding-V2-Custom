
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../theme.dart';
import '../../../../../widgets/text_field_widget.dart';
import '../../../../widgets/dialog_widget.dart';
import '../../../../widgets/new_Menu_widget.dart';
import '../inventaris_listrik_state.dart';


class EditElectricityUsage extends StatefulWidget {
  var index;
  var id;
  EditElectricityUsage({
    Key? key,
    required this.index,
    required this.id,
  }) : super(key: key);

  @override
  State<EditElectricityUsage> createState() => _EditElectricityUsageState();
}

class _EditElectricityUsageState extends State<EditElectricityUsage> {
  var isMenuTapped = false.obs;
  final InventarisListrikState state = Get.put(InventarisListrikState());

  DateTime currDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: const Text('Edit Catatan Listrik'),
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
            const SizedBox(
              height: 18,
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

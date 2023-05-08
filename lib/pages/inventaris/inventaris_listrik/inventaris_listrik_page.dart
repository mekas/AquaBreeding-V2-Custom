import 'package:fish/pages/inventaris/inventaris_listrik/detail_inventaris_listrik_page.dart';
import 'package:fish/pages/inventaris/inventaris_listrik/inventaris_listrik_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventarisListrikPage extends StatefulWidget {
  const InventarisListrikPage({Key? key}) : super(key: key);

  @override
  State<InventarisListrikPage> createState() => _InventarisListrikPageState();
}

class _InventarisListrikPageState extends State<InventarisListrikPage> {
  final InventarisListrikState state = Get.put(InventarisListrikState());

  final TextEditingController controller = TextEditingController();

  DateTime test = DateTime(2023);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text('Listrik'),
        actions: [
          IconButton(
            onPressed: () {
              openYearDateFilter(context);
            },
            icon: const Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
      body: Container(
          margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: primaryColor),
                  borderRadius: BorderRadius.circular(14),
                  color: primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Tahun',
                          style: headingText2,
                        ),
                        SizedBox(height: 6),
                        Text(
                          '2023',
                          style: headingText3,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Total Token',
                          style: headingText2,
                        ),
                        SizedBox(height: 6),
                        Text(
                          '9000',
                          style: headingText3,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Total Harga',
                          style: headingText2,
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Rp109090',
                          style: headingText3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.dummyDataValue.length,
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: padding4XL),
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: primaryColor),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bulan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '${state.dummyDataValue[index]['month']}',
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
                                ' Token',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                state.dummyDataValue[index]['amount']
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
                                'Harga',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Rp${state.dummyDataValue[index]['total']}',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: CircleBorder(),
                            ),
                            onPressed: () {
                              state.selectedDetailMonth.value =
                                  state.dummyDataValue[index]['month_id'];
                              state.selectedDetailYear.value =
                                  state.dummyDataValue[index]['year'];

                              Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                return DetailInventarisListrikPage(
                                    pageIdentifier:
                                        '${state.dummyDataValue[index]['month']} ${state.dummyDataValue[index]['year']}');
                              })));
                            },
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          )),
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
                'Catat Listrik',
                style: headingText1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 54,
              ),
              TextFieldWidget(
                label: 'Jumlah (Token)',
                controller: controller,
                hint: 'Ex: 1000',
              ),
              const SizedBox(
                height: 16,
              ),
              TextFieldWidget(
                label: 'Harga Beli',
                controller: controller,
                hint: 'Ex: 10000',
                prefixSection: Text(
                  'Rp',
                  style: headingText3,
                ),
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

  openYearDateFilter(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Tahun"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              initialDate: DateTime.now(),
              selectedDate: test,
              onChanged: (DateTime dateTime) {
                setState(() {
                  test = dateTime;
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}

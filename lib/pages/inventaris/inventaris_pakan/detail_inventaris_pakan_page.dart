import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class DetailInventarisPakanPage extends StatelessWidget {
  DetailInventarisPakanPage({
    Key? key,
    required this.pageIdentifier,
  }) : super(key: key);

  final String pageIdentifier;

  final InventarisPakanState state = Get.put(InventarisPakanState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor1,
        title: Column(
          children: [
            Text(
              'Detail Pakan',
              style: headingText2,
            ),
            SizedBox(
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
            onPressed: () {},
            icon: Icon(
              Icons.filter_list_rounded,
            ),
          )
        ],
      ),
      body: Container(
        color: backgroundColor1,
        child: SafeArea(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 16),
            itemCount: state.dummyDataValue4.length,
            itemBuilder: ((context, index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                decoration: BoxDecoration(
                  color: backgroundColor1,
                  border: Border.all(width: 2, color: primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tanggal Input',
                            style: headingText3,
                          ),
                          Text(
                            state.dummyDataValue4[index]['date_input'],
                            style: headingText3,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: greyBackgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kategori :',
                              style: headingText3,
                            ),
                            Text(
                              'Pakan Industri',
                              style: headingText3,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kategori Protein :',
                              style: headingText3,
                            ),
                            Text(
                              '${state.dummyDataValue4[index]['protein']} %',
                              style: headingText3,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kategori Karbon :',
                              style: headingText3,
                            ),
                            Text(
                              '${state.dummyDataValue4[index]['karbon']} %',
                              style: headingText3,
                            )
                          ],
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nama / Merek :',
                                style: headingText3,
                              ),
                              Text(
                                '${state.dummyDataValue4[index]['name']}',
                                style: headingText3,
                              )
                            ],
                          ),
                          SizedBox(
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
                                '${state.dummyDataValue4[index]['price']}',
                                style: headingText3,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jumlah :',
                                style: headingText3,
                              ),
                              Text(
                                '${state.dummyDataValue4[index]['amount']} kg',
                                style: headingText3,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tgl. Kadaluarsa :',
                                style: headingText3,
                              ),
                              Text(
                                '${state.dummyDataValue4[index]['expired_date']}',
                                style: headingText3,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
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
}

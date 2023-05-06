import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailInventarisPakanInputPage extends StatefulWidget {
  const DetailInventarisPakanInputPage({Key? key, required this.pageIdentifier})
      : super(key: key);

  final String pageIdentifier;

  @override
  State<DetailInventarisPakanInputPage> createState() =>
      _DetailInventarisPakanInputPageState();
}

class _DetailInventarisPakanInputPageState
    extends State<DetailInventarisPakanInputPage> {
  final InventarisPakanState state = Get.put(InventarisPakanState());

  @override
  void initState() {
    super.initState();
    state.detailFilter.value = 'input';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor1,
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 16),
          itemCount: state.dummyDataValue4.length,
          physics: BouncingScrollPhysics(),
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
                          state.dummyDataValue4[index]['date_input'],
                          style: headingText3,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
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
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kandungan Protein :',
                            style: headingText3,
                          ),
                          Text(
                            '${state.dummyDataValue4[index]['protein']} %',
                            style: headingText3,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kandungan Karbon :',
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
                  const SizedBox(
                    height: 4,
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
                              'Nama / Merek :',
                              style: headingText3,
                            ),
                            Text(
                              '${state.dummyDataValue4[index]['name']}',
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
                              '${state.dummyDataValue4[index]['price']}',
                              style: headingText3,
                            )
                          ],
                        ),
                        widget.pageIdentifier == 'Alami'
                            ? Container()
                            : Column(
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Jumlah :',
                                        style: headingText3,
                                      ),
                                      Text(
                                        '+${state.dummyDataValue4[index]['amount']} kg',
                                        style: headingText3.copyWith(
                                            color: addButtonColor),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
    );
  }
}

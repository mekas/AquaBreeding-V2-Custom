import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_state.dart';
import 'package:fish/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class DetailInventarisBahanBudidayaInputPage extends StatefulWidget {
  const DetailInventarisBahanBudidayaInputPage({super.key});

  @override
  State<DetailInventarisBahanBudidayaInputPage> createState() =>
      _DetailInventarisBahanBudidayaInputPageState();
}

class _DetailInventarisBahanBudidayaInputPageState
    extends State<DetailInventarisBahanBudidayaInputPage> {
  final InventarisBahanBudidayaState state =
      Get.put(InventarisBahanBudidayaState());

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
          itemCount: state.dummyDataValue2.length,
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
                          state.dummyDataValue2[index]['date_input'],
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
                            'Fungsi :',
                            style: headingText3,
                          ),
                          Text(
                            '${state.dummyDataValue2[index]['function']}',
                            style: headingText3,
                          )
                        ],
                      ),
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
                              '${state.dummyDataValue2[index]['name']}',
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
                              '${state.dummyDataValue2[index]['price']}',
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
                              'Jumlah :',
                              style: headingText3,
                            ),
                            Text(
                              '+${state.dummyDataValue2[index]['amount']} kg',
                              style: headingText3.copyWith(
                                color: addButtonColor,
                              ),
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
                              'Tgl. Kadaluarsa :',
                              style: headingText3,
                            ),
                            Text(
                              '${state.dummyDataValue2[index]['expired_date']}',
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
    );
  }
}

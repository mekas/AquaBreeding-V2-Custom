import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailInventarisPakanOutputPage extends StatefulWidget {
  const DetailInventarisPakanOutputPage({Key? key}) : super(key: key);

  @override
  State<DetailInventarisPakanOutputPage> createState() =>
      _DetailInventarisPakanOutputPageState();
}

class _DetailInventarisPakanOutputPageState
    extends State<DetailInventarisPakanOutputPage> {
  final InventarisPakanState state = Get.put(InventarisPakanState());

  @override
  void initState() {
    super.initState();
    state.detailFilter.value = 'output';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor1,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: padding4XL),
            physics: BouncingScrollPhysics(),
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
                          state.dummyDataValue5[index]['date_input'],
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
                          state.dummyDataValue5[index]['name'],
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
                          '-${state.dummyDataValue5[index]['amount']} kg',
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
                          state.dummyDataValue5[index]['pond'],
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
            itemCount: state.dummyDataValue5.length,
          ),
        ),
      ),
    );
  }
}

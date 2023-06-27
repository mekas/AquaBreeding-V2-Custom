import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/render_inventaris_pakan_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BahanBudidayaPerawatanAirPage extends StatefulWidget {
  const BahanBudidayaPerawatanAirPage({super.key});

  @override
  State<BahanBudidayaPerawatanAirPage> createState() =>
      _BahanBudidayaPerawatanAirPageState();
}

class _BahanBudidayaPerawatanAirPageState
    extends State<BahanBudidayaPerawatanAirPage> {
  final InventarisBahanBudidayaState state =
      Get.put(InventarisBahanBudidayaState());

  @override
  void initState() {
    super.initState();
    state.pageDetail.value = 'Perawatan Air';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: backgroundColor1,
        // child: SafeArea(
        //   child: RenderInventarisPakanListWidget(
        //     data: state.dummyDataValue,
        //   ),
        // ),
        );
  }
}

import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/render_inventaris_organic_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BahanBudidayaObatPage extends StatefulWidget {
  const BahanBudidayaObatPage({super.key});

  @override
  State<BahanBudidayaObatPage> createState() => _BahanBudidayaObatPageState();
}

class _BahanBudidayaObatPageState extends State<BahanBudidayaObatPage> {
  final InventarisBahanBudidayaState state =
      Get.put(InventarisBahanBudidayaState());

  @override
  void initState() {
    super.initState();
    state.pageDetail.value = 'Obat-obatan';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor1,
      child: SafeArea(
        child: RenderInventarisOrganicListWidget(
          data: state.dummyDataValue,
        ),
      ),
    );
  }
}

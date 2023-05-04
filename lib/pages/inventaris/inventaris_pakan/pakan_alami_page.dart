import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/render_inventaris_organic_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PakanAlamiPage extends StatefulWidget {
  const PakanAlamiPage({super.key});

  @override
  State<PakanAlamiPage> createState() => _PakanAlamiPageState();
}

class _PakanAlamiPageState extends State<PakanAlamiPage> {
  final InventarisPakanState state = Get.put(InventarisPakanState());

  @override
  void initState() {
    super.initState();
    state.pageDetail.value = 'Alami';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor1,
      child: SafeArea(
        child: RenderInventarisOrganicListWidget(
          data: state.dummyDataValue2,
        ),
      ),
    );
  }
}

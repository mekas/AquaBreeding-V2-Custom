import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/render_inventaris_organic_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PakanCampuranPage extends StatefulWidget {
  const PakanCampuranPage({super.key});

  @override
  State<PakanCampuranPage> createState() => _PakanCampuranPageState();
}

class _PakanCampuranPageState extends State<PakanCampuranPage> {
  final InventarisPakanState state = Get.put(InventarisPakanState());

  @override
  void initState() {
    super.initState();
    state.pageDetail.value = 'Campuran';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor1,
      child: SafeArea(
        child: RenderInventarisOrganicListWidget(
          data: state.dummyDataValue3,
        ),
      ),
    );
  }
}

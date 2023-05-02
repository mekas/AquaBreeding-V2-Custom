import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/render_inventaris_organic_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PakanCampuranPage extends StatelessWidget {
  PakanCampuranPage({super.key});

  final InventarisPakanState state = Get.put(InventarisPakanState());

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

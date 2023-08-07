import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/render_inventaris_pakan_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PakanIndustriPage extends StatefulWidget {
  const PakanIndustriPage({super.key});

  @override
  State<PakanIndustriPage> createState() => _PakanIndustriPageState();
}

class _PakanIndustriPageState extends State<PakanIndustriPage> {
  final InventarisPakanState state = Get.put(InventarisPakanState());

  @override
  void initState() {
    super.initState();
    state.resetFeedVariables();
    state.resetNameVariables();
    state.setSheetFeedVariableEdit(false);
    state.setSheetNameVariableEdit(false);
    state.pageIdentifier.value = 'industri';
    state.feedCategory.value = 'Industri';
    state.category.text = 'Industri';

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getAllData('industri', () {});
      state.getPakanNameData('industri', () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor1,
      child: SafeArea(
        child: Obx(
          () => state.isLoadingPage.value
              ? Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : RenderInventarisPakanListWidget(),
        ),
      ),
    );
  }
}

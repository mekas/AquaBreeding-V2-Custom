import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/new_Menu_widget.dart';
import 'package:fish/widgets/render_inventaris_pakan_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PakanCampuranPage extends StatefulWidget {
  bool isMenuTapped;
  PakanCampuranPage({Key? key,required this.isMenuTapped,}) : super(key: key);

  @override
  State<PakanCampuranPage> createState() => _PakanCampuranPageState();
}

class _PakanCampuranPageState extends State<PakanCampuranPage> {
  final InventarisPakanState state = Get.put(InventarisPakanState());

  @override
  void initState() {
    super.initState();
    state.resetFeedVariables();
    state.resetNameVariables();
    state.setSheetFeedVariableEdit(false);
    state.setSheetNameVariableEdit(false);

    state.pageIdentifier.value = 'custom';
    state.feedCategory.value = 'Custom';
    state.category.text = 'Custom';

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getAllData('custom', () {});
      state.getPakanNameData('custom', () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor1,
      child: SafeArea(
        child: Column(
          children: [
            if (widget.isMenuTapped)
              newMenu(),
            Obx(
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
          ],
        )
      ),
    );
  }
}

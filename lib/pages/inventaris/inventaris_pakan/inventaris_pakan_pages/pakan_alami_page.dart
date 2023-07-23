import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/render_inventaris_pakan_list_widget.dart';
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
    state.resetVariables();
    state.setSheetVariableEdit(false);

    state.pageIdentifier.value = 'alami';
    state.feedCategory.value = 'Alami';

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getAllData('alami', () {});
      state.getPakanNameData('alami');
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
              : RenderInventarisPakanListWidget(
                  data: state.feedList.value,
                ),
        ),
      ),
    );
  }
}

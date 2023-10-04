import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/new_Menu_widget.dart';
import 'package:fish/widgets/render_inventaris_pakan_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/new_render_inventaris_pakan_list_widget.dart';

class NewPakanCampuranPage extends StatefulWidget {
  bool isMenuTapped;
  NewPakanCampuranPage({Key? key,required this.isMenuTapped,}) : super(key: key);

  @override
  State<NewPakanCampuranPage> createState() => _NewPakanCampuranPageState();
}

class _NewPakanCampuranPageState extends State<NewPakanCampuranPage> {
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

    state.isProbSelected.value = false;
    state.isCarbSelected.value = false;
    state.carbCheck.value = false;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getAllData('industri', () {});
      state.getPakanNameData('industri', () {});
      state.getAllCustomData(() {});
      state.getAllSuplementData('obat', () {});
      state.getAllSuplementData('Probiotik', () {
        if (state.listCultureProbiotik.isNotEmpty) {
          state.getProbDetail(
            state.selectedCultureProbiotik.value['id'],
                () => null,
          );
          state.probID.value =
          state.selectedCultureProbiotik.value['suplemen_id'];
        }
      });

      state.getAllSuplementData('Feed Additive', () {
        if (state.listCarbon.isNotEmpty) {
          state.getCarbDetail(
            state.selectedCarbon.value['id'],
                () => null,
          );
          state.carbID.value = state.selectedCarbon.value['suplemen_id'];
        }
      });

      state.getSaltDetail(() {
        if (state.saltDetail.value.data!.isNotEmpty) {
          state.calculatedSaltStock.value = double.parse(
              state.saltDetail.value.data![0].amount!.toStringAsFixed(2));
          state.saltStock.value = double.parse(
              state.saltDetail.value.data![0].amount!.toStringAsFixed(2));
          state.saltID.value =
              state.saltDetail.value.data![0].sId.toString();
        }
      });
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
              Column(
                children: [
                  SizedBox(height: 12,),
                  newMenu(),
                  SizedBox(height: 12,),
                ],
              ),
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
                  : NewRenderInventarisPakanListWidget(),
            ),
          ],
        )
      ),
    );
  }
}

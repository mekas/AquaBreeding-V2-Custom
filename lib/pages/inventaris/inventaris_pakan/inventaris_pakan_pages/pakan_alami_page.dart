import 'dart:developer';

import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/new_Menu_widget.dart';
import 'package:fish/widgets/render_inventaris_pakan_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PakanAlamiPage extends StatefulWidget {
  bool isMenuTapped;
  PakanAlamiPage({Key? key,required this.isMenuTapped,}) : super(key: key);


  @override
  State<PakanAlamiPage> createState() => _PakanAlamiPageState();
}

class _PakanAlamiPageState extends State<PakanAlamiPage> {
  final InventarisPakanState state = Get.put(InventarisPakanState());
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    state.resetFeedVariables();
    state.resetNameVariables();
    state.setSheetFeedVariableEdit(false);
    state.setSheetNameVariableEdit(false);

    state.pageIdentifier.value = 'alami';
    state.feedCategory.value = 'Alami';
    state.category.text = 'Alami';

    initSharedPrefs();


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getAllData('alami', () {});
      state.getPakanNameData('alami', () {});
      prefs.setString('page', "Alami");
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
            )
          ],
        ),
      ),
    );
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    inspect(prefs);
  }
}

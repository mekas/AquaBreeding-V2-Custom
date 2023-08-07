import 'package:fish/pages/inventaris/inventaris_aset/inventaris_aset_page.dart';
import 'package:fish/pages/inventaris/inventaris_aset/inventaris_aset_state.dart';
import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_state.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_listrik/inventaris_listrik_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_listrik/inventaris_listrik_state.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_mainpage.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/main_inventaris_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerInvetarisList extends StatelessWidget {
  DrawerInvetarisList({super.key});

  final InventarisBahanBudidayaState stateA =
      Get.put(InventarisBahanBudidayaState());

  final InventarisAsetState stateB = Get.put(InventarisAsetState());

  final InventarisListrikState stateC = Get.put(InventarisListrikState());

  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor1,
      child: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          const Text(
            'Inventaris',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 54,
          ),
          MainInvetarisButton(
            title: 'Pakan',
            doOnTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const InventarisPakanMainpage();
              }));
            },
          ),
          MainInvetarisButton(
            title: 'Suplemen',
            doOnTap: () {
              stateA.currIndexFilter.value = 1;
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const InventarisBahanBudidayaMainpage();
              }));
            },
          ),
          MainInvetarisButton(
            title: 'Listrik',
            doOnTap: () {
              stateC.thisYear = now;
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const InventarisListrikPage();
              }));
            },
          ),
          MainInvetarisButton(
            title: 'Benih',
            doOnTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const InventarisBenihMainpage();
              }));
            },
          ),
          MainInvetarisButton(
            title: 'Aset',
            doOnTap: () {
              stateB.currIndexFilter.value = 1;
              stateB.firstDate.text = '';
              stateB.lastDate.text = '';
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const InventarisAsetPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}

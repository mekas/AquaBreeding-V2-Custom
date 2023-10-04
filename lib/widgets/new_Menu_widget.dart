import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/inventaris/inventaris_aset/inventaris_aset_page.dart';
import '../pages/inventaris/inventaris_aset/inventaris_aset_state.dart';
import '../pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_mainpage.dart';
import '../pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_state.dart';
import '../pages/inventaris/inventaris_benih/inventaris_benih_mainpage.dart';
import '../pages/inventaris/inventaris_listrik/inventaris_listrik_mainpage.dart';
import '../pages/inventaris/inventaris_listrik/inventaris_listrik_state.dart';
import '../pages/inventaris/inventaris_pakan/inventaris_pakan_mainpage.dart';
import '../theme.dart';

class newMenu extends StatefulWidget {
  const newMenu({
    super.key,
  });

  @override
  State<newMenu> createState() => _newMenuState();
}

class _newMenuState extends State<newMenu> {


  final InventarisBahanBudidayaState stateA =
  Get.put(InventarisBahanBudidayaState());

  final InventarisAsetState stateB = Get.put(InventarisAsetState());

  final InventarisListrikState stateC = Get.put(InventarisListrikState());

  final DateTime now = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Column(
                children: [
                  SizedBox(
                    width: 55,
                    height: 55,
                    child: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const InventarisPakanMainpage();
                    }));}, child: Image.asset("assets/icon_pakan.png", fit: BoxFit.cover,), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(),)),
                  ),
                  SizedBox(height: 10,),
                  Text("Pakan",
                    style: primaryTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: semiBold,
                    ),)
                ],
              ), flex: 1,),
              Flexible(child: Column(
                children: [
                  SizedBox(
                    width: 55,
                    height: 55,
                    child: ElevatedButton(onPressed: (){
                      setState(() {
                        stateA.currIndexFilter.value = 1;
                      });

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const InventarisBahanBudidayaMainpage();
                      }));

                    }, child: Image.asset("assets/icon_suplemen.png", fit: BoxFit.cover,), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(),)),
                  ),
                  SizedBox(height: 10,),
                  Text("Nutrisi",
                    style: primaryTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: semiBold,
                    ),)
                ],
              ), flex: 1,),
              Flexible(child: Column(
                children: [
                  SizedBox(
                    width: 55,
                    height: 55,
                    child: ElevatedButton(onPressed: (){
                      setState(() {
                        stateC.thisYear = now;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const InventarisListrikPage();
                      }));

                    }, child: Image.asset("assets/icon_listrik.png", fit: BoxFit.cover,), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(),)),
                  ),
                  SizedBox(height: 10,),
                  Text("Listrik",
                    style: primaryTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: semiBold,
                    ),)
                ],
              ), flex: 1,),
              Flexible(child: Column(
                children: [
                  SizedBox(
                    width: 55,
                    height: 55,
                    child: ElevatedButton(onPressed: (){
                      setState(() {
                        stateB.currIndexFilter.value = 1;
                        stateB.firstDate.text = '';
                        stateB.lastDate.text = '';
                      });

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const InventarisAsetPage();
                      }));
                    }, child: Image.asset("assets/ikon_asset.png", fit: BoxFit.cover,), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(),)),
                  ),
                  SizedBox(height: 10,),
                  Text("Asset",
                    style: primaryTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: semiBold,
                    ),)
                ],
              ), flex: 1,),
              Flexible(child: Column(
                children: [
                  SizedBox(
                    width: 55,
                    height: 55,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const InventarisBenihMainpage();
                      }));
                    }, child: Image.asset("assets/icon_benih.png", fit: BoxFit.cover,), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(),)),
                  ),
                  SizedBox(height: 10,),
                  Text("Benih",
                    style: primaryTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: semiBold,
                    ),)
                ],
              ), flex: 1,)
            ],
          ),
        ),
      ],
    );
  }
}
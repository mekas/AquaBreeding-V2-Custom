import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/component/pond_card.dart';
import 'package:fish/pages/inventaris/inventaris_aset/inventaris_aset_page.dart';
import 'package:fish/pages/inventaris/inventaris_aset/inventaris_aset_state.dart';
import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_state.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_listrik/inventaris_listrik_mainpage.dart';
import 'package:fish/pages/inventaris/inventaris_listrik/inventaris_listrik_state.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_mainpage.dart';

import 'package:fish/pages/pond/add_pond_page.dart';
import 'package:fish/pages/pond/pond_controller.dart';
import 'package:fish/widgets/main_inventaris_button.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:get/get.dart';

class PondPage extends StatefulWidget {
  PondPage({Key? key}) : super(key: key);
  @override
  State<PondPage> createState() => _PondPageState();
}

class _PondPageState extends State<PondPage> {
  final PondController controller = Get.put(PondController());
  final InventarisBahanBudidayaState stateA =
      Get.put(InventarisBahanBudidayaState());

  final InventarisAsetState stateB = Get.put(InventarisAsetState());

  final InventarisListrikState stateC = Get.put(InventarisListrikState());

  DateTime now = DateTime.now();

  int? _value = null;
  final chip = ["Aktif", "Panen", "Tidak Aktif"];
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await controller.getPondActivations(
    //       pondId: controller.pond.id.toString());
    // });

    controller.getPondsData(context);
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    Widget title() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Kolam',
          style: primaryTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget filter() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Wrap(
          spacing: 8.0,
          children: List<Widget>.generate(
            3,
            (int index) {
              return ChoiceChip(
                label: Text(
                  chip[index],
                  style: TextStyle(color: Colors.white),
                ),
                shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                selected: _value == index,
                backgroundColor: backgroundColor1,
                selectedColor: primaryColor,
                onSelected: (bool selected) {
                  setState(() {
                    _value = selected ? index : null;
                    if (_value == null) {
                      controller.getPondsData(context);
                      // return null;
                    } else {
                      controller.getPondsFiltered(chip[index]);
                    }
                  });
                },
              );
            },
          ).toList(),
        ),
      );
    }

    Widget pondList() {
      return Container(
        margin: EdgeInsets.only(top: 14),
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemBuilder: ((context, index) {
              return PondCard(pond: controller.ponds[index]
                  // indicatorWater: controller.indicatorWater[index]);
                  );
            }),
            itemCount: controller.ponds.length,
          ),
        ),
      );
    }

    Widget emptyListPond() {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
          child: Center(
            child: Column(children: [
              SizedBox(height: 35),
              Image(
                image: AssetImage("assets/unavailable_icon.png"),
                width: 100,
                height: 100,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(height: 20),
              Text(
                "Anda belum pernah melakukan registrasi kolam",
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text(
                "Silahkan registrasi kolam",
                style: secondaryTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ]),
          ));
    }

    return Obx(() {
      if (controller.isLoading.value == false) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: backgroundColor1,
            title: Text('Kolam'),
            actions: [
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
                icon: Icon(Icons.card_travel_rounded),
              )
            ],
          ),
          backgroundColor: backgroundColor1,
          endDrawer: Drawer(
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const InventarisPakanMainpage();
                    }));
                  },
                ),
                MainInvetarisButton(
                  title: 'Suplemen',
                  doOnTap: () {
                    stateA.currIndexFilter.value = 1;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const InventarisBahanBudidayaMainpage();
                    }));
                  },
                ),
                MainInvetarisButton(
                  title: 'Listrik',
                  doOnTap: () {
                    stateC.thisYear = now;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const InventarisListrikPage();
                    }));
                  },
                ),
                MainInvetarisButton(
                  title: 'Benih',
                  doOnTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const InventarisAsetPage();
                    }));
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => AddPondPage());
            },
            backgroundColor: primaryColor,
            child: const Icon(Icons.add),
          ),
          body: ListView(
            children: [
              // title(),
              filter(),
              controller.ponds.isEmpty ? emptyListPond() : pondList(),
              SizedBox(
                height: 10,
              )
            ],
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: secondaryColor,
          ),
        );
      }
    });
  }
}

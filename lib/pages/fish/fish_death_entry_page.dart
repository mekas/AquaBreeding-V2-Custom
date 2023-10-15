
import 'package:fish/pages/fish/fish_death_entry_controller.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/new_Menu_widget.dart';
import 'fish_recap_controller.dart';

class FishDeathEntryPage extends StatefulWidget {
  const FishDeathEntryPage({Key? key}) : super(key: key);

  @override
  State<FishDeathEntryPage> createState() => _FishDeathEntryPageState();
}

class _FishDeathEntryPageState extends State<FishDeathEntryPage> {
  @override
  Widget build(BuildContext context) {
    final FishDeathEntryController controller =
        Get.put(FishDeathEntryController());

    final FishRecapController deathcontroller = Get.put(FishRecapController());
    var isMenuTapped = false.obs;
    var scaffoldKey = GlobalKey<ScaffoldState>();

    // @override
    // void initState() {
    //   // TODO: implement initState
    //   super.initState();
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     controller.getFish(() {
    //       controller.selectedFish.value = controller.listFishAlive[0];
    //     });
    //   });
    // }

    Widget fishTypeInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis Ikan',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Obx(
                  () => DropdownButtonFormField<Map<String, dynamic>>(
                    onChanged: (newValue) {
                      controller.selectedFish.value = newValue!;
                    },
                    value: controller.selectedFish.value,
                    items: controller.listFishAlive
                        .map<DropdownMenuItem<Map<String, dynamic>>>((fish) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: fish,
                        child: Text(
                          fish['type'],
                          style: primaryTextStyle,
                        ),
                      );
                    }).toList(),
                    dropdownColor: backgroundColor5,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget fishDeathAmountInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah Kematian Ikan (Ekor)',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Obx(
                  () {
                    return TextFormField(
                      style: primaryTextStyle,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      onChanged: controller.fishamountChanged,
                      onTap: controller.valfishamount,
                      controller: controller.formDeathController,
                      decoration: controller.validatefishamount.value == true
                          ? controller.fishamount == ''
                              ? InputDecoration(
                                  errorText: 'jumlah ikan tidak boleh kosong',
                                  isCollapsed: true)
                              : null
                          : InputDecoration.collapsed(
                              hintText: 'ex: 22', hintStyle: subtitleTextStyle),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Diagnosa',
              controller: controller.diagnosa,
            ),
          ],
        ),
      );
    }

    Widget submitButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace * 3, right: defaultMargin, left: defaultMargin),
        child: TextButton(
          onPressed: () async {
            controller.formDeathController.text == ""
                ? null
                : await controller.postFishDeath(
                    context,
                    () {
                      deathcontroller.getFishDeaths(
                          activation_id: controller.activation.id.toString());
                    },
                  );

            deathcontroller.getcharData(
                activation_id: controller.activation.id.toString());
            controller.postDataLog(controller.fitur);
            Navigator.pop(context);
            // Navigator.pushReplacement(context, MaterialPageRoute(
            //   builder: (context) {
            //     return DashboardPage();
            //   },
            // ));
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Submit',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    return Obx(() {
      if (controller.isLoading.value == false) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: backgroundColor2,
            title: const Text("Entry Kematian Ikan"),
            actions: [
              IconButton(
                onPressed: () {
                  // scaffoldKey.currentState?.openEndDrawer();
                  setState(() {
                    isMenuTapped.value = !isMenuTapped.value;
                  });
                },
                icon: Icon(Icons.card_travel_rounded),
              )
            ],
          ),
          endDrawer: DrawerInvetarisList(),
          backgroundColor: backgroundColor1,
          body: ListView(
            children: [
              if (isMenuTapped.value)
                Column(
                  children: [
                    newMenu(),
                    SizedBox(height: 10,),
                  ],
                ),
              fishTypeInput(),
              fishDeathAmountInput(),
              submitButton(),
              SizedBox(
                height: 8,
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

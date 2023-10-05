import 'dart:developer';

import 'package:fish/pages/inventaris/inventaris_bahan_budidaya/inventaris_bahan_budidaya_state.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/inventaris_pakan_state.dart';

import 'package:fish/models/pond_model.dart';
import 'package:fish/pages/component/activation_card.dart';
import 'package:fish/pages/pond/activation_breed_controller.dart';
import 'package:fish/pages/pond/activation_breed_page.dart';
import 'package:fish/pages/pond/pond_controller.dart';
import 'package:fish/pages/pond/add_pond_page.dart';
import 'package:fish/pages/pond/deactivation_breed_page.dart';
import 'package:fish/pages/pond/detail_pond_controller.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/new_Menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:get/get.dart';

import '../fish_transfer/fish_transfer_entry_page.dart';
import 'deactivation_breed_controller.dart';
import 'edit_pond_page.dart';

class DetailPondPage extends StatefulWidget {
  bool isMenuTapped;
 DetailPondPage({
    Key? key,
    required this.isMenuTapped,
  }) : super(key: key);

  @override
  State<DetailPondPage> createState() => _DetailPondPageState();
}

class _DetailPondPageState extends State<DetailPondPage> {
  final detailController = Get.put(DetailPondController());
  final activationController = Get.put(ActivationBreedController());
  // final feedEntryController = Get.put(FeedEntryController());
  // final DeactivationBreedController panenController =
  // Get.put(DeactivationBreedController());

  final pondController = Get.put(PondController());
  final InventarisPakanState pakanState = Get.put(InventarisPakanState());
  final InventarisBahanBudidayaState supState =
      Get.put(InventarisBahanBudidayaState());

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await controller.getPondActivations(
    //       pondId: controller.pond.id.toString());
    // });
    detailController.getPondActivation();

    activationController.pondName.value =
        'kolam ${detailController.pondController.selectedPond.value.alias}';
    pakanState.pondName.value =
        'kolam ${detailController.pondController.selectedPond.value.alias}';
    supState.pondName.value =
        'kolam ${detailController.pondController.selectedPond.value.alias}';
    // panenController.pondName.value = 'kolam ${detailController.pondController.selectedPond.value.alias}';
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    Widget pondStatus() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "kolam ${detailController.pondController.selectedPond.value.alias}",
                      style: primaryTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: heavy,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      detailController.pondController.selectedPond.value
                          .getGmtToNormalDate(),
                      style: secondaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 16,),

                  ],
                ),
                IconButton(
                    color: Colors.white,
                    iconSize: 28,
                    onPressed: () {
                      Get.to(() => const EditPondPage());
                    },
                    icon: const Icon(Icons.edit_outlined)),
              ],
            ),

            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // border: Border.all(color: detailController.pondController.selectedPond.getColor()),

                color: detailController.isPondActive.value
                    ? Colors.green
                    : Colors.red.shade300,
              ),
              child: Center(
                child: Text(
                  detailController.isPondActive.value == false
                      ? "Tidak Aktif"
                      : "Aktif",
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: heavy,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget activationButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: defaultSpace,
          right: defaultMargin,
          left: defaultMargin,
          bottom: 12,
        ),
        child: TextButton(
          onPressed: () {
            Get.to(() => ActivationBreedPage(), arguments: {
              'pond': detailController.pondController.selectedPond.value,
            });
            detailController.postDataLog(detailController.fitur);
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.green.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Start Budidaya',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ),
      );
    }

    Widget deactivationButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: defaultSpace,
          right: defaultMargin,
          left: defaultMargin,
          bottom: 12,
        ),
        child: TextButton(
          onPressed: () {
            // detailController.getPondActivation();
            Get.defaultDialog(
                title: 'Konfirmasi Panen!',
                middleText: 'Apakah anda yakin ingin melakukan panen?',
                buttonColor: primaryColor,
                confirmTextColor: Colors.white,
                cancelTextColor: Colors.black,
                textConfirm: 'Panen',
                textCancel: 'Tidak',
                onConfirm: (() {
                  Navigator.pop(context);
                  Get.to(() => DeactivationBreedPage(), arguments: {
                    "pond": detailController.pondController.selectedPond.value,
                    "activation": detailController.activations[0],
                  });

                }));

          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Panen',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    Widget detail() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lokasi Kolam",
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  detailController.pondController.selectedPond.value.location!,
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Bentuk Kolam",
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  detailController.pondController.selectedPond.value.shape!,
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Material Kolam",
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  detailController.pondController.selectedPond.value.material!,
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Ukuran Kolam",
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  detailController.pondController.selectedPond.value.shape! ==
                          "persegi"
                      ? "${detailController.pondController.selectedPond.value.length}m x ${detailController.pondController.selectedPond.value.width}m"
                      : "${detailController.pondController.selectedPond.value.diameter}m\u00B2",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget activationTitle() {
      return Container(
        width: double.infinity,
        margin:
            EdgeInsets.only(right: defaultMargin, left: defaultMargin, top: 12),
        child: Text(
          "List Musim Budidaya",
          style: primaryTextStyle.copyWith(
            fontSize: 14,
            fontWeight: bold,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );
    }

    Widget listActivation() {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: defaultMargin, left: defaultMargin),
          child: Column(
            children: detailController.activations
                .map(
                  (activation) => ActivationCard(
                      activation: activation,
                      pond: detailController.pondController.selectedPond.value),
                )
                .toList(),
          ));
    }

    Widget emptyListActivation() {
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
                "Kolam belum pernah\nmemulai musim budidaya",
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
                "Silahkan memulai musim budidaya!",
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

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Obx(
        () => detailController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              )
            : ListView(
                children: [
                  if (widget.isMenuTapped)
                    Column(
                      children: [
                        newMenu(),
                        SizedBox(height: 10,),
                      ],
                    ),
                  pondStatus(),
                  detail(),
                  detailController.isPondActive.value == false
                      ? activationButton()
                      : deactivationButton(),
                  Divider(
                    color: Colors.white24,
                    height: 30,
                    thickness: 2,
                  ),
                  activationTitle(),
                  detailController.activations.isEmpty
                      ? emptyListActivation()
                      : listActivation(),
                  // detailController.activations.isEmpty
                  //     ? listActivation()
                  //     : emptyListActivation(),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
      ),
    );
  }
}

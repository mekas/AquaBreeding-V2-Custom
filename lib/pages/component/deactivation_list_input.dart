import 'package:fish/models/fish_model.dart';
import 'package:flutter/material.dart';
import 'package:fish/pages/pond/deactivation_breed_controller.dart';
import 'package:fish/theme.dart';
import 'package:get/get.dart';

class DeactivationListCard extends StatelessWidget {
  final Fish fish;

  DeactivationListCard({Key? key, required this.fish}) : super(key: key);
  final DeactivationBreedController controller =
      Get.put(DeactivationBreedController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: defaultMargin / 2,
      ),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                fish.type!,
                style: headingText2,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                "${fish.amount.toString()} Ekor",
                style: secondaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: TextFormField(
                style: primaryTextStyle,
                controller: fish.type! == "lele"
                    ? controller.leleWeightController
                    : fish.type! == "patin"
                        ? controller.patinWeightController
                        : fish.type! == "nila hitam"
                            ? controller.nilaHitamWeightController
                            : fish.type == "nila merah"
                                ? controller.nilaMerahWeightController
                                : controller.masWeightController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Total Berat Ikan (Kg)',
                  hintStyle: subtitleTextStyle,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Harga',
                style: headingText2,
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  print('hHH');
                },
                child: Icon(
                  Icons.info_outline,
                  color: Colors.grey,
                  size: 18,
                ),
              )
            ],
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: backgroundColor1,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    'Rp',
                    style: hoverText.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    style: headingText3,
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '100,000.00 / ekor',
                      hintStyle: hoverText.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

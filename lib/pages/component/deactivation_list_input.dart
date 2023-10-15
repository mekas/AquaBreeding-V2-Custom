
import 'package:fish/models/fish_model.dart';
import 'package:fish/widgets/text_field_widget.dart';
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
    // inspect(fish);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: defaultMargin / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                fish.type!,
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(
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
          TextFieldWidget(
            hint: 'ex: 2.3',
            suffixSection: Text(
              'kg',
              style: headingText3,
            ),
            label: 'Berat Ikan Total',
            controller: fish.type! == "lele"
                ? controller.leleWeightController
                : fish.type! == "patin"
                    ? controller.patinWeightController
                    : fish.type! == "nila hitam"
                        ? controller.nilaHitamWeightController
                        : fish.type == "nila merah"
                            ? controller.nilaMerahWeightController
                            : controller.masWeightController,
          ),
          SizedBox(
            height: 12,
          ),
          TextFieldWidget(
            prefixSection: Text(
              'Rp',
              style: headingText3,
            ),
            suffixSection: Text(
              '/ ekor',
              style: headingText3,
            ),
            label: 'Harga Ikan',
            controller: fish.type! == "lele"
                ? controller.lelePriceController
                : fish.type! == "patin"
                    ? controller.patinPriceController
                    : fish.type! == "nila hitam"
                        ? controller.nilaHitamPriceController
                        : fish.type == "nila merah"
                            ? controller.nilaMerahPriceController
                            : controller.masPriceController,
            isEdit: false,
          )
        ],
      ),
    );
  }
}

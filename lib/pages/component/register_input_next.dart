// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:get/get.dart';
import '../../controllers/authentication/register_controller.dart';

class RegisterNextInputCard extends StatelessWidget {
  final VoidCallback registerfunc;
  final PageController pageController;
  RegisterNextInputCard(
      {Key? key, required this.registerfunc, required this.pageController})
      : super(key: key);
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor1,
          boxShadow: [
            BoxShadow(
              color: backgroundColor3,
              blurRadius: 4,
              offset: const Offset(2, 8), // Shadow position
            ),
          ],
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Tempat Budidaya Anda Sudah Terdaftar?',
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                  child: Obx(() {
                    return DropdownButtonFormField<String>(
                      onChanged: ((value) {
                        controller.hasFarmController
                            .setSelected(value.toString());
                      }),
                      value: controller.hasFarmController.selected.value,
                      items:
                          controller.hasFarmController.listMethod.map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: primaryTextStyle,
                          ),
                        );
                      }).toList(),
                      dropdownColor: backgroundColor5,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              controller.hasFarmController.selected.value == "Sudah"
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Tempat Budidaya',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Sudah"
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Sudah"
                  ? Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: backgroundColor2,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Obx(() {
                          return DropdownButtonFormField<String>(
                            onChanged: ((value) {
                              controller.farmlistController
                                  .setSelected(value.toString());
                              controller.getFarmId(value.toString());
                            }),
                            value: controller.farmlistController.selected.value,
                            items: controller.listFarmName.map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(
                                  type,
                                  style: primaryTextStyle,
                                ),
                              );
                            }).toList(),
                            dropdownColor: backgroundColor5,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          );
                        }),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              const SizedBox(
                height: 10,
              ),
              controller.hasFarmController.selected.value == "Belum"
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Tempat Budidaya',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? Container(
                      height: 42,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: backgroundColor2,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Obx(() {
                        return TextFormField(
                          style: primaryTextStyle,
                          onChanged: controller.farmNameChanged,
                          onTap: controller.valfarmName,
                          controller: controller.farmnameController,
                          decoration: controller.validatefarmName.value == true
                              ? controller.farmName == ''
                                  ? const InputDecoration(
                                      errorText: 'farmName tidak boleh kosong',
                                      isCollapsed: true)
                                  : null
                              : null,
                        );
                      })),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Alamat',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? Container(
                      height: 42,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: backgroundColor2,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Obx(() {
                        return TextFormField(
                          style: primaryTextStyle,
                          onChanged: controller.addressChanged,
                          onTap: controller.valaddress,
                          controller: controller.addressController,
                          decoration: controller.validateaddress.value == true
                              ? controller.address == ''
                                  ? const InputDecoration(
                                      errorText: 'address tidak boleh kosong',
                                      isCollapsed: true)
                                  : null
                              : null,
                        );
                      })),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Jumlah Pembudidaya (Opsional)',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? Container(
                      height: 42,
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
                          controller: controller.breedercountController,
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Koordinat Lokasi (Opsional)',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? Container(
                      height: 42,
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
                          controller: controller.coordinateController,
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.hasFarmController.selected.value == "Belum"
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              Container(
                height: 42,
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin / 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => pageController.previousPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Kembali',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          controller.hasFarmController.selected.value ==
                                      "Sudah" &&
                                  controller
                                          .farmlistController.selected.value ==
                                      "Pilih Tempat Budidaya"
                              ? null
                              : controller.hasFarmController.selected.value ==
                                              "Belum" &&
                                          controller.farmnameController.text ==
                                              '' ||
                                      controller.addressController.text == ''
                                  ? null
                                  : registerfunc.call();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 6,
              ),
            ],
          );
        }));
  }
}

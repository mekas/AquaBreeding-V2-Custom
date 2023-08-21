import 'package:fish/pages/pond/pond_controller.dart';
import 'package:fish/widgets/drawer_inventaris_list.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AddPondPage extends StatefulWidget {
  const AddPondPage({Key? key}) : super(key: key);

  @override
  State<AddPondPage> createState() => _AddPondPageState();
}

class _AddPondPageState extends State<AddPondPage> {
  final PondController controller = Get.put(PondController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting('id', null);
  }

  @override
  void dispose() {
    controller.aliasController.clear();
    controller.diameterController.clear();
    controller.heightController.clear();
    controller.locationController.clear();
    controller.lengthController.clear();
    controller.widthController.clear();
    controller.selectedUsedDate.value = '';
    controller.showedUsedDate.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    Widget aliasInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alias Kolam',
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
              child: Center(child: Obx(() {
                return TextFormField(
                  style: primaryTextStyle,
                  onChanged: controller.aliasChanged,
                  onTap: controller.valAlias,
                  controller: controller.aliasController,
                  decoration: controller.validateAlias.value == true
                      ? controller.alias == ''
                          ? InputDecoration(
                              errorText: 'tinggi tidak boleh kosong',
                              isCollapsed: true)
                          : InputDecoration.collapsed(
                              hintText: 'ex: Flamboyan',
                              hintStyle: subtitleTextStyle)
                      : InputDecoration.collapsed(
                          hintText: 'ex: Flamboyan',
                          hintStyle: subtitleTextStyle),
                );
              })),
            ),
          ],
        ),
      );
    }

    Widget locationInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lokasi Kolam (Opsional)',
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
                child: TextFormField(
                  style: primaryTextStyle,
                  controller: controller.locationController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'ex: Blok A',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget materialInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Material',
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
                child: Obx(() => DropdownButtonFormField<String>(
                      onChanged: (newValue) =>
                          controller.materialController.setSelected(newValue!),
                      value: controller.materialController.selected.value,
                      items: controller.materialController.listMaterial
                          .map((material) {
                        return DropdownMenuItem<String>(
                          value: material,
                          child: Text(
                            material,
                            style: primaryTextStyle,
                          ),
                        );
                      }).toList(),
                      dropdownColor: backgroundColor5,
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
              ),
            ),
          ],
        ),
      );
    }

    Widget shapelInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bentuk',
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
                child: Obx(() => DropdownButtonFormField<String>(
                      onChanged: (newValue) {
                        return controller.shapeController
                            .setSelected(newValue!);
                      },
                      value: controller.shapeController.selected.value,
                      items:
                          controller.shapeController.listMaterial.map((shape) {
                        return DropdownMenuItem<String>(
                          value: shape,
                          child: Text(
                            shape,
                            style: primaryTextStyle,
                          ),
                        );
                      }).toList(),
                      dropdownColor: backgroundColor5,
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
              ),
            ),
          ],
        ),
      );
    }

    Widget heightInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tinggi (meter)',
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
              child: Center(child: Obx(() {
                return TextFormField(
                  style: primaryTextStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                  ],
                  onChanged: controller.heightChanged,
                  onTap: controller.valHeight,
                  controller: controller.heightController,
                  decoration: controller.validateHeight.value == true
                      ? controller.height == ''
                          ? InputDecoration(
                              errorText: 'tinggi tidak boleh kosong',
                              isCollapsed: true)
                          : InputDecoration.collapsed(
                              hintText: 'ex: 2.1', hintStyle: subtitleTextStyle)
                      : InputDecoration.collapsed(
                          hintText: 'ex: 2.1', hintStyle: subtitleTextStyle),
                );
              })),
            ),
          ],
        ),
      );
    }

    Widget lengthInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Panjang (meter)',
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
              child: Center(child: Obx(() {
                return TextFormField(
                  style: primaryTextStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                  ],
                  onChanged: controller.lenghtChanged,
                  onTap: controller.valLenght,
                  controller: controller.lengthController,
                  decoration: controller.validatelenght.value == true
                      ? controller.lenght == ''
                          ? InputDecoration(
                              errorText: 'Panjang tidak boleh kosong',
                              isCollapsed: true)
                          : InputDecoration.collapsed(
                              hintText: 'ex: 1.1', hintStyle: subtitleTextStyle)
                      : InputDecoration.collapsed(
                          hintText: 'ex: 1.1', hintStyle: subtitleTextStyle),
                );
              })),
            ),
          ],
        ),
      );
    }

    Widget widthInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lebar (meter)',
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
              child: Center(child: Obx(() {
                return TextFormField(
                  style: primaryTextStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                  ],
                  onChanged: controller.widthChanged,
                  onTap: controller.valWidth,
                  controller: controller.widthController,
                  decoration: controller.validateWidth.value == true
                      ? controller.width == ''
                          ? InputDecoration(
                              errorText: 'lebar tidak boleh kosong',
                              isCollapsed: true)
                          : InputDecoration.collapsed(
                              hintText: 'ex: 1.1', hintStyle: subtitleTextStyle)
                      : InputDecoration.collapsed(
                          hintText: 'ex: 1.1', hintStyle: subtitleTextStyle),
                );
              })),
            ),
          ],
        ),
      );
    }

    Widget diameterInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Diameter (meter)',
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
              child: Center(child: Obx(() {
                return TextFormField(
                  style: primaryTextStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp(r'[-+=*#%/,\s]'))
                  ],
                  onChanged: controller.diameterChanged,
                  onTap: controller.valDiameter,
                  controller: controller.diameterController,
                  decoration: controller.validatediameter.value == true
                      ? controller.diameter == ''
                          ? InputDecoration(
                              errorText: 'diameter tidak boleh kosong',
                              isCollapsed: true)
                          : InputDecoration.collapsed(
                              hintText: 'ex: 2.1', hintStyle: subtitleTextStyle)
                      : InputDecoration.collapsed(
                          hintText: 'ex: 2.1', hintStyle: subtitleTextStyle),
                );
              })),
            ),
          ],
        ),
      );
    }

    Widget registerButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: defaultSpace * 3, right: defaultMargin, left: defaultMargin),
        child: TextButton(
          onPressed: () async {
            if (controller.shapeController.selected.value == 'persegi' &&
                controller.widthController.text == '') {
              return null;
            }
            if (controller.shapeController.selected.value == 'persegi' &&
                controller.lengthController.text == '') {
              return null;
            }
            if (controller.shapeController.selected.value == 'bundar' &&
                controller.diameterController.text == '') {
              print("ini masuk sini");
              return null;
            } else {
              await controller.pondRegister(
                context,
                () {
                  controller.getPondsData(context);
                },
              );
            }
            // profilecontroller.getBreeder();
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Registrasi',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    Widget persegiInput() {
      return Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [widthInput(), lengthInput()],
      ));
    }

    Widget bundarInput() {
      return Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [diameterInput()],
      ));
    }

    return Obx(() {
      if (controller.isLoading.value == false) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: backgroundColor2,
            title: const Text("Registrasi Kolam"),
            actions: [
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
                icon: Icon(Icons.card_travel_rounded),
              )
            ],
          ),
          endDrawer: DrawerInvetarisList(),
          backgroundColor: backgroundColor1,
          body: ListView(
            children: [
              aliasInput(),
              locationInput(),
              materialInput(),
              shapelInput(),
              controller.shapeController.selected.value == 'persegi'
                  ? persegiInput()
                  : bundarInput(),
              heightInput(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: controller.checkUsedDate.value,
                          onChanged: (v) {
                            controller.checkUsedDate.value = v!;
                            controller.selectedUsedDate.value = '';
                            controller.showedUsedDate.clear();
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Aktifkan tanggal input pakan manual',
                              style: headingText3,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    controller.checkUsedDate.value
                        ? GestureDetector(
                            onTap: () async {
                              final DateTime? datePicker = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              // ignore: use_build_context_synchronously
                              if (datePicker != null) {
                                final TimeOfDay? selectedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime:
                                      TimeOfDay.fromDateTime(datePicker!),
                                  builder: (context, child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child!,
                                    );
                                  },
                                );

                                if (selectedTime != null) {
                                  // Define the format for parsing

                                  // Define the format for parsing the input date and time string
                                  String inputFormatStr =
                                      'EEEE, d MMMM yyyy | \'Jam\' HH:mm:ss.SSS';
                                  DateTime dateTime =
                                      DateFormat(inputFormatStr, 'id_ID').parse(
                                          '${controller.dateFormat(datePicker.toString(), false)} | Jam ${selectedTime!.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}:00.000');

                                  // Define the format for formatting the date into the desired format
                                  String outputFormatStr =
                                      'yyyy-MM-ddTHH:mm:ss.SSS';
                                  String formattedDateTime =
                                      DateFormat(outputFormatStr)
                                          .format(dateTime);

                                  controller.selectedUsedDate.value =
                                      datePicker == null
                                          ? ''
                                          : '$formattedDateTime +0000';

                                  controller.showedUsedDate.text = datePicker ==
                                          null
                                      ? ''
                                      : '${controller.dateFormat(datePicker.toString(), false)} | Jam ${selectedTime!.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}';
                                }
                              }
                            },
                            child: TextFieldWidget(
                              label: 'Pilih Tanggal',
                              controller: controller.showedUsedDate,
                              isLong: true,
                              isEdit: false,
                              suffixSection: Icon(
                                Icons.arrow_drop_down_circle_rounded,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              registerButton(),
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

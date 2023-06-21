import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/inventaris/inventaris_benih/inventaris_benih_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KelasBenihPage extends StatefulWidget {
  KelasBenihPage({super.key});

  @override
  State<KelasBenihPage> createState() => _KelasBenihPageState();
}

class _KelasBenihPageState extends State<KelasBenihPage> {
  final InventarisBenihState state = Get.put(InventarisBenihState());

  @override
  void initState() {
    super.initState();
    state.getAllSeedData('Benih');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
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
          : Container(
              margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: state.seedList.value.data!.isEmpty
                  ? Center(
                      child: Text(
                        'Tidak ada data',
                        style: headingText2,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: padding4XL),
                      itemCount: state.seedList.value.data!.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () async {
                            getBottomSheet(index,
                                state.seedList.value.data![index].idInt!);
                            await state.getSeedDataByID(
                                state.seedList.value.data![index].idInt!);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: primaryColor),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Tahun',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                state.seedList.value
                                                    .data![index].createdAt
                                                    .toString()
                                                    .split('-')[0],
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Jenis Ikan',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                state.seedList.value
                                                    .data![index].fishType
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Uk. Sortir',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                state.seedList.value
                                                    .data![index].width
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Jumlah',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                '${state.seedList.value.data![index].amount} ekor',
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Divider(color: Colors.white),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Text(
                                            'Harga : ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '.' * 100,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Rp${state.seedList.value.data![index].price}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
            ),
    );
  }

  getBottomSheet(int index, int id) {
    BottomSheetWidget.getBottomSheetWidget(
      context,
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                radius: 12,
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          'Edit Benih',
          style: headingText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 54,
        ),
        Text(
          'Kategori : ${state.seedCategory.value}',
          style: headingText2,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Jenis Ikan',
          style: headingText2,
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: inputColor,
          ),
          child: StatefulBuilder(
            builder: ((context, setState) {
              return DropdownButtonHideUnderline(
                child: DropdownButton(
                  onChanged: ((String? value) {
                    setState(() {
                      state.fishCategory.value = value!;
                    });
                  }),
                  value: state.fishCategory.value,
                  dropdownColor: inputColor,
                  items: state.dropdownList2.map(
                    (String val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(
                          val,
                          style: headingText3,
                        ),
                      );
                    },
                  ).toList(),
                ),
              );
            }),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFieldWidget(
          label: 'Nama',
          controller: state.fishName,
          hint: 'Ex: Ikan01',
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(
          () => state.seedCategory.value == 'Benih'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Satuan Sortir',
                              style: headingText2,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: inputColor,
                              ),
                              child: StatefulBuilder(
                                builder: ((context, setState) {
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      onChanged: ((String? value) {
                                        setState(() {
                                          state.sortSize.value = value!;
                                        });
                                      }),
                                      value: state.sortSize.value,
                                      dropdownColor: inputColor,
                                      items: state.dropdownList3.map(
                                        (String val) {
                                          return DropdownMenuItem(
                                            value: val,
                                            child: Text(
                                              val,
                                              style: headingText3,
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                        TextFieldWidget(
                          label: 'Jumlah',
                          controller: state.fishAmount,
                          isLong: false,
                          hint: 'Ex: 1000',
                          numberOutput: true,
                          suffixSection: Text(
                            'ekor',
                            style: headingText3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldWidget(
                          label: 'Berat',
                          controller: state.fishWeight,
                          isLong: false,
                          hint: 'Ex: 100',
                          numberOutput: true,
                          suffixSection: Text(
                            'gram',
                            style: headingText3,
                          ),
                        ),
                        TextFieldWidget(
                          label: 'Jumlah',
                          controller: state.fishAmount,
                          hint: 'Ex: 1000',
                          isLong: false,
                          numberOutput: true,
                          suffixSection: Text(
                            'ekor',
                            style: headingText3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
        ),
        TextFieldWidget(
          label: 'Harga Beli',
          controller: state.fishPrice,
          hint: 'Ex: 10000',
          isLong: true,
          numberOutput: true,
          prefixSection: Text(
            'Rp',
            style: headingText3,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Gambar',
          style: headingText2,
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey,
          ),
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Image.network(
            'https://www.hepper.com/wp-content/uploads/2022/09/red-male-betta-fish-in-aquarium_Grigorii-Pisotscki-Shutterstock.jpg',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 36,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: addButtonColor,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () async {
            if (state.fishName.text == '' ||
                state.fishAmount.text == '' ||
                state.fishPrice.text == '') {
              Flushbar(
                message: "Gagal, Form tidak sesuai",
                duration: Duration(seconds: 3),
                leftBarIndicatorColor: Colors.red[400],
              ).show(context);
            } else {
              await state.updateSeedData(
                id,
                () => {
                  state.getAllSeedData('Benih'),
                  state.resetVariables(),
                  Navigator.pop(context),
                },
              );
            }
          },
          child: Obx(
            () => state.isLoadingPost.value
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Ubah',
                    style: headingText2,
                  ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        ElevatedButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Hapus Data'),
                    content: const Text(
                        'Apakah anda yakin ingin menghapus data ini?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await state.deleteSeedData(
                              state.seedList.value.data![index].idInt!,
                              () => {
                                    state.getAllSeedData('Benih'),
                                  });
                          if (context.mounted) Navigator.of(context).pop();
                          if (context.mounted) Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Obx(
            () => state.isLoadingDelete.value
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Hapus',
                    style: headingText2,
                  ),
          ),
        ),
      ],
    );
  }
}

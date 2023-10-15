
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme.dart';
import '../../../../widgets/new_Menu_widget.dart';
import '../../../../widgets/text_field_widget.dart';
import '../inventaris_bahan_budidaya_state.dart';

class EditBahanBudidaya extends StatefulWidget {
  var index;
  var id;
  var isEditable;
  EditBahanBudidaya({
    Key? key,
    required this.index,
    required this.id,
    required this.isEditable
  }) : super(key: key);

  @override
  State<EditBahanBudidaya> createState() => _EditBahanBudidayaState();
}

class _EditBahanBudidayaState extends State<EditBahanBudidaya> {
  var isMenuTapped = false.obs;
  InventarisBahanBudidayaState state = Get.put(InventarisBahanBudidayaState());

  DateTime currDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: const Text("Edit Bahan"),
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
      backgroundColor: backgroundColor1,
      body: Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: ListView(
          children:[
            if (isMenuTapped.value)
              Column(
                children: [
                  SizedBox(height: 12,),
                  newMenu(),
                  SizedBox(height: 12,),
                ],
              ),
            const SizedBox(
              height: 18,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fungsi : ${state.functionCategory.value}',
                  style: headingText2,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
            Obx(
                  () => state.functionCategory.value == 'Feed Additive'
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Nama Suplemen',
                    style: headingText2,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
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
                                state.selectedFeedAdditive.value = value!;
                              });
                              state.selectedFeedAdditive.value = value!;
                            }),
                            value: state.selectedFeedAdditive.value,
                            dropdownColor: inputColor,
                            items: state.listFeedAdditive.map(
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
                  )
                ],
              )
                  : TextFieldWidget(
                label: 'Nama Suplemen',
                controller: state.name,
                hint: 'Ex: garam',
                isEdit: state.nameEdit.value,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(
                  () => TextFieldWidget(
                label: 'Deskripsi Bahan',
                controller: state.desc,
                isMoreText: true,
                hint: 'Ex: Bahan kimia',
                isEdit: state.descEdit.value,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: TextFieldWidget(
                          label: 'Jumlah',
                          controller: state.amount,
                          isLong: false,
                          numberOutput: true,
                          hint: 'Ex: 1',
                          isEdit: state.amountEdit.value,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                                    state.typeCategory.value = value!;
                                  });
                                  state.typeCategory.value = value!;
                                }),
                                value: state.typeCategory.value,
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
                    ],
                  ),
                  TextFieldWidget(
                    label: 'Harga Beli',
                    controller: state.price,
                    isLong: false,
                    hint: 'Ex: 100',
                    numberOutput: true,
                    isEdit: state.priceEdit.value,
                    prefixSection: Text(
                      'Rp',
                      style: headingText3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFieldWidget(
                    label: 'Min. Expired',
                    controller: state.minExp,
                    isLong: false,
                    numberOutput: true,
                    isEdit: state.minExpEdit.value,
                    hint: 'Ex: 10',
                    suffixSection: Text(
                      'hari',
                      style: headingText3,
                    ),
                  ),
                  TextFieldWidget(
                    label: 'Max. Expired',
                    controller: state.maxExp,
                    isLong: false,
                    numberOutput: true,
                    hint: 'Ex: 10',
                    isEdit: state.maxExpEdit.value,
                    suffixSection: Text(
                      'hari',
                      style: headingText3,
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 16,
            // ),
            // Text(
            //   'Gambar (Struk)',
            //   style: headingText2,
            // ),
            // const SizedBox(
            //   height: 12,
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     color: Colors.grey,
            //   ),
            //   width: MediaQuery.of(context).size.width,
            //   height: 300,
            //   child: Image.network(
            //     'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/06/28062837/vector_5.kesehatan-vitamin-dan-suplemen.jpg',
            //     fit: BoxFit.cover,
            //   ),
            // ),
            const SizedBox(
              height: 36,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(
                      () => state.isSheetEditable.value
                      ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: addButtonColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () async {
                      if (state.name.text == '' ||
                          state.price.text == '' ||
                          state.amount.text == '') {
                        Flushbar(
                          message: "Gagal, Form tidak sesuai",
                          duration: Duration(seconds: 3),
                          leftBarIndicatorColor: Colors.red[400],
                        ).show(context);
                      } else {
                        await state.updateData(
                          widget.id,
                              () => {
                            state.getAllData(
                              state.pageIdentifier.value,
                                  () {},
                            ),
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
                        'Simpan',
                        style: headingText2,
                      ),
                    ),
                  )
                      : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade400,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Ubah Data'),
                              content: const Text(
                                  'Apakah anda yakin ingin mengubah data ini?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Tidak'),
                                  child: const Text('Tidak'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    state.setSheetVariableEdit(true);
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: const Text('Ya'),
                                ),
                              ],
                            );
                          });
                    },
                    child: Text(
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
                                  await state.deleteData(
                                      state.suplemenList.value.data![widget.index].idInt!,
                                          () => {
                                        state.getAllData(
                                          state.pageIdentifier.value,
                                              () {},
                                        ),
                                      });
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
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
            )
          ],
        ),
      ),
    );
  }
}

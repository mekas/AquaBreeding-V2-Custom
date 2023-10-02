import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme.dart';
import '../../../../widgets/text_field_widget.dart';

import '../../../widgets/new_Menu_widget.dart';
import 'inventaris_aset_state.dart';

class AddorEditAsset extends StatefulWidget {
  var index;
  var id;
  var isEditable;

  AddorEditAsset(
      {Key? key,
      required this.index,
      required this.id,
      required this.isEditable})
      : super(key: key);

  @override
  State<AddorEditAsset> createState() => _AddorEditAssetState();
}

class _AddorEditAssetState extends State<AddorEditAsset> {
  final InventarisAsetState state = Get.put(InventarisAsetState());
  var isMenuTapped = false.obs;
  DateTime currDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: widget.isEditable ?  const Text('Edit Asset') : const Text('Catat Asset'),
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
            widget.isEditable
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kategori : ${state.assetCategory.value}',
                  style: headingText2,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            )
                : Container(),
            widget.isEditable
                ? Container()
                : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Kategori Aset',
                  style: headingText2,
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
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
                              state.assetCategory.value = value!;
                            });
                          }),
                          value: state.assetCategory.value,
                          dropdownColor: inputColor,
                          items: state.dropdownList.map(
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
              ],
            ),
            Obx(
                  () => TextFieldWidget(
                label: 'Nama Aset',
                controller: state.name,
                hint: 'Ex: Filter Air',
                isEdit: state.nameEdit.value,
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
                    label: 'Jumlah',
                    controller: state.amount,
                    isLong: false,
                    hint: 'Ex: 2',
                    isEdit: state.amountEdit.value,
                    suffixSection: Text(
                      'buah',
                      style: headingText3,
                    ),
                  ),
                  TextFieldWidget(
                    label: 'Harga Beli',
                    controller: state.price,
                    hint: 'Ex: 50000',
                    isLong: false,
                    isEdit: state.priceEdit.value,
                    prefixSection: Text(
                      'Rp',
                      style: headingText2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(
                  () => TextFieldWidget(
                label: 'Deskripsi',
                controller: state.desc,
                isMoreText: true,
                hint: 'Ex: memfilter air kolam',
                isEdit: state.descEdit.value,
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
            //     'https://lh3.googleusercontent.com/p/AF1QipPgPgQ17AeKRLeQWWb3sZYRtkyoJndsRMKE8rNc=w1080-h608-p-no-v0',
            //     fit: BoxFit.cover,
            //   ),
            // ),
            const SizedBox(
              height: 36,
            ),
            widget.isEditable
                ? Column(
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
                          state.amount.text == '' ||
                          state.image.value == '') {
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
                              state.firstDate.text,
                              state.lastDate.text,
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
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await state.deleteData(
                                      state.assetList.value.data![widget.index]
                                          .idInt!,
                                          () => {
                                        state.getAllData(
                                          state.pageIdentifier.value,
                                          state.firstDate.text,
                                          state.lastDate.text,
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
                : ElevatedButton(
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
                    state.amount.text == '' ||
                    state.image.value == '') {
                  Flushbar(
                    message: "Gagal, Form tidak sesuai",
                    duration: Duration(seconds: 3),
                    leftBarIndicatorColor: Colors.red[400],
                  ).show(context);
                } else {
                  await state.postData(
                        () => {
                      state.getAllData(
                        state.pageIdentifier.value,
                        state.firstDate.text,
                        state.lastDate.text,
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
                    : Icon(
                  Icons.add,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

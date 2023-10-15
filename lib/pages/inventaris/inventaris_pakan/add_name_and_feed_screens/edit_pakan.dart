
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme.dart';
import '../../../../widgets/new_Menu_widget.dart';
import '../../../../widgets/text_field_widget.dart';
import '../inventaris_pakan_state.dart';
import '../pakan_custom_controller.dart';

class EditPakan extends StatefulWidget {
  var index;
  var id;

  EditPakan(
      {Key? key,
      required this.index,
      required this.id})
      : super(key: key);

  @override
  State<EditPakan> createState() => _EditPakanState();
}

class _EditPakanState extends State<EditPakan> {
  InventarisPakanState state = Get.put(InventarisPakanState());
  final PakanCustomController controller =
  Get.put(PakanCustomController());
  var isMenuTapped = false.obs;
  DateTime currDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: const Text('Edit Pakan'),
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
          children: [
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
            Text(
              'Kategori Pakan : Pakan ${state.feedCategory.value}',
              style: headingText2,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'List Nama Pakan',
              style: headingText2,
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
                  () => state.isLoadingNameDetail.value
                  ? Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
                  : state.listPakanName.isEmpty
                  ? Center(
                child: Text(
                  'Tidak ada data',
                  style: headingText3.copyWith(
                    color: Colors.red,
                  ),
                ),
              )
                  : Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: inputColor,
                ),
                child: StatefulBuilder(
                  builder: ((context, setState) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<Map<String, dynamic>>(
                        onChanged: (value) async {
                          setState(() {
                            state.selectedPakan.value = value!;
                          });
                          state.selectedPakan.value = value!;
                          state.isPakanSelected.value = true;
                          // state.name.text

                          state.resetFeedVariables();
                          await state.getDetailPakanNameData(
                              state.selectedPakan.value['id'],
                                  () => null);
                        },
                        value: state.selectedPakan.value,
                        dropdownColor: inputColor,
                        items: state.listPakanName
                            .map<DropdownMenuItem<Map<String, dynamic>>>(
                                (material) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: material,
                                child: Text(
                                  material['feed_name'],
                                  style: headingText3,
                                ),
                              );
                            }).toList(),
                      ),
                    );
                  }),
                ),
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
                    numberOutput: true,
                    hint: 'Ex: 1.5',
                    isEdit: state.amountEdit.value,
                    suffixSection: Text(
                      'kg',
                      style: headingText3,
                    ),
                  ),
                  TextFieldWidget(
                    label: 'Harga Beli',
                    controller: state.price,
                    isLong: false,
                    numberOutput: true,
                    hint: 'Ex: 10',
                    isEdit: state.priceEdit.value,
                    prefixSection: Text(
                      'Rp',
                      style: headingText3,
                    ),
                  ),
                ],
              ),
            ),
            state.listPakanName.isEmpty
                ? Container()
                : Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Divider(
                    thickness: 10,
                    height: 10,
                    color: backgroundColor2,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Obx(
                      () => state.isLoadingNameDetail.value
                      ? Center(
                      child: SizedBox(
                        child:
                        CircularProgressIndicator(color: Colors.white),
                        width: 50,
                        height: 50,
                      ))
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFieldWidget(
                        label: 'Produser Pakan',
                        controller: state.producer,
                        hint: 'Ex: Sinta',
                        isLong: true,
                        isEdit: false,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFieldWidget(
                        label: 'Deskripsi Pakan',
                        controller: state.desc,
                        hint: 'Ex: Bahan pakan ikan',
                        isMoreText: true,
                        isEdit: false,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldWidget(
                            label: 'Protein',
                            controller: state.protein,
                            isLong: false,
                            numberOutput: true,
                            hint: 'Ex: 10',
                            isEdit: false,
                            suffixSection: const Icon(
                              Icons.percent,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextFieldWidget(
                            label: 'Karbon',
                            controller: state.carbo,
                            isLong: false,
                            numberOutput: true,
                            hint: 'Ex: 10',
                            isEdit: false,
                            suffixSection: const Icon(
                              Icons.percent,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldWidget(
                            label: 'Min. Expired',
                            controller: state.minExp,
                            isLong: false,
                            numberOutput: true,
                            hint: 'Ex: 10',
                            isEdit: false,
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
                            isEdit: false,
                            suffixSection: Text(
                              'hari',
                              style: headingText3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
            //     'https://1.bp.blogspot.com/-9tt1qS0wO-8/X8uLEZd9HGI/AAAAAAAAAnQ/4uGdwluBvYg-cwgjFAf85P_MzITSUos1ACLcBGAsYHQ/s1078/Pakan.png',
            //     fit: BoxFit.cover,
            //   ),
            // ),
            const SizedBox(
              height: 36,
            ),
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
                  if (state.listPakanName.isEmpty ||
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
                        Navigator.pop(context),
                        state.resetFeedVariables(),
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
                                state.setSheetFeedVariableEdit(true);
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
                                  state.feedList.value.data![widget.index].idInt!,
                                      () => {
                                    state.getAllData(
                                      state.pageIdentifier.value,
                                          () {},
                                    ),
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
        ),
      ),
    );
  }
}

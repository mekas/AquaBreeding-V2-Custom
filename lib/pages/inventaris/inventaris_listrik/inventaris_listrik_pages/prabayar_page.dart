import 'package:another_flushbar/flushbar.dart';
import 'package:fish/pages/inventaris/inventaris_listrik/inventaris_listrik_state.dart';
import 'package:fish/theme.dart';
import 'package:fish/widgets/bottom_sheet_widget.dart';
import 'package:fish/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrabayarPage extends StatefulWidget {
  const PrabayarPage({super.key});

  @override
  State<PrabayarPage> createState() => _PrabayarPageState();
}

class _PrabayarPageState extends State<PrabayarPage> {
  final InventarisListrikState state = Get.put(InventarisListrikState());

  @override
  void initState() {
    super.initState();
    state.pageIdentifier.value = 'prabayar';

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.getAllData(state.thisYear.year, 'prabayar', () {});
    });
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
          : state.electricList.value.data!.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada data',
                    style: headingText3,
                  ),
                )
              : Container(
                  margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.electricList.value.data!.length,
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: padding4XL),
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await state.getDataByID(
                              state.electricList.value.data![index].idInt!, () {
                            getBottomSheet(index,
                                state.electricList.value.data![index].idInt!);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: primaryColor),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: primaryColor),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  color: primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tanggal :',
                                      style: headingText3,
                                    ),
                                    Text(
                                        state.electricList.value.data![index]
                                            .createdAt
                                            .toString()
                                            .split(' ')[0]
                                            .split('-')
                                            .reversed
                                            .join('-'),
                                        style: headingText3),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Nama : ',
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
                                          state.electricList.value.data![index]
                                              .name
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                          'Rp${state.electricList.value.data![index].price.toString()}',
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
          'Edit Listrik',
          style: headingText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 54,
        ),
        Text(
          'Kategori : ${state.electricList.value.data![index].type}',
          style: headingText2,
        ),
        const SizedBox(
          height: 16,
        ),
        TextFieldWidget(
          label: 'Nama',
          controller: state.name,
          hint: 'Ex: Token50',
        ),
        const SizedBox(
          height: 16,
        ),
        TextFieldWidget(
          label: 'Harga Beli',
          controller: state.price,
          hint: 'Ex: 10000',
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
          'Gambar (Struk)',
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
            'https://media.istockphoto.com/id/1183169839/vector/lightning-isolated-vector-icon-electric-bolt-flash-icon-power-energy-symbol-thunder-icon.jpg?s=612x612&w=0&k=20&c=kFdwoQHmrv8EzCofbdzL7EVW8vtgiHvhrGkOl0_N0io=',
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
            if (state.name.text == '' || state.price.text == '') {
              Flushbar(
                message: "Gagal, Form tidak sesuai",
                duration: Duration(seconds: 3),
                leftBarIndicatorColor: Colors.red[400],
              ).show(context);
            } else {
              await state.updateData(
                id,
                () => {
                  state.getAllData(
                    state.thisYear.year,
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
                              state.electricList.value.data![index].idInt!,
                              () => {
                                    state.getAllData(
                                      state.thisYear.year,
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
    );
  }
}
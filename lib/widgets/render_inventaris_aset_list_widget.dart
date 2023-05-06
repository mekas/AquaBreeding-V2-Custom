import 'package:fish/theme.dart';
import 'package:flutter/material.dart';

class RenderInventarisAsetListWidget extends StatelessWidget {
  const RenderInventarisAsetListWidget({Key? key, required this.data})
      : super(key: key);

  final List data;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            decoration: BoxDecoration(
              color: backgroundColor1,
              border: Border.all(width: 2, color: primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tanggal :',
                        style: headingText3,
                      ),
                      Text(
                        data[index]['date_input'],
                        style: headingText3,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nama :',
                            style: headingText3,
                          ),
                          Text(
                            '${data[index]['name']}',
                            style: headingText3,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Harga Beli :',
                            style: headingText3,
                          ),
                          Text(
                            'Rp ${data[index]['price']}',
                            style: headingText3,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jumlah :',
                            style: headingText3,
                          ),
                          Text(
                            '${data[index]['amount']} Buah',
                            style: headingText3,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Fungsi :',
                        style: headingText3,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        '${data[index]['function']}',
                        style: hoverText,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

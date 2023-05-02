import 'package:fish/theme.dart';
import 'package:fish/widgets/render_inventaris_list_widget.dart';
import 'package:flutter/material.dart';

class PakanIndustriPage extends StatelessWidget {
  const PakanIndustriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor1,
      child: SafeArea(
        child: RenderInventarisListWidget(
          dataLength: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Nama / Merek',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Pelet',
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
                    '30 kg',
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
                    'Kadaluarsa',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '22-02-2022',
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
      ),
    );
  }
}

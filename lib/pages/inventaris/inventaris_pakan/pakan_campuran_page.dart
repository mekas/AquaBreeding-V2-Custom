import 'package:fish/theme.dart';
import 'package:flutter/material.dart';

class PakanCampuranPage extends StatelessWidget {
  const PakanCampuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor1,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Text(
                'Ini Campuran',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

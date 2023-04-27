import 'package:fish/theme.dart';
import 'package:flutter/material.dart';

class PakanAlamiPage extends StatelessWidget {
  const PakanAlamiPage({super.key});

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
                'Ini Alami',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

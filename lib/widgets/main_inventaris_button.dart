import 'package:fish/theme.dart';
import 'package:flutter/material.dart';

class MainInvetarisButton extends StatelessWidget {
  MainInvetarisButton({Key? key, required this.title, required this.doOnTap})
      : super(key: key);

  String? title;
  Function? doOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: primaryColor,
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Pakan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 24,
            )
          ],
        ),
      ),
    );
  }
}

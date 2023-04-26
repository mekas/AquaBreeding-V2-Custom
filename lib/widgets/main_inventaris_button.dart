import 'package:fish/theme.dart';
import 'package:flutter/material.dart';

class MainInvetarisButton extends StatelessWidget {
  const MainInvetarisButton(
      {Key? key, required this.title, required this.doOnTap})
      : super(key: key);

  final String title;
  final Function() doOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: primaryColor,
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: doOnTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 24,
            )
          ],
        ),
      ),
    );
  }
}

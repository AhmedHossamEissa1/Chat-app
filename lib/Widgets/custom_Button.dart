import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String txt;
  VoidCallback? onTab;
  CustomButton({this.onTab, required this.txt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: Center(child: Text(txt)),
      ),
    );
  }
}

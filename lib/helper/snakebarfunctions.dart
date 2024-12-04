  import 'dart:ui';



import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        
        backgroundColor: color,
        content: Text(msg),
        duration: const Duration(seconds: 2),
      ),
    );
  }

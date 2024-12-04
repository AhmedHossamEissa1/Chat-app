import 'package:flutter/material.dart';

class CustomTextFormfield extends StatelessWidget {
  final String? input; // Use 'final' for immutable fields
  Function(String)? onChanged;
  String? id;
  bool? obSecureText;

  // Constructor with both input and onChanged parameters
  CustomTextFormfield(
      {Key? key,
      this.input,
      this.onChanged,
      this.id,
      this.obSecureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.amber),
      obscureText: obSecureText!,
      onChanged: (value) {
        onChanged!(value);
      },
      validator: (value) {
        if (value == '') {
          return 'Required field';
        }
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: input,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          gapPadding: 10,
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          gapPadding: 10,
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}

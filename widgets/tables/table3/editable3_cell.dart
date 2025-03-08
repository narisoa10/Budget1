import 'package:flutter/material.dart';

class Editable3Cell extends StatelessWidget {
  final String initialValue;
  final TextStyle textStyle;
  final ValueChanged<String> onChanged;

  const Editable3Cell({
    super.key,
    required this.initialValue,
    required this.textStyle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      style: textStyle,
      textAlign: TextAlign.center,
      cursorHeight: 20.0,
      cursorWidth: 1.0,
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        isDense: true,
      ),
      onChanged: onChanged,
    );
  }
}

import 'package:flutter/material.dart';

class Editable1Cell extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final Color cursorColor;
  final double cursorWidth;
  final double? cursorHeight;

  const Editable1Cell({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.center,
    this.padding = const EdgeInsets.all(8.0),
    this.textStyle,
    this.cursorColor = Colors.black,
    this.cursorWidth = 1.0,
    this.cursorHeight = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        textAlign: textAlign,
        style: textStyle,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        cursorColor: Colors.black,
        cursorWidth: 1.0,
        enableInteractiveSelection: false, // Отключает интерактивные маркеры
        onChanged: onChanged,
      ),

    );
  }
}

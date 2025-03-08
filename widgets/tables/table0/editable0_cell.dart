import 'package:flutter/material.dart';

class Editable0Cell extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;
  final TextStyle? textStyle;  // Добавляем параметр для стиля текста

  const Editable0Cell({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.textStyle,  // Поддержка кастомного стиля текста
  });

  @override
  Widget build(BuildContext context) {
    return Center(  // Оборачиваем TextFormField в Center для выравнивания
      child: TextFormField(
        initialValue: initialValue,
        textAlign: TextAlign.center,  // Центрируем текст
        decoration: const InputDecoration(
          isDense: true,  // Убираем лишние отступы
          contentPadding: EdgeInsets.symmetric(vertical: 0.0),  // Настраиваем минимальные отступы
          border: InputBorder.none,  // Убираем рамку
        ),
        style: textStyle,  // Применяем кастомный стиль текста
        onChanged: onChanged,
        cursorColor: Colors.black,  // Цвет курсора
        cursorWidth: 1.0,  // Толщина курсора
        cursorHeight: 20.0,  // Изменяем высоту курсора
      ),
    );
  }
}

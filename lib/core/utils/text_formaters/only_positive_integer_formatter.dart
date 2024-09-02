import 'package:flutter/services.dart';

class OnlyPositiveIntegerFormatter extends TextInputFormatter {
  OnlyPositiveIntegerFormatter({this.maxLength = 3});

  final int maxLength;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isEmpty ||
        (newText.isNotEmpty &&
            int.parse(newText) >= 1 &&
            newText.length <= maxLength)) {
      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    } else {
      return oldValue;
    }
  }
}

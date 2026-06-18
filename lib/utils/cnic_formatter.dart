import 'package:flutter/services.dart';

class CnicFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final text = newValue.text;
    final digitsOnly = text.replaceAll(RegExp(r'\D'), '');
    final truncatedDigits = digitsOnly.length > 13 ? digitsOnly.substring(0, 13) : digitsOnly;

    final buffer = StringBuffer();
    for (int i = 0; i < truncatedDigits.length; i++) {
      buffer.write(truncatedDigits[i]);
      if (i == 4 && truncatedDigits.length > 5) {
        buffer.write('-');
      } else if (i == 11 && truncatedDigits.length > 12) {
        buffer.write('-');
      }
    }

    final formattedText = buffer.toString();
    int selectionOffset = newValue.selection.baseOffset;
    
    // Calculate how many digits were entered before the cursor to reposition the selection
    int digitsBeforeCursor = text
        .substring(0, selectionOffset.clamp(0, text.length))
        .replaceAll(RegExp(r'\D'), '')
        .length;

    int newOffset = digitsBeforeCursor;
    if (digitsBeforeCursor > 5) {
      newOffset += 1; // account for first hyphen
    }
    if (digitsBeforeCursor > 12) {
      newOffset += 1; // account for second hyphen
    }

    newOffset = newOffset.clamp(0, formattedText.length);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}

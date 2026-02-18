import 'package:flutter/services.dart';

class Phoneinput extends TextInputFormatter {
  static final _validPrefixes = ["010", "011", "012", "015"];

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(' ', ''); // شيل المسافات

    // لو بدأ المستخدم بـ 11 أو 12 أو 15 أو 10 من غير صفر → نضيف الصفر
    if (text.isNotEmpty && text.length <= 11) {
      if (text.startsWith("10") ||
          text.startsWith("11") ||
          text.startsWith("12") ||
          text.startsWith("15")) {
        text = "0$text";
      }
    }

    if (text.length > 11) {
      text = text.substring(0, 11); // أقصى 11 رقم
    }

    // تحقق من الكود
    if (text.length >= 3 && !_validPrefixes.contains(text.substring(0, 3))) {
      return oldValue; // رجّع القيمة القديمة لو الكود غلط
    }

    // تنسيق: 3 - 4 - 4
    String formatted = '';
    if (text.length <= 3) {
      formatted = text;
    } else if (text.length <= 7) {
      formatted = '${text.substring(0, 3)} ${text.substring(3)}';
    } else {
      formatted =
          '${text.substring(0, 3)} ${text.substring(3, 7)} ${text.substring(7)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

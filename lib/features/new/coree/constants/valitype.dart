import 'package:get/get.dart';

String? validInput(String val, int min, int max, String type) {
  // أولاً: التحقق من أن الحقل مش فاضي
  if (val.trim().isEmpty) {
    return "⚠️ هذا الحقل لا يمكن أن يكون فارغًا";
  }

  // ثانيًا: حسب نوع الحقل
  switch (type) {
    case "username":
      if (!GetUtils.isUsername(val)) {
        return "⚠️ اسم المستخدم غير صالح (استخدم حروف أو أرقام فقط)";
      }
      break;

    case "email":
      if (!GetUtils.isEmail(val)) {
        return "⚠️ البريد الإلكتروني غير صالح";
      }
      break;

    case "phone":
      String phone = val.replaceAll(" ", "");
      if (!GetUtils.isPhoneNumber(phone)) {
        return "⚠️ من فضلك أدخل رقم هاتف صحيح";
      }
      if (!(phone.startsWith("010") ||
          phone.startsWith("011") ||
          phone.startsWith("012") ||
          phone.startsWith("015"))) {
        return "⚠️ يجب أن يبدأ رقم الهاتف بكود (010, 011, 012, 015)";
      }
      if (phone.length != 11) {
        return "⚠️ رقم الهاتف يجب أن يتكون من 11 رقمًا";
      }
      break;

    case "link":
      if (!GetUtils.isURL(val)) {
        return "⚠️ من فضلك أدخل رابط صحيح (URL)";
      }
      break;

    case "number":
      if (!GetUtils.isNum(val)) {
        return "⚠️ من فضلك أدخل رقمًا صحيحًا";
      }
      break;

    case "password":
      if (val.length < min) {
        return "⚠️ كلمة المرور يجب ألا تقل عن $min أحرف";
      }
      if (val.length > max) {
        return "⚠️ كلمة المرور يجب ألا تزيد عن $max أحرف";
      }
      if (!RegExp(r'[A-Z]').hasMatch(val)) {
        return "⚠️ كلمة المرور يجب أن تحتوي على حرف كبير (Capital)";
      }
      if (!RegExp(r'[a-z]').hasMatch(val)) {
        return "⚠️ كلمة المرور يجب أن تحتوي على حرف صغير (Small)";
      }
      if (!RegExp(r'[0-9]').hasMatch(val)) {
        return "⚠️ كلمة المرور يجب أن تحتوي على رقم واحد على الأقل";
      }
      break;

    default:
      break;
  }

  // ثالثًا: تحقق من الطول
  if (val.length < min) {
    return "⚠️ يجب ألا يقل طول القيمة عن $min حرفًا/رقمًا";
  }

  if (val.length > max) {
    return "⚠️ يجب ألا يزيد طول القيمة عن $max حرفًا/رقمًا";
  }

  return null; // ✅ صالح
}

class RegexManager {
  static final intRegex = RegExp(r'^\d+$');
  static final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final priceRegex = RegExp(r'^\d+(\.\d{1,2})?$');
  static final phoneRegex = RegExp(r'^[0-9]+$');
  static final dateRegex = RegExp(
    r'^(\d{4}-\d{2}-\d{2}|\d{2}[/-]\d{2}[/-]\d{4})$',
  );
  static final passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$',
  );
}

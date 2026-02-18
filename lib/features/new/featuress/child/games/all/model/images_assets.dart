class ImageAssets {
  // يمكن استبدال هذه بمجموعة من الصور الحقيقية
  static const List<String> imagePaths = [
    'assets/images/animal1.png',
    'assets/images/animal2.png',
    'assets/images/animal3.png',
    'assets/images/animal4.png',
    'assets/images/animal5.png',
    'assets/images/animal6.png',
    'assets/images/animal7.png',
    'assets/images/animal8.png',
    'assets/images/animal9.png',
    'assets/images/animal10.png',
    'assets/images/animal11.png',
    'assets/images/animal12.png',
  ];

  static String getImagePath(int imageId) {
    return imagePaths[(imageId - 1) % imagePaths.length];
  }
}

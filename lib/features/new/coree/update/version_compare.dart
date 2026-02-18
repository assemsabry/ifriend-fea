bool isUpdateRequired(String current, String latest) {
  List<int> currentParts = current
      .split('.')
      .map((e) => int.tryParse(e) ?? 0)
      .toList();

  List<int> latestParts = latest
      .split('.')
      .map((e) => int.tryParse(e) ?? 0)
      .toList();

  for (int i = 0; i < latestParts.length; i++) {
    if (i >= currentParts.length) return true;
    if (latestParts[i] > currentParts[i]) return true;
    if (latestParts[i] < currentParts[i]) return false;
  }

  return false;
}

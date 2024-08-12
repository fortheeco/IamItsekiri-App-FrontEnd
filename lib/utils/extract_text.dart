String extractText(dynamic data) {
  List<String> texts = [];

  void process(dynamic item) {
    if (item is String) {
      texts.add(item);
    } else if (item is Map) {
      item.values.forEach(process);
    } else if (item is List) {
      item.forEach(process);
    }
  }

  process(data);
  return texts.join(' ');
}

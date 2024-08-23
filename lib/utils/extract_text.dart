String extractText(dynamic data) {
  List<String> texts = [];

  void process(dynamic item, [String? key]) {
    key != null ? texts.add(key) : null;
    if (item is String && item.isNotEmpty) {
      texts.add(item);
    } else if (item is Map) {
      item.forEach((k, v) {
        process(v, k);
      });
    } else if (item is List) {
      item.forEach(process);
    }
  }

  process(data);
  return texts.join(': ');
}

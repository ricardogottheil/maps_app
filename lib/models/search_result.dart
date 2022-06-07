class SearchResult {
  final bool cancel;
  final bool? manual;

  //TODO:
  // name, description, latlng

  SearchResult({
    required this.cancel,
    this.manual = false,
  });

  @override
  String toString() {
    return 'SearchResult{cancel: $cancel, manual: $manual}';
  }
}

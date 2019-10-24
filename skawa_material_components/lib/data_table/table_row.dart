class TableRow<T> {
  final T data;

  bool checked;

  List<String> classes;

  TableRow(this.data, {this.checked, this.classes});
}

class TableRows<T> {
  bool selectable = false;
  bool highlightable = true;
  bool multiSelection = true;
  bool colorOddRows = true;

  List<TableRow<T>> rows = [];
  TableRow<T> highlightedRow;

  TableRows([List<T> rows]) {
    if (rows != null) addRows(rows);
  }

  void addRow(T data,
      {bool checked = false,
      bool highlighted = false,
      List<String> classes = const <String>[],
      bool refresh = false,
      bool sort = false}) {
    rows.add(TableRow<T>(data, checked: checked, classes: classes));
    if (highlighted) highlightedRow = rows.last;
    if (sort) this.sort();
    if (refresh) this.refresh();
  }

  void addRows(Iterable<T> data,
      {bool checked = false, List<String> classes = const <String>[], bool refresh = false, bool sort = false}) {
    rows.addAll(data.map((T data) => TableRow<T>(data, checked: checked, classes: classes)));
    if (sort) this.sort();
    if (refresh) this.refresh();
  }

  void sort([int compare(TableRow<T> a, TableRow<T> b)]) => rows.sort(compare);

  void refresh() => rows = rows.toList();
}

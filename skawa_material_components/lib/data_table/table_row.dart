class TableRow<T> {
  final T data;

  bool checked;

  List<String> classes;

  TableRow(this.data, {this.checked, this.classes});
}

class TableRows<T> {
  List<TableRow<T>> rows = [];

  TableRow<T> highlightedRow;

  TableRows(List<T> rows) {
    addRows(rows);
  }

  void addRow(T data, {bool checked = false, bool highlighted = false, List<String> classes = const <String>[]}) {
    rows.add(TableRow<T>(data, checked: checked, classes: classes));
    if (highlighted) highlightedRow = rows.last;
  }

  void addRows(Iterable<T> data, {bool checked = false, List<String> classes = const <String>[]}) {
    rows.addAll(data.map((T data) => TableRow<T>(data, checked: checked, classes: classes)));
  }
}

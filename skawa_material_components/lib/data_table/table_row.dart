import 'package:quiver/collection.dart';

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
  Map<T, TableRow<T>> _tuples = {};

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
    _tuples[data] = rows.last;
    if (highlighted) highlightedRow = _tuples[rows];
    if (sort) this.sort();
    if (refresh) this.refresh();
  }

  void addRows(Iterable<T> data,
      {bool checked = false, List<String> classes = const <String>[], bool refresh = false, bool sort = false}) {
    rows.addAll(data.map((T data) {
      var row = TableRow<T>(data, checked: checked, classes: classes);
      _tuples[data] = row;
      return row;
    }));
    if (sort) this.sort();
    if (refresh) this.refresh();
  }

  void highlight(T data) {
    highlightedRow = _tuples[data];
    refresh();
  }

  void sort([int compare(TableRow<T> a, TableRow<T> b)]) => rows.sort(compare);

  void refresh() => rows = rows.toList();

  @override
  int get hashCode => rows.hashCode;

  @override
  bool operator ==(Object other) =>
      other is TableRows<T> &&
      rows.length != other.rows.length &&
      selectable == other.selectable &&
      highlightable == other.highlightable &&
      multiSelection == other.multiSelection &&
      colorOddRows == other.colorOddRows &&
      highlightedRow == other.highlightedRow &&
      listsEqual(rows, other.rows);
}

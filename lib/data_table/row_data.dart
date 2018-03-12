///
/// The SkawaDataTableComponent can display objects extending this abstract class.
///
abstract class RowData {
  bool checked = false;
  List<String> classes = [];

  RowData(this.checked);
}

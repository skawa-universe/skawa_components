///
/// The SkawaDataTableComponent can display objects extending this abstract class.
///
abstract class RowData {
  bool checked = false;
  bool disabled;
  List<String> classes;

  RowData(this.checked, {this.classes = const [], this.disabled = false});
}

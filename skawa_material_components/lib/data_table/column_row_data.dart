class ColumnRowData<T> {
  final T rowData;

  final int columnIndex;

  final String header;

  final Map<String, dynamic> parameters;

  ColumnRowData(this.rowData, this.columnIndex, this.header, this.parameters);
}

import 'package:pageloader/pageloader.dart';

part 'data_table_po.g.dart';

@PageObject()
@CheckTag('test')
abstract class TestPO {
  TestPO();

  factory TestPO.create(PageLoaderElement context) = $TestPO.create;

  @ByTagName('skawa-data-table')
  DatatablePO get dataTable;
}

@PageObject()
abstract class DatatablePO {
  DatatablePO();

  factory DatatablePO.create(PageLoaderElement context) = $DatatablePO.create;

  @ByTagName('table')
  TablePO get table;
}

@PageObject()
abstract class TablePO {
  TablePO();

  factory TablePO.create(PageLoaderElement context) = $TablePO.create;

  @root
  PageLoaderElement get rootElement;

  @ByTagName('thead')
  TableHeaderSectionPO get thead;

  @ByTagName('tbody')
  TableSectionPO get tbody;

  @ByTagName('tfoot')
  TableSectionPO get tfoot;
}

@PageObject()
abstract class TableHeaderSectionPO {
  TableHeaderSectionPO();

  factory TableHeaderSectionPO.create(PageLoaderElement context) = $TableHeaderSectionPO.create;

  @ByTagName('tr')
  TableHeaderRowPO get tr;
}

@PageObject()
abstract class TableHeaderRowPO {
  TableHeaderRowPO();

  factory TableHeaderRowPO.create(PageLoaderElement context) = $TableHeaderRowPO.create;

  @ByTagName('th')
  List<TableHeaderCellPO> get th;
}

@PageObject()
abstract class TableSectionPO {
  TableSectionPO();

  factory TableSectionPO.create(PageLoaderElement context) = $TableSectionPO.create;

  @ByTagName('tr')
  List<TableRowPO> get tr;
}

@PageObject()
abstract class TableRowPO {
  TableRowPO();

  factory TableRowPO.create(PageLoaderElement context) = $TableRowPO.create;

  @root
  PageLoaderElement get rootElement;

  @ByTagName('td')
  List<TableCellPO> get td;
}

@PageObject()
abstract class TableCellPO {
  TableCellPO();

  factory TableCellPO.create(PageLoaderElement context) = $TableCellPO.create;

  @root
  PageLoaderElement get rootElement;

  @ByTagName('material-checkbox')
  PageLoaderElement get materialCheckbox;
}

@PageObject()
abstract class TableHeaderCellPO {
  TableHeaderCellPO();

  factory TableHeaderCellPO.create(PageLoaderElement context) = $TableHeaderCellPO.create;

  @root
  PageLoaderElement get rootElement;

  @ByTagName('material-checkbox')
  PageLoaderElement get materialCheckbox;

  @ByTagName('a')
  PageLoaderElement get sortLink;
}

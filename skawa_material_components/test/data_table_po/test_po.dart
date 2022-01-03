// @dart=2.10
import 'package:pageloader/pageloader.dart';

import 'data_table_po.dart';

part 'test_po.g.dart';

@PageObject()
@CheckTag('test')
abstract class TestPO {
  TestPO();

  factory TestPO.create(PageLoaderElement context) = $TestPO.create;

  @ByTagName('skawa-data-table')
  DatatablePO get dataTable;
}


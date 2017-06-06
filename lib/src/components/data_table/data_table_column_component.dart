import 'package:angular2/core.dart';
import 'row_data.dart';

typedef dynamic DataTableAccessor<T extends RowData>(T rowData);

@Component(
    selector: 'skawa-data-table-col',
    template: '',
    inputs: const ['accessor', 'header', 'footer', 'skipFooter'],
    changeDetection: ChangeDetectionStrategy.OnPush
)
class SkawaDataTableCol {

  DataTableAccessor accessor;

  String header;

  String footer;

  /// If set to true, footer will not display this column and
  /// colspan of td element will be set accordingly
  bool skipFooter = true;

  @Input('class')
  String classString;


  Iterable<String> getClasses([String suffix]) =>
      classString
          ?.trim()
          ?.split(' ')
          ?.map((className) => suffix != null ? '$className$suffix' : className);
}

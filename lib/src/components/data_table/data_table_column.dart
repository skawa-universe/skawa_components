import 'package:angular2/core.dart';
import 'row_data.dart';

typedef dynamic DataTableAccessor<T extends RowData>(T rowData);


/// A column of the [SkawaDataTableComponent]. Usable only with a [SkawaDataTableComponent].
///
/// __Example usage:__
///             <skawa-data-table [data]="rowData">
///                 <skawa-data-table-col [accessor]="someAccessor" header="Something" footer="All of Something:">
///                 </skawa-data-table-col>
///                 <skawa-data-table-col [accessor]="anotherAccessor" header="Something again" footer="All of Something again:">
///                 </skawa-data-table-col>
///              </skawa-data-table>
///
/// __Properties:__
/// - `accessor: bool` -- A function which return with the data to display in the cells.
/// - `header: String` -- Header name of the column to display.
/// - `footer: String` -- Footer name of the column to display.
/// - `skipFooter: bool` -- Whether to display the footer. Defaults to true.
///
@Component(
    selector: 'skawa-data-table-col',
    template: '',
    inputs: const ['accessor', 'header', 'footer', 'skipFooter'],
    changeDetection: ChangeDetectionStrategy.OnPush
)
class SkawaDataTableColComponent {

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

import 'package:angular2/core.dart';
import 'package:angular_components/src/model/ui/has_renderer.dart';
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
/// - `colRenderer: ComponentRenderer` -- component renderer function reference - if specified, accessor is ignored
/// - `header: String` -- Header name of the column to display.
/// - `footer: String` -- Footer name of the column to display.
/// - `skipFooter: bool` -- Whether to display the footer. Defaults to true.
///
/// __Notes:__
/// `ComponentRenderer` is part of `package:angular_components`. It can be used to customize how a column is
/// displayed allowing implementations to use custom components within the cell. Components must use `RendersValue`
/// mixin.
///
@Component(
    selector: 'skawa-data-table-col',
    template: '',
    directives: const [SkawaDataColRendererDirective],
    inputs: const ['accessor', 'header', 'footer', 'skipFooter'])
class SkawaDataTableColComponent {
  final SkawaDataColRendererDirective columnRenderer;

  DataTableAccessor accessor;

  String header;

  String footer;

  /// If set to true, footer will not display this column and
  /// colspan of td element will be set accordingly
  bool skipFooter = true;

  @Input('class')
  String classString;

  bool get useColumnRenderer => columnRenderer != null;

  SkawaDataTableColComponent(@Optional() @Self() this.columnRenderer);

  Iterable<String> getClasses([String suffix]) =>
      classString?.trim()?.split(' ')?.map((className) => suffix != null ? '$className$suffix' : className);
}

@Directive(selector: 'skawa-data-table-col[colRenderer]', //
    inputs: const ['componentRenderer: colRenderer'])
class SkawaDataColRendererDirective extends HasComponentRenderer<RendersValue, RowData> {}

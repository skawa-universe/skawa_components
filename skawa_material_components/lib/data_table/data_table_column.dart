import 'dart:async';

import 'package:angular/core.dart';
import 'package:angular_components/model/ui/has_factory.dart';
import 'package:angular_components/model/ui/has_renderer.dart';
import 'sort.dart';

export 'sort.dart';

/// A function signature for accessing a specific column value for a given row
typedef K DataTableAccessor<T, K>(T rowData);

/// A column of the SkawaDataTableComponent. Usable only with a SkawaDataTableComponent.
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
///
/// - `accessor: DataTableAccessor` -- A function which returns the data to display in cells.
/// - `colRenderer: ComponentRenderer` -- An optional component renderer function reference
/// - `header: String` -- Header name of the column to display.
/// - `footer: String` -- Footer name of the column to display.
/// - `skipFooter: bool` -- Whether to display the footer. Defaults to true.
///
/// __Outputs:__
///
/// - `trigger: T` -- Triggered when user clicks on text content of the cell.
///
/// __Notes:__
/// `ComponentRenderer` is part of `package:angular_components`. It can be used to customize how a column is
/// displayed allowing implementations to use custom components within the cell. Components must use `RendersValue`
/// mixin.
///
@Component(
    selector: 'skawa-data-table-col',
    template: '',
    providers: [ExistingProvider<SortEnabled>(SortEnabled, SkawaDataTableColComponent)],
    visibility: Visibility.all)
class SkawaDataTableColComponent<T, K>
    implements HasFactoryRenderer<RendersValue<K>, K>, SortEnabled, OnInit, OnDestroy {
  final StreamController<T> _triggerController = StreamController<T>.broadcast();

  @Input()
  DataTableAccessor<T, K> accessor;

  @Input()
  DataTableAccessor<T, K> titleAccessor;

  @Input()
  String header;

  @Input()
  String footer;

  @Input('colRenderer')
  FactoryRenderer<RendersValue<K>, K> factoryRenderer;

  SortModel sortModel;

  /// If set to true, footer will not display this column and
  /// colspan of td element will be set accordingly
  @Input()
  bool skipFooter = true;

  @Input('class')
  String classString;

  @Output('trigger')
  Stream<T> get onTrigger => _triggerController.stream;

  bool get useAccessorAsLink => _triggerController.hasListener;

  bool get useColumnRenderer => factoryRenderer != null;

  void trigger(T row) => _triggerController.add(row);

  Iterable<String> getClasses([String suffix]) =>
      classString?.trim()?.split(' ')?.map((className) => suffix != null ? '$className$suffix' : className);

  @override
  void ngOnDestroy() => _triggerController.close();

  @override
  void ngOnInit() {
    if (_triggerController.hasListener && useColumnRenderer) {
      throw ArgumentError('Cannot use [colRenderer] together with (trigger)');
    }
  }
}

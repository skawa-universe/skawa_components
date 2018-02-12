import 'dart:async';
import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular2/src/common/pipes/invalid_pipe_argument_exception.dart';
import 'package:angular_components/src/components/dynamic_component/dynamic_component.dart';
import 'package:angular_components/src/components/material_checkbox/material_checkbox.dart';
import 'package:angular_components/src/utils/disposer/disposer.dart';
import 'package:quiver/collection.dart';

import 'data_table_column.dart';
import 'row_data.dart';

export 'data_table_column.dart';
export 'row_data.dart';

/// Directive list for data tables
const List<Type> skawaDataTableDirectives = const <Type>[
  SkawaDataTableComponent,
  SkawaDataTableColComponent,
  SkawaDataColRendererDirective,
  SkawaDataTableSortDirective
];

/// A datatable component. A wrapper for the [SkawaDataTableColComponent].
/// [See more at](https://material.io/guidelines/components/data-tables.html#)
/// This data table component is designed on our expectations,
/// maybe need some modification for sortable, searchable, etc. table implementation.
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
/// - `selectable: bool` -- Whether to rows can be selectable.
/// - `data: Iterable<RowData>` -- The rows of the table can be displayed depend on this Iterable.
/// - `multiSelection: bool` -- Whether to allow multiSelection. Defaults to true
///
/// __Events:__
/// - `change: List<RowData>` -- Emitted when selection changes. If `selectable` is false, this event will never trigger.
/// - `highlight: RowData` -- Emitted when a row is highlighted. Note: highlighted rows are not automatically selected
/// - `sort: SkawaDataTableColComponent` -- Emitted when a sort was invoked on the given column.
///
@Component(
    selector: 'skawa-data-table',
    templateUrl: 'data_table.html',
    directives: const [MaterialCheckboxComponent, DynamicComponent, NgIf, NgClass, NgFor],
    pipes: const [UnskippedInFooterPipe],
    styleUrls: const ['data_table.css'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    preserveWhitespace: false)
class SkawaDataTableComponent implements OnDestroy, AfterViewInit {
  final ChangeDetectorRef changeDetectorRef;
  final StreamController<List<RowData>> _changeController = new StreamController<List<RowData>>.broadcast(sync: true);
  final StreamController<RowData> _highlightController = new StreamController<RowData>.broadcast(sync: true);
  final StreamController<SkawaDataTableColComponent> _sortController =
      new StreamController<SkawaDataTableColComponent>.broadcast(sync: true);

  final Disposer _tearDownDisposer = new Disposer.oneShot();
  @Input()
  bool selectable;

  @Input('data')
  Iterable<RowData> rows;

  @Input()
  bool multiSelection = true;

  @ContentChildren(SkawaDataTableColComponent)
  QueryList<SkawaDataTableColComponent> columns;

  @Output('change')
  Stream<List<RowData>> onChange;

  @Output('highlight')
  Stream<RowData> get onHighlight => _highlightController.stream;

  @Output('sort')
  Stream<SkawaDataTableColComponent> get onSort => _sortController.stream;

  RowData highlightedRow;

  SkawaDataTableComponent(this.changeDetectorRef) {
    _tearDownDisposer
      ..addEventSink(_changeController)
      ..addEventSink(_highlightController)
      ..addEventSink(_sortController);
    onChange = _changeController.stream.distinct((a, b) {
      return a == b || (listsEqual(a, b) && _areOfSameCheckedState(a, b));
    });
  }

  int getColspanFor(SkawaDataTableColComponent col, int skippedIndex) {
    int span = 1;
    if (skippedIndex == 0 && selectable) return 2;
    int colIndex = columns.toList().indexOf(col);
    for (int i = colIndex; i >= 0; i--) {
      int prevIndex = i - 1;
      if (prevIndex < 0) break;
      var prevCol = columns.elementAt(prevIndex);
      if (prevCol.skipFooter) {
        ++span;
      } else {
        break;
      }
    }
    return span;
  }

  void changeRowSelection(RowData row, bool selected) {
    if (!multiSelection) {
      rows.firstWhere((r) => r.checked, orElse: () => null)?.checked = !selected;
    }
    row.checked = selected;
    _emitChange();
  }

  void markAllRowsChecked(bool checked, [bool emit = false]) {
    rows.forEach((row) => row.checked = checked);
    if (emit) _emitChange();
  }

  void highlight(RowData row, Event ev) {
    bool canHighlight = _canHighlight(ev);
    if (canHighlight) {
      highlightedRow = row;
      _highlightController.add(row);
    }
  }

  bool _canHighlight(Event ev) {
    if (selectable && ev.target is Element && ev.target != ev.currentTarget) {
      Element target = ev.target as Element;
      if (target is Element) {
        while (target != ev.currentTarget && target.tagName != 'TR' && target != null) {
          if (target.classes.contains('selector-checkbox')) {
            return false;
          }
          target = target.parent;
        }
      }
    }
    return true;
  }

  void triggerSort(SkawaDataTableColComponent column) {
    column.sortModel.toggleSort();
    for (var c in columns) {
      if (c != column && c.sortModel != null) {
        c.sortModel.activeSort = null;
      }
    }
    _sortController.add(column);
  }

  void _emitChange() {
    var _selectedRows = rows.where((r) => r.checked).toList(growable: false);
    _changeController.add(_selectedRows);
  }

  bool get isEveryRowChecked => rows.every((row) => row.checked);

  bool get isEveryRowSkippedInFooter => columns.every((col) => col.skipFooter);

  @override
  ngOnDestroy() {
    _tearDownDisposer.dispose();
  }

  static bool _areOfSameCheckedState(List<RowData> a, List<RowData> b) {
    for (int i = 0; i < a.length; ++i) {
      if (a[i].checked != b[i].checked) return false;
    }
    return true;
  }

  @override
  ngAfterViewInit() {
    var initialSorts = columns.where((c) => c.sortModel?.activeSort != null).toList(growable: false);
    if (initialSorts.length > 1) {
      throw new ArgumentError(
          'Initial sort can only be set on one column at most, found ${initialSorts.length} columns');
    }
  }
}

/// Filters for those [SkawaDataTableColComponent]s, that are not skipped in footer
///
/// Can set a column skipped by setting [skipFooter] to true
@Pipe('unskippedInFooter')
class UnskippedInFooterPipe implements PipeTransform {
  Iterable transform(Iterable data) {
    if (data is! Iterable) {
      throw new InvalidPipeArgumentException(UnskippedInFooterPipe, data);
    }
    return data.where((d) => d.skipFooter != true).toList();
  }
}

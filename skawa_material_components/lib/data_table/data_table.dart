import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular/src/common/pipes/invalid_pipe_argument_exception.dart';
import 'package:angular_components/dynamic_component/dynamic_component.dart';
import 'package:angular_components/material_checkbox/material_checkbox.dart';
import 'package:angular_components/utils/disposer/disposer.dart';
import 'package:quiver/collection.dart';

import 'data_table_column.dart';
import 'table_row.dart';

export 'data_table_column.dart';
export 'table_row.dart';

/// Directive list for data tables
const List<Type> skawaDataTableDirectives = const <Type>[
  SkawaDataTableComponent,
  SkawaDataTableColComponent
];

/// A datatable component. A wrapper for the [SkawaDataTableColComponent].
/// [See more at](https://material.io/guidelines/components/data-tables.html#)
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
/// - `selectable: bool` -- Whether the rows can be selectable.
/// - `data: Iterable<T>` -- The rows of the table can be displayed depend on this Iterable.
/// - `multiSelection: bool` -- Whether to allow multiSelection. Defaults to true
///
/// __Events:__
/// - `change: List<T>` -- Emitted when selection changes. If `selectable` is false, this event will never trigger.
/// - `highlight: T` -- Emitted when a row is highlighted. Note: highlighted rows are not automatically selected
/// - `sort: SkawaDataTableColComponent` -- Emitted when a sort was invoked on the given column.
///
@Component(
    selector: 'skawa-data-table',
    templateUrl: 'data_table.html',
    styleUrls: ['data_table.css'],
    directives: [MaterialCheckboxComponent, DynamicComponent, NgIf, NgClass, NgFor],
    pipes: [UnskippedInFooterPipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    visibility: Visibility.all)
class SkawaDataTableComponent<T> implements OnDestroy, AfterViewInit {
  final StreamController<List<T>> _changeController = StreamController<List<T>>.broadcast(sync: true);
  final StreamController<T> _highlightController = StreamController<T>.broadcast(sync: true);
  final Disposer _tearDownDisposer = Disposer.oneShot();
  final ChangeDetectorRef changeDetectorRef;

  @Input()
  TableRows<T> data;

  @ContentChildren(SkawaDataTableColComponent)
  List<SkawaDataTableColComponent<T, dynamic>> columns;

  @Output('change')
  Stream<List<T>> onChange;

  SkawaDataTableComponent(this.changeDetectorRef) {
    _tearDownDisposer..addEventSink(_changeController)..addEventSink(_highlightController);
    onChange = _changeController.stream.distinct((a, b) => a == b || (listsEqual(a, b)));
  }

  @Output('highlight')
  Stream<T> get onHighlight => _highlightController.stream;

  int getColspanFor(SkawaDataTableColComponent<T, dynamic> col, int skippedIndex) {
    int span = 1;
    if (skippedIndex == 0 && data.selectable) return 2;
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

  void changeRowSelection(TableRow<T> row, bool selected) {
    if (!data.multiSelection) {
      data.rows.firstWhere((r) => r.checked, orElse: () => null)?.checked = !selected;
    }
    row.checked = selected;
    _emitChange();
  }

  void markAllRowsChecked(bool checked, [bool emit = false]) {
    data.rows.forEach((row) => row.checked = checked);
    if (emit) _emitChange();
  }

  void highlight(TableRow<T> row, Event ev) {
    bool canHighlight = _canHighlight(ev);
    if (canHighlight) {
      data.highlightedRow = row != data.highlightedRow ? row : null;
      if (!_highlightController.isClosed) _highlightController.add(data.highlightedRow?.data);
    }
  }

  bool _canHighlight(Event ev) {
    if (!data.highlightable) return false;
    if (data.selectable && ev.target is Element && ev.target != ev.currentTarget) {
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
    var _column = column as SkawaDataTableColComponent<T, dynamic>;
    _column.sortModel.toggleSort();
    for (var c in columns) {
      if (c != _column && c.sortModel != null) {
        c.sortModel.activeSort = null;
      }
    }
    data.sort((TableRow<T> a, TableRow<T> b) => _column.sortModel.sort(a, b, _column.sortModel.activeSort));
  }

  void _emitChange() {
    List<T> _selectedRows =
        data.rows.where((r) => r.checked).map((TableRow<T> row) => row.data).toList(growable: false);
    _changeController.add(_selectedRows);
  }

  bool get isEveryRowChecked => data?.rows?.every((row) => row.checked) ?? false;

  bool get isEveryRowSkippedInFooter => columns?.every((col) => col.skipFooter) ?? true;

  @override
  void ngAfterViewInit() {
    var initialSorts = columns?.where((c) => c.sortModel?.activeSort != null)?.toList(growable: false) ?? [];
    if (initialSorts.length > 1) {
      throw new ArgumentError(
          'Initial sort can only be set on one column at most, found ${initialSorts.length} columns');
    }
  }

  @override
  void ngOnDestroy() => _tearDownDisposer.dispose();
}

/// Filters for those SkawaDataTableColComponents, that are not skipped in footer
///
/// Can set a column skipped by setting skipFooter to true
@Pipe('unskippedInFooter')
class UnskippedInFooterPipe implements PipeTransform {
  List<SkawaDataTableColComponent> transform(List<SkawaDataTableColComponent> data) {
    if (data is! List) {
      throw new InvalidPipeArgumentException(UnskippedInFooterPipe, data);
    }
    return data.where((d) => d.skipFooter != true).toList();
  }
}

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular/src/common/pipes/invalid_pipe_argument_exception.dart';
import 'package:angular_components/dynamic_component/dynamic_component.dart';
import 'package:angular_components/material_checkbox/material_checkbox.dart';
import 'package:angular_components/utils/disposer/disposer.dart';
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
    styleUrls: ['data_table.css'],
    directives: [MaterialCheckboxComponent, DynamicComponent, NgIf, NgClass, NgFor],
    pipes: [UnskippedInFooterPipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    visibility: Visibility.all)
class SkawaDataTableComponent<T extends RowData> implements OnDestroy, AfterViewInit {
  final StreamController<List<T>> _changeController = StreamController<List<T>>.broadcast(sync: true);
  final StreamController<T> _highlightController = StreamController<T>.broadcast(sync: true);
  final StreamController<SkawaDataTableColComponent<T>> _sortController =
      StreamController<SkawaDataTableColComponent<T>>.broadcast(sync: true);
  final Disposer _tearDownDisposer = Disposer.oneShot();
  final ChangeDetectorRef changeDetectorRef;

  @Input()
  bool selectable = false;

  @Input()
  bool highlightable = true;

  @Input('data')
  Iterable<T> rows = [];

  @Input()
  T highlightedRow;

  @Input()
  bool multiSelection = true;

  @Input()
  bool colorOddRows = true;

  @ContentChildren(SkawaDataTableColComponent)
  List<SkawaDataTableColComponent<T>> columns;

  @Output('change')
  Stream<List<T>> onChange;

  SkawaDataTableComponent(this.changeDetectorRef) {
    _tearDownDisposer
      ..addEventSink(_changeController)
      ..addEventSink(_highlightController)
      ..addEventSink(_sortController);
    onChange =
        _changeController.stream.distinct((a, b) => a == b || (listsEqual(a, b) && _areOfSameCheckedState(a, b)));
  }

  @Output('highlight')
  Stream<T> get onHighlight => _highlightController.stream;

  @Output('sort')
  Stream<SkawaDataTableColComponent<T>> get onSort => _sortController.stream;

  bool get markAllDisabled => rows.every((r) => r.disabled);

  int getColspanFor(SkawaDataTableColComponent<T> col, int skippedIndex) {
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

  void changeRowSelection(T row, bool selected) {
    if (!multiSelection) {
      rows.firstWhere((r) => r.checked, orElse: () => null)?.checked = !selected;
    }
    row.checked = selected;
    _emitChange();
  }

  void markAllRowsChecked(bool checked, Event event) {
    rows.forEach((row) {
      if (!row.disabled) row.checked = checked;
    });
    _emitChange();
    event.stopPropagation();
  }

  void highlight(T row, Event ev) {
    ev.stopPropagation();
    bool canHighlight = _canHighlight(ev);
    if (canHighlight) {
      highlightedRow = row != highlightedRow ? row : null;
      if (!_highlightController.isClosed) _highlightController.add(highlightedRow);
    }
  }

  bool _canHighlight(Event ev) {
    if (!highlightable) return false;
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

  void triggerCell(SkawaDataTableColComponent c, RowData row, Event event) {
    c.trigger(row);
    event.preventDefault();
    event.stopPropagation();
  }

  void triggerSort(SkawaDataTableColComponent column) {
    var _column = column as SkawaDataTableColComponent<T>;
    _column.sortModel.toggleSort();
    for (var c in columns) {
      if (c != _column && c.sortModel != null) {
        c.sortModel.activeSort = null;
      }
    }
    _sortController.add(_column);
  }

  void _emitChange() {
    var _selectedRows = rows.where((r) => r.checked).toList(growable: false);
    _changeController.add(_selectedRows);
  }

  bool get isEveryRowChecked => rows?.every((row) => row.checked);

  bool get isEveryRowSkippedInFooter => columns?.every((col) => col.skipFooter) ?? true;

  @override
  void ngOnDestroy() {
    _tearDownDisposer.dispose();
  }

  bool _areOfSameCheckedState(List<T> a, List<T> b) {
    for (int i = 0; i < a.length; ++i) {
      if (a[i].checked != b[i].checked) return false;
    }
    return true;
  }

  @override
  void ngAfterViewInit() {
    var initialSorts = columns?.where((c) => c.sortModel?.activeSort != null)?.toList(growable: false) ?? [];
    if (initialSorts.length > 1) {
      throw ArgumentError('Initial sort can only be set on one column at most, found ${initialSorts.length} columns');
    }
  }
}

/// Filters for those SkawaDataTableColComponents, that are not skipped in footer
///
/// Can set a column skipped by setting skipFooter to true
@Pipe('unskippedInFooter')
class UnskippedInFooterPipe implements PipeTransform {
  List<SkawaDataTableColComponent> transform(List<SkawaDataTableColComponent> data) {
    if (data is! List) {
      throw InvalidPipeArgumentException(UnskippedInFooterPipe, data);
    }
    return data.where((d) => d.skipFooter != true).toList();
  }
}

import 'package:angular/angular.dart';
import 'data_table_column.dart';

enum SortDirection { asc, desc }

class SortModel {
  final List<SortDirection> allowedDirections;

  SortDirection activeSort;

  SortModel(this.allowedDirections);

  void toggleSort() {
    if (((allowedDirections ?? const [])).isEmpty) {
      throw ArgumentError('SortModel does not have any allowed sort directions');
    }
    if (activeSort == null) {
      activeSort = allowedDirections.first;
    } else {
      int directionIndex = allowedDirections.indexOf(activeSort);
      if (directionIndex == allowedDirections.length - 1) {
        activeSort = null;
      } else {
        activeSort = allowedDirections[directionIndex + 1];
      }
    }
  }

  bool get isAscending => activeSort == SortDirection.asc;

  bool get isDescending => activeSort == SortDirection.desc;

  bool get isSorted => activeSort != null;
}

@Directive(selector: '[sortable]')
class SkawaDataTableSortDirective {
  final SkawaDataTableColComponent column;

  SkawaDataTableSortDirective(this.column);

  @Input('sortable')
  set allowedSorts(String allowedSorts) {
    List<String> directions;
    if ((allowedSorts ?? '').isNotEmpty) {
      directions = allowedSorts.split(',').map((s) => s.trim()).toList(growable: false);
    } else {
      directions = directionMap.keys.toList(growable: false);
    }
    if (directions.isEmpty || directions.any((s) => directionMap[s] == null)) {
      throw ArgumentError(
          'SkawaDataTableSortDirective accepts only "asc" and/or "desc" as sort directions. Use comma separated values for both directions.');
    }
    column.sortModel = SortModel(directions.map((s) => directionMap[s]).toList(growable: false));
  }

  @Input()
  set initialSort(String sort) {
    if (directionMap[sort] == null) {
      throw ArgumentError('SkawaDataTableSortDirective initial sort value can only be "asc" or "desc"');
    }
    column.sortModel.activeSort = directionMap[sort];
  }

  static const String asc = 'asc';
  static const String desc = 'desc';

  static const Map<String, SortDirection> directionMap = const {asc: SortDirection.asc, desc: SortDirection.desc};
}

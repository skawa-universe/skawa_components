import 'package:angular/angular.dart';

enum SortDirection { asc, desc }

abstract class SortEnabled {
  SortModel sortModel;
}

class SortModel {
  final List<SortDirection> allowedDirections;

  SortDirection activeSort;

  SortModel(this.allowedDirections);

  void toggleSort() {
    if (((allowedDirections ?? const [])).isEmpty) {
      throw new ArgumentError('SortModel does not have any allowed sort directions');
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

/// Adds sorting capabilities to any host component implementing the [SortEnabled] interface
/// One example would be the SkawaDataTableColComponent
@Directive(selector: '[sortable]')
class SortDirective {
  final SortEnabled sortEnabledHost;

  SortDirective(@Host() this.sortEnabledHost);

  @HostBinding('class.sort-enabled')
  bool get sortEnabled => sortEnabledHost.sortModel != null && !sortEnabledHost.sortModel.isSorted;

  @HostBinding('class.sort')
  bool get isSorted => sortEnabledHost.sortModel?.isSorted ?? false;

  @HostBinding('class.desc')
  bool get isDescending => sortEnabledHost.sortModel?.isDescending ?? false;

  @Input('sortable')
  set allowedSorts(String allowedSorts) {
    List<String> directions;
    if ((allowedSorts ?? '').isNotEmpty) {
      directions = allowedSorts.split(',').map((s) => s.trim()).toList(growable: false);
    } else {
      directions = directionMap.keys.toList(growable: false);
    }
    if (directions.isEmpty || directions.any((s) => directionMap[s] == null)) {
      throw new ArgumentError(
          'SkawaDataTableSortDirective accepts only "asc" and/or "desc" as sort directions. Use comma separated values for both directions.');
    }
    sortEnabledHost.sortModel = SortModel(directions.map((s) => directionMap[s]).toList(growable: false));
  }

  @Input()
  set initialSort(String sort) {
    if (directionMap[sort] == null) {
      throw ArgumentError('SkawaDataTableSortDirective initial sort value can only be "asc" or "desc"');
    }
    sortEnabledHost.sortModel.activeSort = directionMap[sort];
  }

  static const String asc = 'asc';
  static const String desc = 'desc';

  static const Map<String, SortDirection> directionMap = const {asc: SortDirection.asc, desc: SortDirection.desc};
}

enum SortDirection {
  asc,
  desc
}

enum SortStrategy {
  local,
  remote
}

class SortConfig {

  final List<SortDirection> allowedDirections;
  SortStrategy strategy;

  SortDirection sort;

  SortConfig.local()
      : allowedDirections = const[SortDirection.asc, SortDirection.desc],
        strategy = SortStrategy.local;

  SortConfig.remote()
      : allowedDirections = const[SortDirection.asc, SortDirection.desc],
        strategy = SortStrategy.remote;

  bool get isAscending => sort == SortDirection.asc;

  bool get isDescending => sort == SortDirection.desc;

  bool get isSorted => sort != null;

}
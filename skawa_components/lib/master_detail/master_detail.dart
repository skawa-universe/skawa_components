import 'package:angular/core.dart';

import '../util/attribute.dart' as attr_util;

/// Master-detail component.
///
/// __Example__:
///
///     <skawa-master-detail expanded>
///       <span skawa-master>
///         Hello
///       </span>
///       <span skawa-detail>
///         world
///       </span>
///     </skawa-master-detail>
///
/// __Properties__:
///
/// - `expanded: bool` -- Whether details should be shown.
///
@Component(
    selector: 'skawa-master-detail',
    templateUrl: 'master_detail.html',
    styleUrls: ['master_detail.css'],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaMasterDetailComponent {
  SkawaMasterDetailComponent(@Optional() @Attribute('expanded') String expanded)
      : expanded = attr_util.isPresent(expanded);

  /// Expands/collapses the details view
  ///
  /// Instead of setting this property one can use [expand]
  /// and [collapse] methods.
  bool expanded;

  @HostBinding('attr.expanded')
  String get isExpanded => expanded ? "" : null;

  void expand() => expanded = true;

  void collapse() => expanded = false;

  void toggle() => expanded = !expanded;
}

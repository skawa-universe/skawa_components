import 'package:angular2/core.dart';

import '../../util/attribute.dart' as attr_util;

/// Master-detail component.
///
/// __Properties__:
///
/// - `expanded: bool` -- whether details should be shown
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
@Component(
    selector: 'skawa-master-detail',
    templateUrl: 'master_detail.html',
    styleUrls: const ['master_detail.css'],
    host: const {
      '[attr.expanded]': 'expanded ? "" : null'
    },
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaMasterDetailComponent {

  SkawaMasterDetailComponent(@Optional() @Attribute('expanded') expanded)
      : expanded = attr_util.isPresent(expanded);

  /// Expands/collapses the details view
  ///
  /// Instead of setting this property one can use [expand]
  /// and [collapse] methods.
  bool expanded;

  void expand() {
    expanded = true;
  }

  void collapse() {
    expanded = false;
  }

  void toggle() {
    expanded = !expanded;
  }
}

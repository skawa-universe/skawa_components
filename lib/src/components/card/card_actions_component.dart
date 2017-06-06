import 'package:angular2/core.dart';

import 'card_component.dart';

/// Card section containing actions
///
/// __Inputs:__
///
///  - `align-left`: aligns content elements to the right
///  - `align-right`: align content elements to the left
///
/// __Example:__
///
///     <skawa-card-actions>
///       <material-button icon>
///         <glyph icon="android"></glyph>
///       </material-button>
///     </skawa-card-actions>
@Component(
  selector: 'skawa-card-actions',
  template: '<ng-content></ng-content>',
  styleUrls: const ['card_actions_component.css'],
  changeDetection: ChangeDetectionStrategy.OnPush
)
class SkawaCardActionsComponent {

  /// Header component actions were embedded in
  final SkawaCardHeaderComponent cardHeader;

  /// Whether this component is in a card header or not
  @HostBinding('class.in-header')
  bool get inHeader => cardHeader != null;

  SkawaCardActionsComponent(@Optional() this.cardHeader);
}
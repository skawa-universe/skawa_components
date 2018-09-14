import 'package:angular/core.dart';

import 'card.dart';

/// Card section containing actions. Should be used only inside a [SkawaCardComponent].
///
/// __Example:__
///
///     <skawa-card>
///        <skawa-card-actions>
///          <material-button icon>
///            <material-icon icon="android"></material-icon>
///          </material-button>
///        </skawa-card-actions>
///     </skawa-card>
///
/// __Inputs:__
///
///  - `align-left`: Align content elements to the right.
///  - `align-right`: Align content elements to the left.
///
@Component(
    selector: 'skawa-card-actions',
    template: '<ng-content></ng-content>',
    styleUrls: ['card_actions.css'],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaCardActionsComponent {
  /// Header component actions were embedded in
  final SkawaCardHeaderComponent cardHeader;

  SkawaCardActionsComponent(@Optional() this.cardHeader);

  /// Whether this component is in a card header or not
  @HostBinding('class.in-header')
  bool get inHeader => cardHeader != null;
}

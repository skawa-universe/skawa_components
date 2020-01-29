import 'package:angular/core.dart';

import '../util/attribute.dart' as attr_util;
import 'card_actions.dart';
import 'card_directives.dart';

export 'card.dart';
export 'card_actions.dart';
export 'card_directives.dart';

const List<Type> skawaCardDirectives = [
  SkawaCardHeaderComponent,
  SkawaCardHeaderSubheadDirective,
  SkawaCardHeaderTitleDirective,
  SkawaCardHeaderImageDirective,
  SkawaCardContentComponent,
  SkawaCardActionsComponent,
  SkawaCardComponent
];

/// A card component. [See more at](https://material.io/guidelines/components/cards.html)
///
/// __Example:__
///
///     <skawa-card>
///       Some content.
///     </skawa-card>
///
/// __Inputs__:
///   - `no-shadow`: Will not add default shadow.
///
@Component(
    selector: 'skawa-card', template: '<ng-content></ng-content>', styleUrls: ['card.css'], visibility: Visibility.all)
class SkawaCardComponent {
  @ContentChild(SkawaCardHeaderComponent)
  SkawaCardHeaderComponent cardHeader;

  @ContentChild(SkawaCardContentComponent)
  SkawaCardContentComponent cardContent;

  bool get hasHeader => cardHeader != null;
}

/// Content area for cards
///
/// __Example:__
///
///     <skawa-card-content collapsed>
///         Some content that is collapsed by default.
///     </skawa-card-content>
///
/// __Inputs:__
///   - `collapsed: bool` -- Initial state of the component will be collapsed.
///
/// __Properties:__
///
/// - `fullWidth` -- removes padding for card content
///
@Component(
    selector: 'skawa-card-content',
    exportAs: 'cardcontent',
    template: '<ng-content></ng-content>',
    styleUrls: ['card_content.css'],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaCardContentComponent {
  final SkawaCardComponent parentCard;

  SkawaCardContentComponent(this.parentCard);

  @HostBinding('class.with-header')
  bool get withHeader => parentCard.hasHeader;

  @Input()
  bool collapsed;

  @HostBinding('class.skawa-collapsed')
  bool get isCollapsed => attr_util.isPresent(collapsed);

  /// Toggle collapsed state content area
  void toggle() {
    collapsed = attr_util.toggleAttribute(collapsed);
  }
}

/// Header component for a [SkawaCardComponent].
///
/// __Example:__
///
///     <skawa-card>
///       <skawa-card-header statusColor="rgb(255,0,0)">
///       </skawa-card-header>
///     </skawa-card>
///
/// __Inputs:__
///   - `statusColor: String` -- The color of the box-shadow-top. Accept only rgb() or rgba() formats. Defaults to transparent.
///
@Component(
    selector: 'skawa-card-header',
    template: '<ng-content></ng-content>',
    styleUrls: ['card_header.css'],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaCardHeaderComponent {
  @ContentChild(SkawaCardHeaderTitleDirective)
  SkawaCardHeaderTitleDirective title;

  @ContentChild(SkawaCardHeaderSubheadDirective)
  SkawaCardHeaderSubheadDirective subhead;

  @ContentChild(SkawaCardHeaderImageDirective)
  SkawaCardHeaderImageDirective image;

  @ContentChild(SkawaCardActionsComponent)
  SkawaCardActionsComponent headerActions;

  @HostBinding('class.with-title-image')
  bool get withTitleImage => image != null;

  @HostBinding('class.with-subhead')
  bool get withSubHead => subhead != null;

  @HostBinding('class.with-actions')
  bool get hasActions => headerActions != null;

  /// Status color for the card
  ///
  /// Must be provided in rgb() or rgba() format, hex values are
  /// not picked up.
  @Input()
  String statusColor = 'transparent';

  @HostBinding('style.box-shadow')
  String get statusStyle {
    // if set to null remove styling
    if (statusColor == null) {
      return null;
    }
    // if matches rgb() or rgba() format, use it
    if (_rgbaRegexp.hasMatch(statusColor)) {
      return 'inset 0 4px 0 0 $statusColor';
    }
    return null;
  }

  static final RegExp _rgbaRegexp = RegExp(r'rgba?\s*\((?:\d+(?:\.[\d]+)?,?\s*){3,4}\)');
}

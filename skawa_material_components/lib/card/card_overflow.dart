import 'dart:html';

import 'package:angular/angular.dart';

/// A directive which can be used to hide the overflow with a linear gradient foreground.
/// Need to include `@import "package:skawa_material_components/card/card_overflow";`
/// to your css file to work this directive (also include the corresponding csss mixin).

@Directive(selector: '[cardOverflow]', exportAs: 'cardOverflow')
class CardOverflowDirective {
  final HtmlElement _htmlElement;

  CardOverflowDirective(this._htmlElement);

  @Input('fullCard')
  bool fullCard = false;

  @Input('contentLoaded')
  bool contentLoaded = false;

  bool get hasOverflow => _htmlElement.clientHeight < _htmlElement.scrollHeight;

  @HostBinding('class.card-overflowed')
  bool get excerptHasOverflow => !fullCard && hasOverflow;

  @HostBinding('class.card-overflowed-full-card')
  bool get fullCardHasOverflow => fullCard && hasOverflow && contentLoaded;
}

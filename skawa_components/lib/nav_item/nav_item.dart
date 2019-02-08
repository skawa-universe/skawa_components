import 'dart:html';

import 'package:angular/angular.dart';

import 'package:angular_components/button_decorator/button_decorator.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_button/material_button_base.dart';
import 'package:angular_components/material_ripple/material_ripple.dart';

import '../sidebar_item/sidebar_item.dart';

/// Component compositing [SkawaSidebarItemComponent] and [MaterialButtonBase]
///
/// A Toolbar item that is also a button. Only a small subset of Material
/// Buttons features are exposed.
///
/// Most properties, events and attributes are the same as [MaterialButtonComponent]'s.
/// Please see it's documentation for general options.
///
/// __Example usage:__
///     <skawa-nav-item [link]="'http://google.com'">Nav text</skawa-nav-item>
///     <skawa-nav-item [icon]="'home'">Nav item with icon</skawa-nav-item>
///     <skawa-nav-item [icon]="'home'" (trigger)="doSomething()">Event</skawa-nav-item>
///
/// __Properties:__
/// - `link: String` -- Link to navigate to when clicked. Defaults to nothing, no action will happen.
/// - `icon: String` -- Icon name to display.
///
/// __Events:__
/// - `trigger: Event` -- Published when the nav item is activated with click
///   or keypress.
///
/// __Attributes:__
/// - `textOnly` -- If present, `icon` will be ignored and it's place removed.
///
@Component(
    selector: 'skawa-nav-item',
    templateUrl: 'nav_item.html',
    styleUrls: ['nav_item.css'],
    directives: [SkawaSidebarItemComponent, MaterialRippleComponent, NgClass],
    changeDetection: ChangeDetectionStrategy.OnPush,
    providers: [Provider(ButtonDirective, useExisting: SkawaNavItemComponent)])
class SkawaNavItemComponent extends MaterialButtonBase with TextOnlyMixin {
  /// Link to navigate to
  @Input()
  String link;

  /// MaterialIcon name to use as icon
  @Input()
  String icon;

  bool hovering = false;

  @HostBinding('attr.fullWidth')
  @Input()
  bool fullWidth;

  final ChangeDetectorRef _changeDetector;

  SkawaNavItemComponent(HtmlElement element, this._changeDetector, @Attribute('role') String role)
      : super(element, role);

  @override
  void focusedStateChanged() {
    _changeDetector.markForCheck();
  }

  @HostListener('mouseenter')
  void onMouseEnter() {
    hovering = true;
  }

  @HostListener('mouseout')
  void onMouseOut() {
    hovering = false;
  }
}

import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';

import 'package:angular_components/glyph/glyph.dart';
import 'package:angular_components/material_button/material_button.dart';

/// Appbar component. [See more at](https://material.io/guidelines/layout/structure.html#structure-app-bar)
///
/// __Example usage:__
///     <skawa-appbar></skawa-appbar>
///     <skawa-appbar [showNavToggle]="appbarState"></skawa-appbar>
///     <skawa-appbar>Appbar with some content</skawa-appbar>
///
/// __Events:__
/// - `navToggle: MouseEvent` -- Triggered when nav button is pressed.
///
/// __Properties:__
/// - `showNavToggle: bool` -- Whether to display nav toggle. Defaults to true.
///
@Component(
    selector: 'skawa-appbar',
    templateUrl: 'appbar.html',
    styleUrls: const ['appbar.css'],
    directives: const [MaterialButtonComponent, GlyphComponent, NgIf])
class SkawaAppbarComponent implements OnDestroy {
  StreamController _navToggleController = new StreamController<MouseEvent>.broadcast();

  @Input()
  bool showNavToggle = true;

  @Output()
  Stream get navToggle => _navToggleController.stream;

  void toggleNav(MouseEvent ev) {
    _navToggleController.add(ev);
  }

  @override
  void ngOnDestroy() {
    _navToggleController.close();
  }
}

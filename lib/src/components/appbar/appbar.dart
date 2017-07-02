import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';

import 'package:angular_components/src/components/glyph/glyph.dart';
import 'package:angular_components/src/components/material_button/material_button.dart';

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
    styleUrls: const [
      'appbar.css'
    ],
    inputs: const [
      'showNavToggle'
    ],
    outputs: const [
      'navToggle'
    ],
    directives: const [
      MaterialButtonComponent,
      GlyphComponent,
      NgIf,
    ])
class SkawaAppbarComponent implements OnDestroy {
  StreamController _navToggleController =
      new StreamController<MouseEvent>.broadcast();

  Stream get navToggle => _navToggleController.stream;

  bool showNavToggle = true;

  void toggleNav(MouseEvent ev) {
    _navToggleController.add(ev);
  }

  @override
  ngOnDestroy() {
    _navToggleController.close();
  }
}

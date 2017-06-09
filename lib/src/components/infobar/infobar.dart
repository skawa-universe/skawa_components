import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular_components/src/components/glyph/glyph.dart';
import 'package:angular_components/src/components/material_button/material_button.dart';
import 'package:angular_components/src/utils/async/async.dart' show LazyEventEmitter;

///
/// __Inputs__:
///
///   - `icon`: icon to display in the infobar
///   - `url`: url to navigate the user to when icon is triggered
///
/// __Events:__
///
/// - `trigger: Event` -- Published when the `icon` is triggered.
@Component(
    selector: 'skawa-infobar',
    templateUrl: 'infobar.html',
    styleUrls: const ['infobar.css'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    directives: const [GlyphComponent, MaterialButtonComponent],
    inputs: const ['icon', 'url'],
    outputs: const ['trigger']
)
class SkawaInfobarComponent {

  // TODO: dismiss

  String icon;

  String url;

  @ViewChild('primaryAction')
  MaterialButtonComponent primaryActionButton;

  LazyEventEmitter<UIEvent> get trigger => primaryActionButton.trigger;

  void navigate() {
    if (url != null)
      window.location.href = url;
  }
}
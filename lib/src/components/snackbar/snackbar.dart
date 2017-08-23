import 'dart:async';
import 'dart:collection';
import 'dart:html';
import 'dart:math';
import 'package:angular2/angular2.dart';
import 'package:angular_components/src/components/material_button/material_button.dart';
import 'package:angular_components/src/laminate/components/popup/popup.dart';
import 'package:angular_components/src/laminate/enums/alignment.dart';
import 'package:angular_components/src/laminate/popup/module.dart';
import 'package:angular_components/src/laminate/popup/src/popup_size_provider.dart';
import 'package:angular_components/src/laminate/popup/src/popup_source.dart';
import 'package:angular_components/src/utils/angular/properties/properties.dart';
import 'package:angular_components/src/utils/disposer/disposer.dart';

@Injectable()
class DocumentPopupSource extends ElementPopupSource {
  final NgZone _zone;

  DocumentPopupSource(this._zone);

  @override
  final Alignment alignOriginX = Alignment.Start;

  @override
  final Alignment alignOriginY = Alignment.End;

  @override
  bool get isRtl => false;

  @override
  Stream<Rectangle<num>> onDimensionsChanged({bool track: false}) {
    // TODO: track is currently ignored... yield* for window.resize?
    ;
    return new Stream<Rectangle<num>>.fromIterable([
      _zone.runOutsideAngular(() {
        return document.body.getBoundingClientRect();
      })
    ]);
  }

  @override
  ElementRef get sourceElement => new ElementRef(document.body);
}

///
/// __Inputs:__
///
/// - `actionLabel: String` -- label to display on action button. If not set, button won't be displayed
/// - `visible` -- display or hide snackbar
///
/// __Outputs:__
///
/// - `trigger: Event` -- action button is pressed
@Component(
    selector: 'skawa-snackbar',
    templateUrl: 'snackbar.html',
    styleUrls: const ['snackbar.css'],
    directives: const [PopupComponent, MaterialButtonComponent, NgIf, NgClass],
    providers: const [
      const Provider(PopupSource, useClass: DocumentPopupSource),
      const Provider(PopupSizeProvider, useFactory: sizeProviderFactory)
    ],
    preserveWhitespace: false,
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaSnackbarComponent implements OnDestroy {
  final PopupSource documentSource;
  final StreamController<Event> _triggerController = new StreamController<Event>.broadcast(sync: true);
  final StreamController<bool> _toggleController = new StreamController<bool>.broadcast(sync: true);
  final Disposer _disposer = new Disposer.oneShot();
  final ChangeDetectorRef _cd;

  SkawaSnackbarComponent(this.documentSource, this._cd) {
    _disposer..addEventSink(_toggleController)..addEventSink(_triggerController);
  }

  @Input()
  String actionLabel;

  @Input()
  String message = '';

  @Output('trigger')
  Stream<Event> get onTrigger => _triggerController.stream;

  @Output('toggle')
  Stream<bool> get onToggle => _toggleController.stream;

  @Input()
  set visible(val) {
    displayPopup = getBool(val);
    _cd.markForCheck();
  }

  get visible => displayPopup;

  bool displayPopup = false;

  bool get useAction => actionLabel != null;
  bool showAnimation = false;

  void visibleChanged(bool visible) {
    showAnimation = displayPopup;
    displayPopup = visible;
    _cd.markForCheck();
    _toggleController.add(visible);
  }

  void trigger(event) {
    _triggerController.add(event);
  }

  @override
  void ngOnDestroy() {
    _disposer.dispose();
  }
}

PopupSizeProvider sizeProviderFactory() {
  return new FixedPopupSizeProvider(568, 100);
}


import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_components/src/components/material_button/material_button.dart';
import 'package:angular_components/src/utils/disposer/disposer.dart';

@Injectable()
class SnackbarService {

  StreamController<SnackMessage> _messageQueue = new StreamController<
      SnackMessage>();

  Stream get messages => _messageQueue.stream;

  void showMessage(String message, {Duration duration, SnackAction action}) {
    _messageQueue.add(new SnackMessage()
      ..text = message
      ..duration = duration ?? _defaultDuration
      ..action = action);
  }

  static final Duration _defaultDuration = new Duration(seconds: 3);

}

class SnackAction {
  String label;
  Function callback;
}

class SnackMessage {
  String text;
  Duration duration;
  SnackAction action;
}

@Component(
    selector: 'material-snackbar',
    templateUrl: 'material_snackbar.html',
    styleUrls: const ['material_snackbar.css'],
    directives: const [MaterialButtonComponent, NgIf],
    changeDetection: ChangeDetectionStrategy.OnPush,
    preserveWhitespace: false,
)
class MaterialSnackbarComponent implements OnInit, OnDestroy {
  final ChangeDetectorRef _changeDetectorRef;
  final SnackbarService _snackbarService;
  final Disposer _tearDownDisposer = new Disposer.oneShot();

  MaterialSnackbarComponent(this._changeDetectorRef, this._snackbarService);

  SnackMessage message;
  SnackMessage nextMessage;
  Timer _messageTimer;
  bool show;

  Timer _animationBlocker;
  static final Duration _minimumSlideInDelay = new Duration(milliseconds: 100);

  @override
  void ngOnInit() {
    final StreamSubscription subscription = _snackbarService.messages.listen((
        newMessage) {
      if (message == null) {
        message = newMessage;
        _slideIn();
      } else {
        nextMessage = newMessage;
        _messageTimer?.cancel();
        _messageTimer = null;
        if (_animationBlocker == null) {
          _slideOut();
        }
      }
    });
    _tearDownDisposer.addStreamSubscription(subscription);
  }

  void _slideIn() {
    show = true;
    _animationBlocker = new Timer(_minimumSlideInDelay, () {
      _animationBlocker = null;
      if (nextMessage != null) {
        _slideOut();
      }
    });
    _changeDetectorRef.markForCheck();
  }

  void _slideOut() {
    show = false;
    _changeDetectorRef.markForCheck();
  }

  void transitionEnd(_) {
    if (show) {
      _messageTimer = new Timer(message.duration, () {
        _messageTimer = null;
        _slideOut();
      });
    } else {
      if (nextMessage == null) {
        message = null;
        _changeDetectorRef.markForCheck();
      } else {
        message = nextMessage;
        nextMessage = null;
        _slideIn();
      }
    }
  }

  @override
  void ngOnDestroy() {
    _tearDownDisposer.dispose();
  }
}

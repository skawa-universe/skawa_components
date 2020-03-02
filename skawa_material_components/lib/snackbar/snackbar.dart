import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/utils/disposer/disposer.dart';

/// Snackbar service, emitting messages that the snackbar can listen to.
/// You can emit messages with the showMessage function. The default display
/// time of messages is 3 seconds, but you can specify any duration, and also callbacks.
///
///__Example__
///
///   _snackbarService.showMessage(
///     'Hello world',
///     duration: new Duration(seconds: 2),
///     action: new SnackAction()..label = 'call me back'..callback = callback);
///
class SnackbarService {
  final StreamController<SnackMessage> _messageQueue = StreamController<SnackMessage>();

  Stream<SnackMessage> get messages => _messageQueue.stream;

  void showMessage(String message, {Duration duration, SnackAction action}) {
    _messageQueue.add(SnackMessage()
      ..text = message
      ..duration = duration ?? _defaultDuration
      ..action = action);
  }

  static final Duration _defaultDuration = Duration(seconds: 3);
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

/// A Snackbar component. See more at: https://material.io/guidelines/components/snackbars-toasts.html
///
/// __Example__
///
/// <skawa-snackbar></skawa-snackbar>
///
/// Will display messages emitted by SnackbarService. Also a button if a SnackAction callback is specified.
///

@Component(
    selector: 'skawa-snackbar',
    templateUrl: 'snackbar.html',
    styleUrls: ['snackbar.css'],
    directives: [MaterialButtonComponent, NgIf],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaSnackbarComponent implements OnInit, OnDestroy {
  final ChangeDetectorRef _changeDetectorRef;
  final SnackbarService _snackbarService;
  final Disposer _tearDownDisposer = Disposer.oneShot();

  SnackMessage message;
  SnackMessage nextMessage;
  Timer _messageTimer;
  bool show;
  Timer _animationBlocker;

  SkawaSnackbarComponent(this._changeDetectorRef, this._snackbarService);

  @override
  void ngOnInit() {
    final StreamSubscription subscription = _snackbarService.messages.listen((SnackMessage newMessage) {
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
    _animationBlocker = Timer(minimumSlideInDelay, () {
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
      _messageTimer = Timer(message.duration, () {
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
  void ngOnDestroy() => _tearDownDisposer.dispose();

  static final Duration minimumSlideInDelay = Duration(milliseconds: 100);
}

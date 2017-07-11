import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';

/// Content source part of a [SkawaEditor] Component. It works in tandem
/// with [EditorRenderTarget] directive.
///
/// __Properties__:
///
/// - `value: String` -- sets or gets the value of the editor element
///
/// __Events__:
///
/// - `update: String` -- emitted when value is changed (onInput), at most once every 500ms
///
/// __Methods__:
///
/// - `revertAllUpdates(): void` -- revert all updates since directive was created
/// - `revertLastUpdate(): void` -- revert last update
///
/// __Example__:
///
///     <input editorRenderSource value="someInitialValue" >
///
@Directive(
    selector: '[editorRenderSource]',
    exportAs: 'editorRenderSource',
    inputs: const [
      'initialValue'
    ],
    outputs: const [
      'onUpdated: update'
    ],
    host: const {
      '(input)': r'contentChanged($event)',
    })
class EditorRenderSource implements AfterViewInit {
  final ElementRef elementRef;

  final List<String> _changeStack = <String>[];

  String initialValue;


  final StreamController _onUpdated = new StreamController.broadcast();

  Stream get onUpdated => _onUpdated.stream;

  DeferredCallback _emit;

  EditorRenderSource(this.elementRef) {
    _emit = new DeferredCallback(_onUpdated.add);
  }

  String get value {
    if (initialValue != null && _changeStack.isEmpty) {
      return initialValue;
    } else {
      return elementRef.nativeElement.value;
    }
  }

  /// Sets the value of editor
  void set value(String val) {
    _changeStack.insert(0, value);
//    _changeStack.add(value);
    elementRef.nativeElement.value = val;
  }

  /// Gets the previous or initial value
  String get previousValue {
    return _changeStack.length > 0 ? _changeStack.first : initialValue;
  }

  void revertLastUpdate() {
    if (_changeStack.length <= 1) {
      revertAllUpdates();
    } else {
      elementRef.nativeElement.value = _changeStack.first;
      _changeStack.removeAt(0);
    }
    _emit(value);
  }

  void revertAllUpdates() {
    value = initialValue;
    _changeStack.clear();
    _emit(initialValue);
  }

  void contentChanged(Event ev) {
    if (_changeStack.isEmpty || _changeStack.first != value) {
      _changeStack.insert(0, value);
    }
    _emit(value);
    ev.stopPropagation();
  }

  @override
  ngAfterViewInit() {
    // sync initial value to DOM
    _emit(initialValue);
    if (initialValue != null) elementRef.nativeElement.value = initialValue;
    (elementRef.nativeElement as Element)..onInput.listen(contentChanged);
  }
}

/// Responsible for debounced execution of a callback at most once in every
/// pre-defined interval
///
/// __Usage__:
///
///     var cb = new DeferredCallback(someAction, new Duration(seconds: 1));
///     cb(paramToPassToSomeAction);
///
class DeferredCallback<T, K> {
  final Duration timeout;

  Function _cb;

  Timer _timer;

  T previuslyEmitted;

  /// [callback] is the action that will be executed once every
  /// [timeout] duration
  DeferredCallback(K callback(T param), [Duration timeout])
      : timeout = timeout ?? _defaultTimeout,
        _cb = callback;

  Future<K> call(T param) {
    if (_timer != null) _timer.cancel();
    var c = new Completer<K>();
    _timer = new Timer(timeout, () {
      try {
        if (param == previuslyEmitted) {
          return;
        } else {
          previuslyEmitted = param;
          c.complete(_cb(param));
        }
      } catch (e) {
        c.completeError(e);
      }
    });
    return c.future;
  }

  static final Duration _defaultTimeout = new Duration(milliseconds: 500);
}

import 'dart:async';

/// Responsible for debounced execution of a callback at most once in every
/// pre-defined interval
///
/// __Usage__:
///
///     var cb = new DeferredCallback(someAction, new Duration(seconds: 1));
///     cb(paramToPassToSomeAction);
///
class PayloadWithCompleter<T, K> {
  Completer<K> completer = new Completer<K>();
  T payload;

  PayloadWithCompleter(this.payload);
}

class DeferredCallback<T, K> {
  final Duration timeout;

  Function _cb;

  Timer _timer;

  PayloadWithCompleter<T, K> lastEmitted;
  PayloadWithCompleter<T, K> lastReceived;

  /// [callback] is the action that will be executed once every
  /// [timeout] duration
  DeferredCallback(K callback(T param), [Duration timeout])
      : timeout = timeout ?? defaultTimeout,
        _cb = callback;

  bool emit() {
    bool emitted = false;
    try {
      if (lastReceived != lastEmitted) {
        lastEmitted = lastReceived;
        lastReceived.completer.complete(_cb(lastReceived.payload) as K);
        emitted = true;
      }
    } catch (e) {
      lastReceived.completer.completeError(e);
    }
    return emitted;
  }

  Future<K> call(T param) {
    lastReceived = new PayloadWithCompleter<T, K>(param);
    if (_timer == null) {
      if (emit()) resetTimer();
    }
    return lastReceived.completer.future;
  }

  void resetTimer() {
    _timer = new Timer(timeout, () {
      _timer = null;
      if (emit()) resetTimer();
    });
  }

  static final Duration defaultTimeout = new Duration(milliseconds: 500);
}

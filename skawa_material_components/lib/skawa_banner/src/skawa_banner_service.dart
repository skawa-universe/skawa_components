part of skawa_banner;

class SkawaBannerService {
  /// The message currently displayed by the banner component
  SkawaBannerMessage current;

  /// Messages waiting in the queue for later appearance
  final List<SkawaBannerMessage> messageQueue = [];

  final StreamController<SkawaBannerMessage> _dispatchController = StreamController<SkawaBannerMessage>.broadcast();

  Stream<SkawaBannerMessage> get dispatch => _dispatchController.stream;

  /// Either displays the message or puts it in the queue, based on message priority and already displayed message
  Future<DateTime> showMessage(SkawaBannerMessage message) {
    if (message.priority == BannerMessagePriority.normal || current == null) {
      // Dispatch immediately
      _dispatch(message);
    } else {
      messageQueue.add(message);
    }
    message.dismissEvent.future.then((_) => _dispatchNext());
    return message.dispatchEvent.future;
  }

  void _dispatchNext() {
    current = null;
    SkawaBannerMessage nextMessage;
    while (nextMessage == null && messageQueue.isNotEmpty) {
      nextMessage = messageQueue.removeAt(0);
      // Check if this message is still relevant (i.e. its TTL value is not yet expired)
      if (nextMessage.ttlInQueue != null &&
          (DateTime.now().millisecondsSinceEpoch - nextMessage.timeCreated.millisecondsSinceEpoch >
              nextMessage.ttlInQueue)) {
        nextMessage = null;
      } else if (nextMessage.beforeDispatch != null) {
        if (!nextMessage.beforeDispatch()) {
          nextMessage = null;
        }
      }
    }
    if (nextMessage != null) {
      _dispatch(nextMessage);
    }
  }

  void _dispatch(SkawaBannerMessage message) {
    current = message;
    current.dispatch();
    _dispatchController.add(current);
  }
}

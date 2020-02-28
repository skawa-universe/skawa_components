part of skawa_banner;

class SkawaBannerMessage {
  /// The message text to display
  /// Messages breaking into more than two lines will be truncated
  final String text;

  /// An optional supplementary icon to the message
  final SkawaMaterialIcon icon;

  /// Available actions for this message
  final List<BannerAction> actions;

  /// Layout control: if actions should break below the message, on a new line
  final bool actionsBelow;

  /// Message priority
  /// [BannerMessagePriority.low]: the current message will not override another message
  /// that is already displayed in the banner
  /// [BannerMesagePriority.normal]: the current message will override the already displayed message
  final BannerMessagePriority priority;

  /// DateTime when the message object was created
  final DateTime timeCreated;

  /// Number of milliseconds that a message can spend in the message queue before it loses relevance
  /// Only relevant for [BannerMessagePriority.low] messages, as normal priority messages will be displayed immediately
  /// If a low priority message spends more time waiting in the queue than this value, it will be silently discarded
  /// Set to zero if the message has only immediate relevance
  final int ttlInQueue;

  /// A callback function that will be invoked just before the message is displayed
  /// Only gets called for queued messages
  /// Use in combination with [ttlInQueue] to abort displaying an already obsolete message waiting in the queue
  final BannerBeforeDispatchCallback beforeDispatch;

  /// DateTime when the message object was dispatched (displayed on screen)
  DateTime _dispatchTime;

  /// DateTime when the message object was dismissed (removed from screen)
  DateTime _dismissTime;

  /// Will be completed when the message is dispatched (i.e. displayed on screen)
  Completer<DateTime> dispatchEvent = Completer();

  /// Will be completed when the message is dismissed by user action (i.e. removed from screen)
  /// Will not be completed (triggered) if the message was overridden by another message
  Completer<DateTime> dismissEvent = Completer();

  SkawaBannerMessage(this.text,
      {this.icon,
      List<BannerAction> actions,
      this.actionsBelow = true,
      this.priority = BannerMessagePriority.normal,
      this.ttlInQueue,
      this.beforeDispatch})
      : actions = actions ?? [BannerAction.dismiss()],
        timeCreated = DateTime.now();

  /// Redirect constructor for an information message with an icon
  SkawaBannerMessage.info(String text,
      {List<BannerAction> actions,
      bool actionsBelow,
      BannerMessagePriority priority = BannerMessagePriority.low,
      int ttlInQueue,
      BannerBeforeDispatchCallback beforeDispatch})
      : this(text,
            icon: SkawaMaterialIcon("info", "color-info"),
            actions: actions ?? [BannerAction.dismiss()],
            actionsBelow: actionsBelow,
            priority: priority,
            ttlInQueue: ttlInQueue,
            beforeDispatch: beforeDispatch);

  /// Redirect constructor for a warning message with an icon
  SkawaBannerMessage.warning(String text,
      {List<BannerAction> actions,
      bool actionsBelow = true,
      BannerMessagePriority priority = BannerMessagePriority.normal,
      int ttlInQueue,
      BannerBeforeDispatchCallback beforeDispatch})
      : this(text,
            icon: SkawaMaterialIcon("warning", "color-warning"),
            actions: actions ?? [BannerAction.dismiss()],
            actionsBelow: actionsBelow,
            priority: priority,
            ttlInQueue: ttlInQueue,
            beforeDispatch: beforeDispatch);

  /// Redirect constructor for an error message with an icon
  SkawaBannerMessage.error(String text,
      {List<BannerAction> actions,
      bool actionsBelow = true,
      BannerMessagePriority priority = BannerMessagePriority.normal,
      int ttlInQueue,
      BannerBeforeDispatchCallback beforeDispatch})
      : this(text,
            icon: SkawaMaterialIcon("error", "color-error"),
            actions: actions ?? [BannerAction.dismiss()],
            actionsBelow: actionsBelow,
            priority: priority,
            ttlInQueue: ttlInQueue,
            beforeDispatch: beforeDispatch);

  void dispatch() {
    if (_dispatchTime != null) throw StateError("dispatch: Message already dispatched at $_dispatchTime");
    _dispatchTime = DateTime.now();
    dispatchEvent.complete(_dispatchTime);
  }

  void dismiss() {
    if (_dismissTime != null) throw StateError("dismiss: Message already dismissed at $_dispatchTime");
    _dismissTime = DateTime.now();
    dismissEvent.complete(_dismissTime);
  }

  DateTime get dispatchTime => _dispatchTime;
}

class SkawaMaterialIcon {
  /// A material icon name, i.e. "warning" or "shopping-cart"
  final String icon;

  /// Any supplemental CSS class to be applied on the icon
  final String iconClass;

  const SkawaMaterialIcon(this.icon, this.iconClass);
}

class BannerAction {
  /// Text that will be displayed on the action button
  final String message;

  /// A callback function that will be invoked when clicking the action button
  /// The bannser message will only be dismissed if and when the Future<bool> value returned by this function
  /// resolves to true.
  final BannerActionCallback callback;

  const BannerAction(this.message, {this.callback});

  /// A redirect constructor that creates a basic dismiss action with no callback.
  BannerAction.dismiss() : this(textDismiss);

  static final String textDismiss = Intl.message("Dismiss");
}

enum BannerMessagePriority { low, normal }

typedef BannerBeforeDispatchCallback = bool Function();

typedef BannerActionCallback = Future<bool> Function();

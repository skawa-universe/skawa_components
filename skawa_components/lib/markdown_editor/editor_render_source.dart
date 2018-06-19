import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';
import 'deferred_callback.dart';

/// Content source part of a SkawaEditor Component. It works in tandem
/// with EditorRenderTarget directive.
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
/// - `revertAllUpdates(): void` -- revert all updates since directiv e was created
/// - `revertLastUpdate(): void` -- revert last update
///
/// __Example__:
///
///     <input editorRenderSource value="someInitialValue" >
///
@Directive(selector: '[editorRenderSource]', exportAs: 'editorRenderSource')
class EditorRenderSource implements AfterViewInit, OnDestroy, OnInit {
  final HtmlElement htmlElement;
  final StreamController _onUpdatedController = new StreamController.broadcast();
  final List<String> _changeStack = <String>[];

  @Input()
  String initialValue;

  @Input()
  Duration updateDelay;

  DeferredCallback _emit;

  EditorRenderSource(this.htmlElement);

  @Output('update')
  Stream get onUpdated => _onUpdatedController.stream;

  String get value {
    if (initialValue != null && _changeStack.isEmpty) {
      return initialValue;
    } else {
      return htmlElement.nodeValue;
    }
  }

  /// Sets the value of editor
  set value(String val) {
    _changeStack.insert(0, value);
    htmlElement.setAttribute('value', val);
  }

  /// Gets the previous or initial value
  String get previousValue => _changeStack.length > 0 ? _changeStack.first : initialValue;

  void revertLastUpdate() {
    if (_changeStack.length <= 1) {
      revertAllUpdates();
    } else {
      _changeStack.removeAt(0);
      htmlElement.setAttribute('value', _changeStack.first);
      _emit(value);
    }
  }

  void revertAllUpdates() {
    value = initialValue;
    _changeStack.clear();
    _emit(initialValue);
  }

  @HostListener('input')
  void contentChanged(Event ev) {
    if (_changeStack.isEmpty || _changeStack.first != value) {
      _changeStack.insert(0, value);
    }
    _emit(value);
    ev.stopPropagation();
  }

  @override
  void ngAfterViewInit() {
    // sync initial value to DOM
    _emit(initialValue);
    if (initialValue != null) htmlElement.setAttribute('value', initialValue);
    htmlElement.onInput.listen(contentChanged);
  }

  @override
  void ngOnDestroy() {
    _onUpdatedController.close();
  }

  @override
  void ngOnInit() {
    _emit = new DeferredCallback(_onUpdatedController.add, updateDelay);
  }
}

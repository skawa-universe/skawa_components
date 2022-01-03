import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/utils/async/async.dart';

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
/// - `revertAllUpdates(): void` -- revert all updates since directive was created
/// - `revertLastUpdate(): void` -- revert last update
///
/// __Example__:
///
///     <input editorRenderSource value="someInitialValue" >
///
@Directive(selector: '[editorRenderSource]', exportAs: 'editorRenderSource')
class EditorRenderSource implements AfterViewInit, OnDestroy {
  final HtmlElement _htmlElement;
  final StreamController<String> _onUpdatedController = StreamController<String>.broadcast();
  final List<String> _changeStack = <String>[];

  @Input()
  String initialValue  = '';

  EditorRenderSource(this._htmlElement, @Optional() Duration? updateDelay) {
    onUpdated = _onUpdatedController.stream.transform(debounceStream(updateDelay ?? _defaultTimeout));
  }

  @Output('update')
  late Stream<String> onUpdated;

  String? get _value {
    if (_htmlElement is TextAreaElement) {
      return (_htmlElement as TextAreaElement).value;
    } else if (_htmlElement is InputElement) {
      return (_htmlElement as InputElement).value;
    } else {
      return _htmlElement.nodeValue;
    }
  }

  set _value(String? value) {
    if (_htmlElement is TextAreaElement) {
      (_htmlElement as TextAreaElement).value = value;
    } else if (_htmlElement is InputElement) {
      (_htmlElement as InputElement).value = value;
    } else {
      _htmlElement.setAttribute('value', value ?? '');
    }
  }

  String get value {
    if (_changeStack.isEmpty) {
      return initialValue;
    } else {
      return _value!;
    }
  }

  /// Sets the value of editor
  set value(String value) {
    _changeStack.insert(0, value);
    _value = value;
  }

  /// Gets the previous or initial value
  String? get previousValue => _changeStack.isNotEmpty ? _changeStack.first : initialValue;

  void revertLastUpdate() {
    if (_changeStack.length <= 1) {
      revertAllUpdates();
    } else {
      _changeStack.removeAt(0);
      _value = initialValue = _changeStack.first;
      _onUpdatedController.add(value);
    }
  }

  void revertAllUpdates() {
    value = initialValue;
    _changeStack.clear();
    _onUpdatedController.add(initialValue);
  }

  @HostListener('input')
  void contentChanged(Event ev) {
    if (_changeStack.isEmpty || _changeStack.first != value) {
      _changeStack.insert(0, value);
    }
    _onUpdatedController.add(value);
    ev.stopPropagation();
  }

  @override
  void ngAfterViewInit() {
    // sync initial value to DOM
    _onUpdatedController.add(initialValue);
    _value = initialValue;
    _htmlElement.onInput.listen(contentChanged);
  }

  @override
  void ngOnDestroy() => _onUpdatedController.close();

  static final Duration _defaultTimeout = Duration(milliseconds: 500);
}

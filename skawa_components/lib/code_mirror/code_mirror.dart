import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'dart:js_util';
import 'package:angular/angular.dart';
import 'package:angular_components/material_icon/material_icon.dart';

import 'code_mirror_config.dart';
import 'code_mirror_interop.dart' as js_ck;
import 'code_mirror_mode.dart';

@Component(
    selector: 'skawa-code-mirror',
    templateUrl: 'code_mirror.html',
    styleUrls: ['code_mirror.css'],
    directives: [NgIf, MaterialIconComponent],
    changeDetection: ChangeDetectionStrategy.OnPush)
class CodeMirrorComponent implements OnDestroy {
  final StreamController<String> _changeController = StreamController<String>.broadcast();
  final ChangeDetectorRef changeDetectorRef;

  js_ck.CodeMirror _codeMirror;
  String _value = '';
  CodeMirrorMode _mode;
  List<CodeMirrorError> errorList = [];
  List<CodeMirrorError> warningList = [];

  @ViewChild('textarea')
  HtmlElement textarea;

  @Input()
  bool withLint = true;

  CodeMirrorComponent(this.changeDetectorRef);

  bool get hasError => errorList.any((error) => error.severity == CodeMirrorError.error);

  @Input()
  set mode(CodeMirrorMode mode) {
    if (_mode != mode) {
      _codeMirror?.off('change', _onChange(_mode));
      _codeMirror?.toTextArea();
      load(mode);
    } else {
      _mode = mode;
    }
  }

  @Input()
  set value(String value) {
    String validValue = value ?? '';
    if (validValue != _value && _codeMirror != null) {
      _codeMirror.setValue(validValue);
      _lint(_mode);
    }
    _value = validValue;
  }

  String get value => _value;

  @Output('change')
  Stream<String> get onChange => _changeController.stream;

  void load(CodeMirrorMode mode) {
    _codeMirror = js_ck.CodeMirror.fromTextArea(
        textarea,
        CodeMirrorConfig(
            mode: mode.modeName ?? mode.mode,
            theme: mode.theme,
            extraKeys: {'Ctrl-Space': allowInterop(_showHint), 'Cmd-Space': allowInterop(_showHint)},
            gutters: ["CodeMirror-lint-markers"]).toJsConfig);
    _codeMirror.setValue(_value);
    _lint(mode);
    _codeMirror.on('change', _onChange(mode));
    _mode = mode;
  }

  Function _onChange(CodeMirrorMode mode) => allowInterop((_, __) {
        _value = _codeMirror.getValue();
        _lint(mode);
      });

  void _showHint(_) => _codeMirror.showHint(_codeMirror, js_ck.CodeMirrorHint.jsHint);

  void _lint(CodeMirrorMode mode) {
    if (withLint) {
      warningList = [];
      errorList = [];
      if (mode.linter != null) {
        context['CodeMirror']['lint']
            .callMethod(mode.linter, [
              _value,
              jsify({"indent": 1})
            ])
            ?.map<CodeMirrorError>((Object object) => CodeMirrorError.fromObject(object as JsObject))
            ?.forEach((CodeMirrorError error) {
              if (error.severity == CodeMirrorError.error) {
                errorList.add(error);
              } else if (error.severity == CodeMirrorError.warning) {
                warningList.add(error);
              }
            });
      }
    }
    _changeController.add(_value);
    changeDetectorRef.markForCheck();
  }

  @override
  void ngOnDestroy() {
    _changeController.close();
    _codeMirror?.toTextArea();
  }
}

class CodeMirrorError {
  final String message;
  final String severity;
  final CodeMirrorPosition from;
  final CodeMirrorPosition to;

  CodeMirrorError.fromObject(JsObject object)
      : this.message = object['message'] as String,
        this.severity = object['severity'] as String,
        this.from = CodeMirrorPosition.fromJsObject(object['from'] as JsObject),
        this.to = CodeMirrorPosition.fromJsObject(object['to'] as JsObject);

  static const String error = 'error';
  static const String warning = 'warning';
}

class CodeMirrorPosition {
  final double line;
  final double ch;

  CodeMirrorPosition.fromJsObject(JsObject object)
      : this.line = object['line'] as double,
        this.ch = object['ch'] as double;
}

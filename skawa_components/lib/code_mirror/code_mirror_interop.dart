@JS()
library code_mirror_interop;

import 'dart:html';
import 'package:js/js.dart';

@JS('CodeMirror')
abstract class CodeMirror {
  @JS()
  external CodeMirror.fromBody(Element element, Map config);

  @JS('fromTextArea')
  external static CodeMirror fromTextArea(Element element, dynamic config);

  external void toTextArea();

  external String getValue([String separator]);

  external void setValue(String content);

  external void setOption(String content, dynamic value);

  external void showHint(CodeMirror codeMirror, Function function);

  @JS('on')
  external void on(String eventName, Function function);

  @JS('off')
  external void off(String eventName, Function function);

  @JS('getHelper')
  external Object getHelper(String type);
}

@JS('CodeMirror.hint')
class CodeMirrorHint {
  @JS('javascript')
  external static void jsHint();
}

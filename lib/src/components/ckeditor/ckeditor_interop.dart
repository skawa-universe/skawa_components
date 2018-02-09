@JS()
library ckeditor_interop;

import 'package:js/js.dart';

@JS('CKEDITOR')
abstract class CKEditor {
  @JS('replace')
  external static CKEditorInstance replace(String element, config);
}

@JS()
class CKEditorInstance {
  external String get name;

  external getData();
}

@JS('CKEDITOR.plugins.addExternal')
external void addExternalPlugin(String name, String path, String fileName);

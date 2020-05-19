@JS()
library ckeditor_interop;

import 'package:js/js.dart';

@JS('CKEDITOR')
abstract class CKEditor {
  @JS('replace')
  external static CKEditorInstance replace(String element, Object config);

  @JS("config")
  external Map<String, dynamic> get config;
}

@JS()
class CKEditorInstance {
  external String get name;

  external String getData();
}

@JS('CKEDITOR.plugins.addExternal')
external void addExternalPlugin(String name, String path, String fileName);

@JS()
library ckeditor_interop;

import 'package:js/js.dart';

@JS('CKEDITOR')
abstract class CKEditor {
  @JS('replace')
  external static CKEditorInstance replace(String element, dynamic config);

  @JS("config")
  external Map<String, dynamic> get config;
}

@JS()
class CKEditorInstance {
  external String get name;

  external String getData();

  external void on(String eventName, EventCallback callback);
}

@JS()
@anonymous
class EventInfo {
  external CKEditorInstance get editor;

  external factory EventInfo({CKEditorInstance editor});
}

@JS('CKEDITOR.plugins.addExternal')
external void addExternalPlugin(String name, String path, String fileName);

typedef EventCallback = void Function(EventInfo evt);

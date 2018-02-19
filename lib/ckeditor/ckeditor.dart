import 'dart:async';
import 'dart:js_util';
import 'package:angular/angular.dart';

import 'ckeditor_interop.dart' as js_ck;

/// Simple CKEditor wrapper component.
///
/// *Note:* CKEditor component uses ckeditor.js, make sure it is available
///
/// __Example usage:__
///
///     <skawa-ckeditor editorName="editor"
///         [extraPlugins]="[ somePlugin ]"
///         configUrl="/ckeditor/config.js"
///         (change)="editorChanged($event)" ></skawa-ckeditor>
///
/// __Events:__
/// - `change: String` -- Triggered when editor content changes
///
/// __Properties:__
/// - `editorName: String` -- element CSS selector to replace with CKEditor, this should be unique
/// - `extraPlugins: List<ExtraPlugin>` -- extra plugins to load with CKEditor
/// - `configUrl: String` -- url of the config file to load for CKEditor
/// - `content: String` -- initial value of editor
@Component(selector: 'skawa-ckeditor', templateUrl: 'ckeditor.html', changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaCkeditorComponent implements AfterViewInit, OnDestroy {
  final _changeController = new StreamController<String>.broadcast();
  _CKEditor _ckeditor;

  @Input()
  String editorName;

  @Input()
  List<ExtraPlugin> extraPlugins;

  @Input()
  String content;

  @Input()
  String configUrl;

  @Output('change')
  Stream<String> get onChange => _changeController.stream;

  String get value => _ckeditor.getEditorData();

  @override
  void ngAfterViewInit() {
    _ckeditor = new _CKEditor(editorName, extraPlugins: extraPlugins, configUrl: configUrl);
  }

  @override
  void ngOnDestroy() {
    _changeController.close();
  }
}

/// Extra plugin to load with for CKEditor
class ExtraPlugin {
  final String name;
  final String path;
  final String entrypoint;

  ExtraPlugin(this.name, this.path, this.entrypoint);
}

class _CKEditor {
  js_ck.CKEditorInstance _jsEditorInstance;

  _CKEditor(String editorElementSelector,
      {Iterable<ExtraPlugin> extraPlugins: const [], String configUrl: '/ckeditor/config.js'}) {
    /// add external plugins
    _maybeAddExtraPlugins(extraPlugins);

    /// Load editor
    _jsEditorInstance = js_ck.CKEditor.replace(editorElementSelector, jsify({'customConfig': configUrl}));
  }

  String getEditorData() {
    return _jsEditorInstance.getData();
  }

  void _maybeAddExtraPlugins(Iterable<ExtraPlugin> extraPlugins) {
    if (extraPlugins == null) return;
    for (ExtraPlugin extraPlugin in extraPlugins) {
      js_ck.addExternalPlugin(extraPlugin.name, extraPlugin.path, extraPlugin.entrypoint);
    }
  }
}

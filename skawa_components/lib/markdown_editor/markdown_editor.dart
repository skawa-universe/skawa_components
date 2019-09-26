import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular/core.dart';

import 'package:angular/src/common/directives/ng_class.dart';
import 'package:angular_components/focus/focus.dart';

import '../directives/language_direction_directive.dart';
import 'editor_render_source.dart';
import 'editor_render_target.dart';

/// Interface describing an Editor
abstract class SkawaEditor {
  /// Gets the mode in which the editor is in
  String get displayMode;

  /// Sets the mode in which the editor is in
  set displayMode(String mode);

  /// Gets the updated value of the editor
  String get value;

  /// Sets the updated value of the editor
  set value(String val);

  /// Event emitted when value changes
  Stream get onUpdated;

  /// Reverts all edits, restores state to when the component was
  /// created
  void revertAllChanges();
}

/// Base class for an editor that uses a textarea as input
/// and a Div as a render output
abstract class TextareaEditorBase implements SkawaEditor {
  @Input()
  bool disabled = false;

  StreamController<String> get _modeController;

  set renderTarget(EditorRenderTarget newTarget);

  EditorRenderTarget get renderTarget;

  String _displayMode = EditorMode.DISPLAY;

  @override
  String get displayMode => _displayMode;

  String get _emulatedCssClass;

  @override
  set displayMode(String mode) {
    if (mode == _displayMode) return;
    if (mode == EditorMode.DISPLAY) {
      List<String> newClasses = [];
      if (_emulatedCssClass != null) newClasses.add(_emulatedCssClass);
      renderTarget.updateRender(value, classes: newClasses);
    }
    _displayMode = mode;
    _modeController.add(_displayMode);
  }
}

/// Markdown editor Component
///
/// __Properties__:
///
/// - `value: String` -- value of the editor
/// - `displayMode: EditorMode` -- current mode the editor is in
///
/// __Methods__:
///
/// - `cancelEdit()` -- revert all changes and exit edit mode
/// - `previewMarkdown()` -- render source and enter preview mode
/// - `editMarkdown()` -- enter edit mode
///
/// __Events__:
///
/// - `(update): String` -- if contents of the editor is changed, this is emitted
///
/// __Example__:
///
///     <skawa-markdown-editor value="Some initial value">
///       <div class="placeholder">What to display if value is empty</div>
///     </skawa-markdown-editor>
///
@Component(
    selector: 'skawa-markdown-editor',
    templateUrl: 'markdown_editor.html',
    styleUrls: ['markdown_editor.css'],
    directives: [AutoFocusDirective, EditorRenderSource, EditorRenderTarget, LanguageDirectionDirective, NgClass],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaMarkdownEditorComponent extends TextareaEditorBase implements OnInit, AfterViewInit, OnDestroy {
  final StreamController<String> _modeController = StreamController<String>();
  final ViewContainerRef containerRef;
  final ChangeDetectorRef changeDetectorRef;

  @Input()
  String initialValue;

  String _emulatedCssClass;
  EmbeddedViewRef _placeholderTemplateCache;
  bool _placeholderDefined;

  @ViewChild(EditorRenderSource)
  EditorRenderSource renderSource;

  @override
  @ViewChild(EditorRenderTarget)
  EditorRenderTarget renderTarget;

  @ViewChild('placeholderTemplate')
  TemplateRef placeholderTemplate;

  SkawaMarkdownEditorComponent(this.containerRef, this.changeDetectorRef);

  @HostBinding('class.mode-edit')
  bool get isEditing => displayMode == EditorMode.EDIT;

  @HostBinding('class.mode-display')
  bool get isDisplaying => displayMode == EditorMode.DISPLAY;

  @override
  @Output('update')
  Stream<String> get onUpdated => renderSource.onUpdated;

  @Output('mode')
  Stream<String> get onMode => _modeController.stream;

  @override
  String get value => renderSource.value;

  @override
  set value(String val) {
    print('editor set value: $value');
    renderSource.value = val;
  }

  bool get displayPlaceholder {
    if (_placeholderDefined != null && _placeholderDefined) {
      return value == null || value.trim().isEmpty;
    }
    return false;
  }

  Map<String, bool> get ngClasses => {'with-placeholder': displayPlaceholder, 'disabled': disabled};

  String get mode => displayMode;

  void editMarkdown() {
    if (!disabled) displayMode = EditorMode.EDIT;
  }

  void previewMarkdown() {
    displayMode = EditorMode.DISPLAY;
    if (displayPlaceholder) _clonePlaceholderIntoTemplate();
  }

  void cancelEdit() {
    revertAllChanges();
    displayMode = EditorMode.DISPLAY;
    if (displayPlaceholder) {
      _clonePlaceholderIntoTemplate();
    }
  }

  @override
  void revertAllChanges() {
    renderSource.revertAllUpdates();
    renderTarget.updateRender(value, classes: [_emulatedCssClass]);
  }

  @override
  void ngOnInit() {
    _emulatedCssClass =
        renderTarget.htmlElement.classes.firstWhere((String cssClass) => !cssClass.contains('markdown-container'));
    _placeholderTemplateCache = placeholderTemplate.createEmbeddedView();
    _placeholderDefined = _placeholderTemplateCache.rootNodes
            .firstWhere((Node n) => n is Element && n.classes.contains('placeholder'), orElse: () => null) !=
        null;
  }

  @override
  void ngAfterViewInit() {
    if (displayPlaceholder) _clonePlaceholderIntoTemplate();
    if (value != '') renderTarget.updateRender(value, classes: [_emulatedCssClass]);
    renderTarget.htmlElement;
  }

  @override
  void ngOnDestroy() => _modeController.close();

  void _clonePlaceholderIntoTemplate() {
    renderTarget.htmlElement.children.clear();
    _placeholderTemplateCache.rootNodes.forEach((Node n) {
      renderTarget.htmlElement.append(n);
    });
  }
}

/// Mode of MarkdownEditor
class EditorMode {
  static const String EDIT = 'edit';
  static const String DISPLAY = 'display';
}

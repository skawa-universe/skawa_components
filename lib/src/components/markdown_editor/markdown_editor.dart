import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';

import 'package:angular2/src/common/directives/ng_class.dart';
import 'package:angular_components/src/components/focus/focus.dart';
import 'package:meta/meta.dart';

import 'editor_render_source.dart';
import 'editor_render_target.dart';
import '../../directives/language_direction/language_direction_directive.dart';

/// Interface describing an Editor
abstract class SkawaEditor {
  /// Gets the mode in which the editor is in
  String get displayMode;

  /// Sets the mode in which the editor is in
  void set displayMode(String mode);

  /// Gets the updated value of the editor
  String get value;

  /// Sets the updated value of the editor
  void set value(String val);

  /// Event emitted when value changes
  Stream get onUpdated;

  /// Reverts all edits, restores state to when the component was
  /// created
  void revertAllChanges();
}

/// Base class for an editor that uses a textarea as input
/// and a Div as a render output
abstract class TextareaEditorBase implements SkawaEditor {
  // TODO: SDK 1.23 is out, this will not be needed any more
  @virtual
  EditorRenderTarget renderTarget;

  String _displayMode = EditorMode.DISPLAY;

  String get displayMode => _displayMode;

  void set displayMode(String mode) {
    if (mode == _displayMode) return;
    if (mode == EditorMode.DISPLAY) {
      renderTarget.updateRender(value);
    }
    _displayMode = mode;
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
    styleUrls: const [
      'markdown_editor.css'
    ],
    directives: const [
      AutoFocusDirective,
      EditorRenderSource,
      EditorRenderTarget,
      LanguageDirectionDirective,
      NgClass,
    ],
    outputs: const [
      'onUpdated: update'
    ],
    inputs: const [
      'initialValue'
    ],
    host: const {
      '[class.mode-edit]': 'displayMode == "edit"',
      '[class.mode-display]': 'displayMode == "display"'
    })
class SkawaMarkdownEditorComponent extends TextareaEditorBase
    implements OnInit, AfterViewInit {
  final ViewContainerRef containerRef;
  final ChangeDetectorRef changeDetectorRef;

  String initialValue;

  String _emulatedCssClass;

  @ViewChild(EditorRenderSource)
  EditorRenderSource renderSource;

  @ViewChild(EditorRenderTarget)
  EditorRenderTarget renderTarget;

  @ViewChild('placeholderTemplate')
  TemplateRef placeholderTemplate;

  SkawaMarkdownEditorComponent(this.containerRef, this.changeDetectorRef);

  String get value => renderSource.value;

  void set value(String val) {
    renderSource.value = val;
  }

  @override
  Stream get onUpdated => renderSource.onUpdated;

  bool get displayPlaceholder {
    if (_placeholderDefined != null && _placeholderDefined) {
      return value == null || value.trim().isEmpty;
    }
    return false;
  }

  String get mode => displayMode;

  void editMarkdown() {
    displayMode = EditorMode.EDIT;
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
  ngOnInit() {
    _emulatedCssClass = renderTarget.elementRef.nativeElement.classes
        .firstWhere(
            (String cssClass) => !cssClass.contains('markdown-container'));
    _placeholderTemplateCache = placeholderTemplate.createEmbeddedView(null);
    _placeholderDefined = _placeholderTemplateCache.rootNodes.firstWhere(
            (Node n) => n is Element && n.classes.contains('placeholder'),
            orElse: () => null) !=
        null;
  }

  @override
  ngAfterViewInit() {
    if (displayPlaceholder) _clonePlaceholderIntoTemplate();
    if (value != '')
      renderTarget.updateRender(value, classes: [_emulatedCssClass]);
    renderTarget.elementRef.nativeElement;
  }

  void _clonePlaceholderIntoTemplate() {
    renderTarget.elementRef.nativeElement.children.clear();
    _placeholderTemplateCache.rootNodes.forEach((Node n) {
      renderTarget.elementRef.nativeElement.append(n);
    });
  }

  EmbeddedViewRef _placeholderTemplateCache;
  bool _placeholderDefined;
}

/// Mode of [MarkdownEditor]
class EditorMode {
  static const String EDIT = 'edit';
  static const String DISPLAY = 'display';
}

import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';
import 'package:markdown/markdown.dart' as markdown;

/// Target where rendered output of EditorRendererSource will be inserted
///
/// __Providers__:
///
/// - `EditorRenderer` -- renderer to use to convert EditorRendererSource.value to a DOM fragment
@Directive(selector: '[editorRenderTarget]', exportAs: 'editorRenderTarget')
class EditorRenderTarget implements OnDestroy {
  final ElementRef elementRef;
  final EditorRenderer renderer;
  final StreamController _onRenderController = new StreamController.broadcast();

  String _previousRender;

  EditorRenderTarget(this.elementRef, @SkipSelf() @Inject(EditorRenderer) this.renderer);

  @Output('render')
  Stream get onRender => _onRenderController.stream;

  Element get _element => elementRef.nativeElement;

  void updateRender(String newTarget, {List<String> classes}) {
    _onRenderController.add(newTarget);
    if (newTarget == _previousRender) return;
    _element.children.clear();
    _element.append(renderer.render(newTarget));
    _updateElementChildren(_element, classes);
  }

  void _updateElementChildren(Element element, List<String> classes) {
    if (classes != null && classes.isNotEmpty && element.children.isNotEmpty) {
      element.children.forEach((Element child) {
        child.classes.addAll(classes);
        _updateElementChildren(child, classes);
      });
    }
  }

  @override
  void ngOnDestroy() => _onRenderController.close();
}

/// Interface to describe a renderer
///
/// Renderers are responsible for converting an arbitrary source
/// piece to a format directly usable by DOM
abstract class EditorRenderer {
  /// Converts [source] to a [DocumentFragment]
  DocumentFragment render(String source);
}

/// Renders HTML source
@Injectable()
class HtmlRenderer implements EditorRenderer {
  @override
  DocumentFragment render(String source) {
    return new DocumentFragment.html(source);
  }
}

/// Renders Markdown source
@Injectable()
class MarkdownRenderer implements EditorRenderer {
  @override
  DocumentFragment render(String source) {
    return new DocumentFragment.html(markdown.markdownToHtml(source));
  }
}

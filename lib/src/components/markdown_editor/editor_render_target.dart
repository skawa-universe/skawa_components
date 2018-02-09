import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';
import 'package:markdown/markdown.dart' as markdown;

/// Target where rendered output of EditorRendererSource will be inserted
///
/// __Providers__:
///
/// - `EditorRenderer` -- renderer to use to convert EditorRendererSource.value to a DOM fragment
@Directive(
  selector: '[editorRenderTarget]',
  exportAs: 'editorRenderTarget',
  outputs: const ['onRender: render'],
)
class EditorRenderTarget implements OnDestroy {
  final ElementRef elementRef;
  final EditorRenderer renderer;
  final StreamController _onRenderController = new StreamController.broadcast();

  String _previousRender;

  EditorRenderTarget(this.elementRef, @SkipSelf() @Inject(EditorRenderer) this.renderer);

  Stream get onRender => _onRenderController.stream;

  void updateRender(String newTarget, {List<String> classes}) {
    _onRenderController.add(newTarget);
    if (newTarget == _previousRender) return;
    Element e = elementRef.nativeElement as Element;
    e.children.clear();
    e.append(renderer.render(newTarget));
    if (classes != null && classes.isNotEmpty)
      e.children.forEach((Element children) {
        children.classes.addAll(classes);
      });
  }

  @override
  void ngOnDestroy() {
    _onRenderController.close();
  }
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

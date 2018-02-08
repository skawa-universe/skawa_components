import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';
import 'package:markdown/markdown.dart' as markdown;

/// Target where rendered output of [EditorRendererSource] will be inserted
///
/// __Providers__:
///
/// - `EditorRenderer` -- renderer to use to convert [EditorRendererSource.value] to a DOM fragment
@Directive(
  selector: '[editorRenderTarget]',
  exportAs: 'editorRenderTarget',
  outputs: const ['onRender: render'],
)
class EditorRenderTarget {
  final ElementRef elementRef;
  final EditorRenderer renderer;

  final StreamController _onRender = new StreamController.broadcast();

  Stream get onRender => _onRender.stream;

  String _previousRender;

  EditorRenderTarget(this.elementRef, @SkipSelf() @Inject(EditorRenderer) this.renderer);

  void updateRender(String newTarget, {List<String> classes}) {
    _onRender.add(newTarget);
    if (newTarget == _previousRender) return;
    Element e = elementRef.nativeElement as Element;
    e.children.clear();
    e.append(renderer.render(newTarget));
    if (classes != null && classes.isNotEmpty)
      e.children.forEach((Element children) {
        children.classes.addAll(classes);
      });
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

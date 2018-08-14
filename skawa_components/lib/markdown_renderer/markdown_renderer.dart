import 'package:angular/angular.dart';
import 'package:skawa_components/directives/language_direction_directive.dart';
import 'package:skawa_components/markdown_editor/editor_render_target.dart';

@Component(
    selector: 'skawa-markdown-renderer',
    templateUrl: 'markdown_renderer.html',
    styleUrls: const ['markdown_renderer.css'],
    directives: const [EditorRenderTarget, LanguageDirectionDirective],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaMarkdownRendererComponent implements OnInit {
  String _source;
  String _emulatedCssClass;

  @ViewChild(EditorRenderTarget)
  EditorRenderTarget editorRenderTarget;

  @Input()
  set source(String source) {
    _source = source;
    editorRenderTarget.updateRender(_source, classes: [_emulatedCssClass]);
  }

  @override
  void ngOnInit() {
    _emulatedCssClass = editorRenderTarget.htmlElement.classes
        .firstWhere((String cssClass) => !cssClass.contains('markdown-container'), orElse: () => null);
  }
}

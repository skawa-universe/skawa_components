import 'package:angular/angular.dart';
import 'package:skawa_components/directives/language_direction_directive.dart';
import 'package:skawa_components/markdown_editor/editor_render_target.dart';

@Component(
    selector: 'skawa-markdown-renderer',
    templateUrl: 'markdown_renderer.html',
    styleUrls: ['markdown_renderer.css'],
    directives: [EditorRenderTarget, LanguageDirectionDirective],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaMarkdownRendererComponent implements OnInit {
  List<String>? _emulatedCssClass;
  late String _source;

  @ViewChild(EditorRenderTarget)
  EditorRenderTarget? editorRenderTarget;

  @Input()
  set source(String? source) {
    _source = source ?? '';
    editorRenderTarget!.updateRender(_source, classes: _emulatedCssClass);
  }

  @override
  void ngOnInit() {
    Iterable<String> classes =
        editorRenderTarget!.htmlElement.classes.where((String cssClass) => !cssClass.contains('markdown-container'));
    _emulatedCssClass = classes.isNotEmpty ? classes.toList() : [];
    editorRenderTarget!.updateRender(_source, classes: _emulatedCssClass);
  }
}

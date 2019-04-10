import 'package:angular/angular.dart';
import 'package:skawa_components/directives/language_direction_directive.dart';
import 'package:skawa_components/markdown_editor/editor_render_target.dart';
import 'package:skawa_components/markdown_renderer/markdown_renderer.dart';

@Component(
    selector: 'skawa-raw-markdown-renderer',
    templateUrl: 'markdown_renderer.html',
    styles: [':host{display:block}'],
    directives: [EditorRenderTarget, LanguageDirectionDirective],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaRawMarkdownRendererComponent extends SkawaMarkdownRendererComponent {}

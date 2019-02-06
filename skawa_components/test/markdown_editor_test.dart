@TestOn('browser')
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/laminate/popup/module.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:skawa_components/markdown_editor/editor_render_target.dart';
import 'package:skawa_components/markdown_editor/markdown_editor.dart';
import 'package:test/test.dart';
import 'markdown_editor_test.template.dart' as ng;

part 'markdown_editor_test.g.dart';

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);
  group('Markdown Editor', () {
    tearDown(disposeAnyRunningTest);
    final String input = "cica";
    test('can be edited displays data', () async {
      final fixture = await new NgTestBed<AppComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final markdownEditorPage = MarkdownEditorPage.create(context);
      await markdownEditorPage.editMarkdown();
      TextAreaElement textarea = markdownEditorPage.textarea;
      await Future.delayed(emmitDelay);
      expect(markdownEditorPage.markdownContainerDiv.displayed, isFalse);
      expect(textarea.displayed, isTrue);
      expect(textarea.rootElement.properties['value'], initialValue);
    });
    test('can be edited and type', () async {
      final fixture = await new NgTestBed<AppComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final markdownEditorPage = MarkdownEditorPage.create(context);
      await markdownEditorPage.editMarkdown();
      TextAreaElement textarea = markdownEditorPage.textarea;
      await textarea.typing(input);
      await Future.delayed(emmitDelay);
      expect(markdownEditorPage.markdownContainerDiv.displayed, isFalse);
      expect(textarea.displayed, isTrue);
      expect(textarea.rootElement.properties['value'], '$initialValue$input');
    });
    test('can be edited and preview', () async {
      final fixture = await new NgTestBed<AppComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final markdownEditorPage = MarkdownEditorPage.create(context);
      await markdownEditorPage.editMarkdown();
      TextAreaElement textarea = markdownEditorPage.textarea;
      await textarea.typing(input);
      await Future.delayed(emmitDelay);
      await markdownEditorPage.buttons[2].click();
//      expect(markdownEditorPage.markdownContainerDiv.displayed, isTrue);
      expect(markdownEditorPage.markdownContainerDiv.innerText, '$initialValue$input');
    });
  });
}

@PageObject()
@CheckTag('markdown-test')
abstract class MarkdownEditorPage {
  MarkdownEditorPage();

  factory MarkdownEditorPage.create(PageLoaderElement context) = $MarkdownEditorPage.create;

  @First(ByClass('markdown-container'))
  PageLoaderElement get markdownContainerDiv;

  @ByTagName('textarea')
  TextAreaElement get textarea;

  @ByTagName('button')
  List<PageLoaderElement> get buttons;

  Future editMarkdown() async => markdownContainerDiv.click();
}

@PageObject()
abstract class TextAreaElement {
  TextAreaElement();

  factory TextAreaElement.create(PageLoaderElement context) = $TextAreaElement.create;

  @root
  PageLoaderElement get rootElement;

  String get innerText => rootElement.innerText;

  bool get displayed => rootElement.displayed;

  Future typing(String input) async => await rootElement.type(input);
}

@Component(selector: 'markdown-test', template: '''
    <skawa-markdown-editor #editor [initialValue]="initialValue" >
        <div class="placeholder">Nothing to show you yet</div>
    </skawa-markdown-editor>
    <button (click)="editor.renderSource.revertLastUpdate()">Step back</button>
    <button (click)="editor.cancelEdit()">Revert all</button>
    <button (click)="editor.previewMarkdown()">Preview</button>
    <button (click)="editor.editMarkdown()">Edit</button>
   ''', directives: const [
  SkawaMarkdownEditorComponent
], providers: const [
  popupDebugBindings,
  const Provider(EditorRenderer, useClass: MarkdownRenderer),
  ValueProvider(Duration, updateDelay)
], exports: [
  initialValue
])
class AppComponent {
  @ViewChild(SkawaMarkdownEditorComponent)
  SkawaMarkdownEditorComponent markdownEditorComponent;
}

const int updateDelayMS = 9;
const Duration updateDelay = const Duration(milliseconds: updateDelayMS);
const Duration emmitDelay = const Duration(milliseconds: updateDelayMS + 2);
const String initialValue = "hello";

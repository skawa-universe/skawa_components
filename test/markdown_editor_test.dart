@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_components/src/laminate/popup/module.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/src/components/markdown_editor/editor_render_target.dart';
import 'package:skawa_components/src/components/markdown_editor/markdown_editor.dart';
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';

@AngularEntrypoint()
main() {
  group('Markdown Editor', () {
    tearDown(disposeAnyRunningTest);
    test('can be edited displays data', () async {
      final fixture = await new NgTestBed<AppComponent>().create();
      final markdownEditorPage =
          await fixture.resolvePageObject/*<MarkdownEditorPage>*/(
        MarkdownEditorPage,
      );
      await markdownEditorPage.editMarkdown();
      var textarea = await markdownEditorPage.textarea;
      String expectedText =
          await markdownEditorPage.markdownContainerDiv.innerText;
      expect(await markdownEditorPage.markdownContainerDiv.displayed, isFalse);
      expect(await textarea.displayed, isTrue);
      expect(await textarea.seleniumAttributes['value'], expectedText);
    });
    test('can be edited and type', () async {
      final fixture = await new NgTestBed<AppComponent>().create();
      final markdownEditorPage =
          await fixture.resolvePageObject/*<MarkdownEditorPage>*/(
        MarkdownEditorPage,
      );
      await markdownEditorPage.editMarkdown();
      var textarea = await markdownEditorPage.textarea;
      String input = "cica";
      String expectedText =
          "${await textarea.seleniumAttributes['value']}${input}";
      await textarea.typing(input);
      expect(await markdownEditorPage.markdownContainerDiv.displayed, isFalse);
      expect(await textarea.displayed, isTrue);
      expect(await textarea.seleniumAttributes['value'], expectedText);
    });
    test('can be edited and preview', () async {
      final fixture = await new NgTestBed<AppComponent>().create();
      final markdownEditorPage =
          await fixture.resolvePageObject/*<MarkdownEditorPage>*/(
        MarkdownEditorPage,
      );
      await markdownEditorPage.editMarkdown();
      var textarea = await markdownEditorPage.textarea;
      String input = "cica";
      await textarea.typing(input);
      String expectedText =
          "${await markdownEditorPage.markdownContainerDiv.innerText}${input}";
      await markdownEditorPage.buttons[2].click();
      expect(await markdownEditorPage.markdownContainerDiv.displayed, isTrue);
      expect(await markdownEditorPage.markdownContainerDiv.innerText,
          expectedText);
    });
  });
}

class MarkdownEditorPage {
  @inject
  PageLoader loader;

  @FirstByCss('.markdown-container')
  PageLoaderElement markdownContainerDiv;

  Future<TextAreaElement> get textarea =>
      loader.getInstance(TextAreaElement, loader.globalContext);

  @ByTagName('button')
  List<PageLoaderElement> buttons;

  Future editMarkdown() async => markdownContainerDiv.click();
}

@ByTagName('textarea')
class TextAreaElement {
  @root
  PageLoaderElement rootElement;

  Future<String> get innerText => rootElement.innerText;

  Future<bool> get displayed => rootElement.displayed;

  PageLoaderAttributes get seleniumAttributes => rootElement.seleniumAttributes;

  Future typing(String input) async => rootElement.type(input);
}

@Component(
  selector: 'app-cmp',
  template: '''
    <skawa-markdown-editor #editor initialValue="hello">
        <div class="placeholder">Nothing to show you yet</div>
    </skawa-markdown-editor>
    <button (click)="editor.renderSource.revertLastUpdate()">Step back</button>
    <button (click)="editor.cancelEdit()">Revert all</button>
    <button (click)="editor.previewMarkdown()">Preview</button>
    <button (click)="editor.editMarkdown()">Edit</button>  
   ''',
  directives: const [SkawaMarkdownEditorComponent],
  providers: const [
    popupDebugBindings,
    const Provider(EditorRenderer, useClass: MarkdownRenderer)
  ],
)
class AppComponent {
  @ViewChild(SkawaMarkdownEditorComponent)
  SkawaMarkdownEditorComponent markdownEditorComponent;
}

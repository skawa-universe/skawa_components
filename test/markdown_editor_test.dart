@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/laminate/popup/module.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/src/components/markdown_editor/editor_render_target.dart';
import 'package:skawa_components/src/components/markdown_editor/markdown_editor.dart';
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';

@AngularEntrypoint()
void main() {
  group('Markdown Editor', () {
    tearDown(disposeAnyRunningTest);
    final String input = "cica";
    test('can be edited displays data', () async {
      final fixture = await new NgTestBed<AppComponent>().create();
      final markdownEditorPage = await fixture.resolvePageObject/*<MarkdownEditorPage>*/(MarkdownEditorPage);
      await markdownEditorPage.editMarkdown();
      TextAreaElement textarea = await markdownEditorPage.textarea;
      String expectedText = await markdownEditorPage.markdownContainerDiv.innerText;
      expect(markdownEditorPage.markdownContainerDiv.displayed, completion(isFalse));
      expect(textarea.displayed, completion(isTrue));
      expect(textarea.seleniumAttributes['value'], completion(expectedText));
    });
    test('can be edited and type', () async {
      final fixture = await new NgTestBed<AppComponent>().create();
      final markdownEditorPage = await fixture.resolvePageObject/*<MarkdownEditorPage>*/(MarkdownEditorPage);
      await markdownEditorPage.editMarkdown();
      TextAreaElement textarea = await markdownEditorPage.textarea;
      String expectedText = "${await textarea.seleniumAttributes['value']}${input}";
      await textarea.typing(input);
      expect(markdownEditorPage.markdownContainerDiv.displayed, completion(isFalse));
      expect(textarea.displayed, completion(isTrue));
      expect(textarea.seleniumAttributes['value'], completion(expectedText));
    });
    test('can be edited and preview', () async {
      final fixture = await new NgTestBed<AppComponent>().create();
      final markdownEditorPage = await fixture.resolvePageObject/*<MarkdownEditorPage>*/(MarkdownEditorPage);
      await markdownEditorPage.editMarkdown();
      TextAreaElement textarea = await markdownEditorPage.textarea;
      await textarea.typing(input);
      String expectedText = "${await markdownEditorPage.markdownContainerDiv.innerText}${input}";
      await markdownEditorPage.buttons[2].click();
      expect(markdownEditorPage.markdownContainerDiv.displayed, completion(isTrue));
      expect(markdownEditorPage.markdownContainerDiv.innerText, completion(expectedText));
    });
  });
}

class MarkdownEditorPage {
  @inject
  PageLoader loader;

  @FirstByCss('.markdown-container')
  PageLoaderElement markdownContainerDiv;

  Future<TextAreaElement> get textarea => loader.getInstance(TextAreaElement, loader.globalContext);

  @ByTagName('button')
  List<PageLoaderElement> buttons;

  Future editMarkdown() async => markdownContainerDiv.click();
}

@ByTagName('textarea')
class TextAreaElement {
  @root
  PageLoaderElement rootElement;

  Future<String> get innerText async => await rootElement.innerText;

  Future<bool> get displayed async => await rootElement.displayed;

  PageLoaderAttributes get seleniumAttributes => rootElement.seleniumAttributes;

  Future typing(String input) async => await rootElement.type(input);
}

@Component(
  selector: 'app-cmp',
  template: '''
    <skawa-markdown-editor #editor initialValue="hello" [updateDelay]="updateDelay">
        <div class="placeholder">Nothing to show you yet</div>
    </skawa-markdown-editor>
    <button (click)="editor.renderSource.revertLastUpdate()">Step back</button>
    <button (click)="editor.cancelEdit()">Revert all</button>
    <button (click)="editor.previewMarkdown()">Preview</button>
    <button (click)="editor.editMarkdown()">Edit</button>  
   ''',
  directives: const [SkawaMarkdownEditorComponent],
  providers: const [popupDebugBindings, const Provider(EditorRenderer, useClass: MarkdownRenderer)],
)
class AppComponent {
  @ViewChild(SkawaMarkdownEditorComponent)
  SkawaMarkdownEditorComponent markdownEditorComponent;

  Duration updateDelay = new Duration(milliseconds: 100);
}

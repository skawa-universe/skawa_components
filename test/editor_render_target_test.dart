@Tags(const ['aot'])
@TestOn('browser')
import 'editor_artifacts.dart';
import 'package:pageloader/objects.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/src/components/markdown_editor/editor_render_target.dart';
import 'package:test/test.dart';
import 'package:angular2/core.dart';
import 'package:angular_test/angular_test.dart';

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);
  group('EditorRenderTarget | ', () {
    test('can be edited displays data', () async {
      final fixture = await new NgTestBed<TestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.counter.click();
      expect(pageObject.renderTarget.innerText, completion(isEmpty));
    });
    test('can be edited displays data', () async {
      final fixture = await new NgTestBed<TestComponent>()
          .create(beforeChangeDetection: (testElement) => testElement.content = '<div> Cat <span>Lion</span></div>');
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.counter.click();
      await fixture.update((testElement) {
        expect(testElement.editorRenderTarget.elementRef.nativeElement.innerHtml, '<div> Cat <span>Lion</span></div>');
        expect(testElement.editorRenderTarget.elementRef.nativeElement.text, ' Cat Lion');
        testElement.editorRenderTarget.elementRef.nativeElement.children.forEach((child) {
          expect(child.classes, isEmpty);
        });
      });
      expect(pageObject.counter.visibleText, completion('1'));
    });
    test('can be edited displays data', () async {
      final fixture = await new NgTestBed<TestComponent>().create(beforeChangeDetection: (testElement) {
        testElement.content = '<div> Cat <span>Lion</span></div>';
      });
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement.content = '''
         <ul>
            <li> Cat</li>
            <li> Dog</li>
          </ul>
         ''';
        testElement.cssClasses = ['cat', 'lion'];
      });
      await pageObject.counter.click();
      await fixture.update((testElement) {
        expect(
            testElement.editorRenderTarget.elementRef.nativeElement.innerHtml,
            '         <ul class="cat lion">\n'
            '            <li> Cat</li>\n'
            '            <li> Dog</li>\n'
            '          </ul>\n'
            '         ');
        expect(
            testElement.editorRenderTarget.elementRef.nativeElement.text,
            '         \n'
            '             Cat\n'
            '             Dog\n'
            '          \n'
            '         ');
        testElement.editorRenderTarget.elementRef.nativeElement.children.forEach((child) {
          expect(child.classes.contains('cat'), isTrue);
          expect(child.classes.contains('lion'), isTrue);
        });
      });
      expect(pageObject.counter.visibleText, completion('1'));
    });
  });
}

@Component(
    selector: 'test',
    template: '''
    <div class="editorRenderTarget" editorRenderTarget (render)="counter()" #f="editorRenderTarget"></div>
    <div class="counter" (click)="update()">{{renderCount}}</div>
  ''',
    directives: const [EditorRenderTarget],
    providers: const [const Provider(EditorRenderer, useClass: MockRenderer)])
class TestComponent {
  int renderCount = 0;
  String content;
  List<String> cssClasses = [];

  void counter() {
    renderCount++;
  }

  void update() {
    editorRenderTarget.updateRender(content, classes: cssClasses);
  }

  @ViewChild(EditorRenderTarget)
  EditorRenderTarget editorRenderTarget;
}

@EnsureTag('test')
class TestPO {
  @ByCss('[editorRenderTarget]')
  PageLoaderElement renderTarget;

  @ByCss('.counter')
  PageLoaderElement counter;
}

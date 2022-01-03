// @dart=2.10
@TestOn('browser')
import 'package:pageloader/html.dart';
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:skawa_components/markdown_editor/editor_render_target.dart';
import 'package:test/test.dart';

import 'editor_artifacts.dart';
import 'editor_render_target_test.template.dart' as ng;

part 'editor_render_target_test.g.dart';

@GenerateInjector([ClassProvider(EditorRenderer, useClass: MockRenderer)])
final InjectorFactory rootInjector = ng.rootInjector$Injector;

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);
  group('EditorRenderTarget | ', () {
    test('can be edited displays data', () async {
      final fixture = await NgTestBed<TestComponent>(ng.TestComponentNgFactory, rootInjector: rootInjector).create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      await pageObject.counter.click();
      expect(pageObject.renderTarget.innerText, isEmpty);
    });
    test('can be edited displays data', () async {
      final fixture = await NgTestBed<TestComponent>(ng.TestComponentNgFactory, rootInjector: rootInjector)
          .create(beforeChangeDetection: (testElement) => testElement.content = '<div> Cat <span>Lion</span></div>');
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      await pageObject.counter.click();
      expect(pageObject.renderTarget.innerText, 'Cat Lion');
      await fixture.update();
      expect(fixture.assertOnlyInstance.renderedContent, '<div> Cat <span>Lion</span></div>');
      fixture.assertOnlyInstance.editorRenderTarget.htmlElement.children
          .forEach((child) => expect(child.classes, isEmpty));
    });
    test('can be edited displays data', () async {
      final fixture =
          await NgTestBed<TestComponent>(ng.TestComponentNgFactory).create(beforeChangeDetection: (testElement) {
        testElement.content = '<div> Cat <span>Lion</span></div>';
      });
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
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
      await fixture.update();
      expect(
          fixture.assertOnlyInstance.renderedContent,
          '         <ul>\n'
          '            <li> Cat</li>\n'
          '            <li> Dog</li>\n'
          '          </ul>\n'
          '         ');
      expect(
          pageObject.renderTarget.innerText,
          'Cat\n'
          '             Dog');
      fixture.assertOnlyInstance.editorRenderTarget.htmlElement.children.forEach((child) {
        expect(child.classes.contains('cat'), isTrue);
        expect(child.classes.contains('lion'), isTrue);
      });
    });
  });
}

@Component(selector: 'test', template: '''
    <div class="editorRenderTarget" editorRenderTarget (render)="counter(\$event)" #f="editorRenderTarget"></div>
    <div class="counter" (click)="update()">{{renderedContent}}</div>
  ''', directives: [EditorRenderTarget], providers: [ClassProvider(EditorRenderer, useClass: HtmlRenderer)])
class TestComponent {
  String content = "";
  String renderedContent;
  List<String> cssClasses = [];

  void counter(String newTarget) => renderedContent = newTarget;

  void update() => editorRenderTarget.updateRender(content, classes: cssClasses);

  @ViewChild(EditorRenderTarget)
  EditorRenderTarget editorRenderTarget;
}

@PageObject()
@CheckTag('test')
abstract class TestPO {
  TestPO();

  factory TestPO.create(PageLoaderElement context) = $TestPO.create;

  @ByCss('[editorRenderTarget]')
  PageLoaderElement get renderTarget;

  @ByClass('counter')
  PageLoaderElement get counter;
}

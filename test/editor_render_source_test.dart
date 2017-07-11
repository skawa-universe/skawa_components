@Tags(const ['aot'])
@TestOn('browser')
import 'package:pageloader/objects.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/src/components/markdown_editor/editor_render_source.dart';
import 'package:test/test.dart';
import 'package:angular2/core.dart';
import 'package:angular_test/angular_test.dart';


@AngularEntrypoint()
main() {
  tearDown(disposeAnyRunningTest);
  group('EditorRenderSource', () {
    test('', () async {
      final fixture = await
      new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject /*<TestPO>*/(TestPO,);
      await fixture.update((testElement) async {
        expect(testElement.initialValue, testElement.renderSource.previousValue);
      });
    });
    test('', () async {
      final fixture = await
      new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject /*<TestPO>*/(TestPO,);
      await fixture.update((testElement) async {
        testElement.renderSource.value = 'first';
      });
      await pageObject.div.click();
      await fixture.update((testElement) async {
        expect(testElement.initialValue, testElement.renderSource.value);
      });
    });
    test('', () async {
      final fixture = await
      new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject /*<TestPO>*/(TestPO,);
      await fixture.update((testElement) async {
        testElement.renderSource.value = 'first';
        testElement.renderSource.value = 'second';
      });
      await pageObject.span.click();
      await fixture.update((testElement) async {
        expect(testElement.initialValue, testElement.renderSource.value);
      });
    });
    test('', () async {
      final fixture = await
      new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject /*<TestPO>*/(TestPO,);
      await fixture.update((testElement) async {
        testElement.renderSource.value = 'first';
      });
      await pageObject.div.click();
      await pageObject.div.click();
      await fixture.update((testElement) async {
        expect(testElement.initialValue, testElement.renderSource.value);
      });
    });
    test('', () async {
      final fixture = await
      new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject /*<TestPO>*/(TestPO,);
      await fixture.update((testElement) async {
        testElement.renderSource.value = 'first';
        testElement.renderSource.value = 'second';
      });
      await pageObject.span.click();
      await pageObject.span.click();
      await fixture.update((testElement) async {
        expect(testElement.initialValue, testElement.renderSource.value);
      });
    });
    test('', () async {
      final fixture = await
      new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject /*<TestPO>*/(TestPO,);
      await fixture.update((testElement) async {
        testElement.renderSource.value = 'first';
        testElement.renderSource.value = 'second';
      });
      await pageObject.div.click();
      await fixture.update((testElement) async {
        expect(testElement.renderSource.onUpdated, emits('first'));
      });
    });
    test('', () async {
      final fixture = await
      new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject /*<TestPO>*/(TestPO,);
      await fixture.update((testElement) async {
        testElement.renderSource.value = 'first';
        testElement.renderSource.value = 'second';
      });
      await pageObject.span.click();
      fixture.update((testElement) async {
        await expect(testElement.renderSource.onUpdated, emits('some initial content'));
      });
    });
    test('', () async {
      final fixture = await
      new NgTestBed<RenderSourceTemplateComponent>().create();
      final pageObject = await fixture.resolvePageObject /*<TestPO>*/(TestPO,);
      fixture.update((testElement) async {
        await expect(testElement.renderSource.previousValue, isNull);
      });
    });
    test('', () async {
      final fixture = await
      new NgTestBed<RenderSourceTemplateComponent>().create();
      final pageObject = await fixture.resolvePageObject /*<TestPO>*/(TestPO,);
      await fixture.update((testElement) async {
        testElement.renderSource.value = 'first';
        testElement.renderSource.value = 'second';
      });
      await pageObject.span.click();
      fixture.update((testElement) async {
        await expect(testElement.renderSource.previousValue, isNull);
      });
    });
  });
}

@Component(
    selector: 'test',
    template: '''
    <textarea editorRenderSource #f="editorRenderSource" [initialValue]="initialValue" (update)="update=\$event;"></textarea>
    <div (click)="f.revertLastUpdate()">{{update}}</div>
    <span (click)="f.revertAllUpdates()"></span>
  ''',
    directives: const [EditorRenderSource])
class RenderSourceTemplateComponent {
  String initialValue;
  String update;

  @ViewChild(EditorRenderSource)
  EditorRenderSource renderSource;
}

@EnsureTag('test')
class TestPO {
  @ByTagName('textarea')
  PageLoaderElement editorRenderSource;

  @ByTagName('div')
  PageLoaderElement div;

  @ByTagName('span')
  PageLoaderElement span;
}

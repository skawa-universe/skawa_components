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
  group('EditorRenderSource | ', () {
    test('', () async {
      final fixture = await new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) async {
        expect(testElement.initialValue, testElement.renderSource.previousValue);
      });
    });
    test('with initial value can revert last update', () async {
      final fixture = await new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) async {
        testElement.initialValue = 'first';
      });
      await pageObject.div.click();
      await fixture.update((testElement) async {
        expect(testElement.initialValue, testElement.renderSource.value);
      });
    });
    test('with initial value can revert all updates', () async {
      final fixture = await new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) async {
        testElement.initialValue = 'first';
        testElement.initialValue = 'second';
      });
      await pageObject.span.click();
      await fixture.update((testElement) async {
        expect(testElement.initialValue, testElement.renderSource.value);
      });
    });
    test('with initial value can\'t revert beyond initial value with revertLastUpdate', () async {
      final fixture = await new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) async {
        testElement.renderSource.value = 'first';
      });
      await pageObject.div.click();
      await pageObject.div.click();
      await fixture.update((testElement) async {
        expect(testElement.initialValue, testElement.renderSource.value);
      });
    });
    test('with initial value can\'t revert beyond initial value with revertAllUpdates', () async {
      final fixture = await new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) async {
        testElement.initialValue = 'first';
        testElement.initialValue = 'second';
      });
      await pageObject.span.click();
      await pageObject.span.click();
      await fixture.update((testElement) async {
        expect(testElement.initialValue, testElement.renderSource.value);
      });
    });
    test('with initial value revertLastUpdate emits change', () async {
      final fixture = await new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) async {
        testElement.initialValue = 'first';
        testElement.initialValue = 'second';
      });
      await pageObject.div.click();
      await fixture.update((testElement) async {
        await expect(testElement.renderSource.onUpdated, emits('first'));
      });
    });
    test('with initial value revertAllUpdates emits change', () async {
      final fixture = await new NgTestBed<RenderSourceTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.initialValue = "some initial content";
      });
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) async {
        testElement.initialValue = 'first';
        testElement.initialValue = 'second';
      });
      await pageObject.span.click();
      fixture.update((testElement) async {
        await expect(testElement.renderSource.onUpdated, emits('some initial content'));
      });
    });
    test('without initial value initialized to empty', () async {
      final fixture = await new NgTestBed<RenderSourceTemplateComponent>().create();
      await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) async {
        await expect(testElement.renderSource.previousValue, isNull);
      });
    });
    test('without initial value can revert to empty', () async {
      final fixture = await new NgTestBed<RenderSourceTemplateComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) async {
        testElement.initialValue = 'first';
        testElement.initialValue = 'second';
      });
      await pageObject.span.click();
      await fixture.update((testElement) async {
        await expect(testElement.renderSource.onUpdated, emits(null));
      });
    });
  });
}

@Component(
    selector: 'test',
    template: '''
    <textarea editorRenderSource #f="editorRenderSource" [initialValue]="initialValue" (update)="updateUpdate(\$event)"></textarea>
    <div (click)="f.revertLastUpdate()">{{update}}</div>
    <span (click)="f.revertAllUpdates()"></span>
  ''',
    directives: const [EditorRenderSource])
class RenderSourceTemplateComponent {
  String initialValue;
  String update;

  void updateUpdate(event) {
    update = event;
  }

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

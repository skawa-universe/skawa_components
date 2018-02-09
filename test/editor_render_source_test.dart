@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:pageloader/objects.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/src/components/markdown_editor/editor_render_source.dart';
import 'package:test/test.dart';
import 'package:angular2/core.dart';
import 'package:angular_test/angular_test.dart';

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);
  final testBed = new NgTestBed<RenderSourceTemplateComponent>();
  NgTestFixture<RenderSourceTemplateComponent> fixture;
  TestPO pageObject;
  final String _first = 'first';
  final String _second = 'second';
  final String _initialValue = "some initial content";
  group('EditorRenderSource | without initial value ', () {
    setUp(() async {
      fixture = await new NgTestBed<RenderSourceTemplateComponent>().create();
      pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
    });
    test('initialized to empty', () async {
      await fixture.update((testComponent) async => expect(await testComponent.renderSource.onUpdated.isEmpty, isNull));
    });
    test('can revert to empty', () async {
      await pageObject.type(_first);
      await pageObject.type(_second);
      await pageObject.revertAllUpdates();
      await fixture.update((testComponent) => expect(testComponent.renderSource.onUpdated, mayEmit(isEmpty)));
    });
  });
  group('EditorRenderSource | with initial value ', () {
    setUp(() async {
      fixture = await testBed.create(beforeChangeDetection: (testElement) => testElement.initialValue = _initialValue);
      pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
    });
    test('initialization', () async {
      await fixture.update((testComponent) async => expect(await testComponent.renderSource.onUpdated.isEmpty, isNull));
    });
    test('revertLastUpdate emits change', () async {
      await pageObject.type(_first);
      await pageObject.type(_second);
      await pageObject.revertLastUpdate();
      await fixture
          .update((testComponent) => expect(testComponent.renderSource.onUpdated, mayEmit('$_initialValue$_first')));
    });
    test('can\'t revert beyond initial value with revertLastUpdate', () async {
      await pageObject.type(_first);
      await pageObject.revertLastUpdate();
      await pageObject.revertLastUpdate();
      await fixture.update((testComponent) => expect(testComponent.renderSource.onUpdated, mayEmit(_initialValue)));
    });
    test('can revert all updates', () async {
      await pageObject.type(_first);
      await pageObject.type(_second);
      await pageObject.revertAllUpdates();
      await fixture.update((testComponent) => expect(testComponent.renderSource.onUpdated, mayEmit(_initialValue)));
    });
    test('can\'t revert beyond initial value with revertAllUpdates', () async {
      await pageObject.type(_first);
      await pageObject.revertAllUpdates();
      await pageObject.revertAllUpdates();
      await fixture.update((testComponent) => expect(testComponent.renderSource.onUpdated, mayEmit(_initialValue)));
    });
  });
}

@Component(
    selector: 'test',
    template: '''
    <textarea editorRenderSource #f="editorRenderSource" [initialValue]="initialValue"></textarea>
    <div (click)="f.revertLastUpdate()"></div>
    <span (click)="f.revertAllUpdates()"></span>
              ''',
    directives: const [EditorRenderSource])
class RenderSourceTemplateComponent {
  String initialValue;

  @ViewChild(EditorRenderSource)
  EditorRenderSource renderSource;
}

@EnsureTag('test')
class TestPO {
  @ByTagName('textarea')
  PageLoaderElement _editorRenderSource;

  Future clear() async => _editorRenderSource.clear();

  Future type(String s) => _editorRenderSource.type(s);

  Future revertLastUpdate() => _div.click();

  Future revertAllUpdates() => _span.click();

  Future<String> actualValue() => _div.innerText;

  @ByTagName('div')
  PageLoaderElement _div;

  @ByTagName('span')
  PageLoaderElement _span;
}

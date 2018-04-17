@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:pageloader/objects.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/markdown_editor/editor_render_source.dart';
import 'package:test/test.dart';
import 'package:angular/core.dart';
import 'package:angular_test/angular_test.dart';

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
      fixture = await testBed.create();
      pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
    });
    test('initialized to empty', () async {
      await fixture.update((testComponent) async => expect(await testComponent.renderSource.onUpdated.isEmpty, isNull));
    });
    test('can revert to empty', () async {
      await pageObject.type(_first);
      await pageObject.type(_second);
      await pageObject.revertAllUpdates();
      await fixture.update((testComponent) async => expect(await testComponent.renderSource.onUpdated.isEmpty, isTrue));
    }, tags: 'flaky-on-travis');
  });
  group('EditorRenderSource | with initial value ', () {
    setUp(() async {
      fixture = await testBed.create(beforeChangeDetection: (testElement) => testElement.initialValue = _initialValue);
      pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
    });
    test('initialization', () async {
      await fixture.update((testComponent) async => expect(await testComponent.renderSource.onUpdated.isEmpty, isTrue));
    });
    test('revertLastUpdate emits change', () async {
      await pageObject.type(_first);
      await pageObject.type(_second);
      await pageObject.revertLastUpdate();
      await fixture.update(
          (testComponent) async => expect(await testComponent.renderSource.onUpdated.last, '$_initialValue$_first'));
    });
    test('can\'t revert beyond initial value with revertLastUpdate', () async {
      await pageObject.type(_first);
      await pageObject.revertLastUpdate();
      await pageObject.revertLastUpdate();
      await fixture
          .update((testComponent) async => expect(await testComponent.renderSource.onUpdated.last, _initialValue));
    });
    test('can revert all updates', () async {
      await pageObject.type(_first);
      await pageObject.type(_second);
      await pageObject.revertAllUpdates();
      await fixture.update((testComponent) async =>
          await expect(await testComponent.renderSource.onUpdated.contains(_initialValue), isTrue));
    });
    test('can\'t revert beyond initial value with revertAllUpdates', () async {
      await pageObject.type(' 1');
      await pageObject.type(' 2');
      await pageObject.type(' 3');
      await pageObject.type(' 4');
      await pageObject.type(' 5');
      await pageObject.type(' 6');
      await pageObject.type(' 7');
      await pageObject.type(' 8');
      await pageObject.type(' 9');
      await pageObject.type(' 10');
      await pageObject.type(' 11');
      await pageObject.type(' 12');
      await pageObject.type(' 13');
      await pageObject.revertAllUpdates();
      await pageObject.revertAllUpdates();
      await fixture.update(
          (testComponent) async => await expect(await testComponent.renderSource.onUpdated.last, _initialValue));
    });
  });
}

@Component(
    selector: 'test',
    template: '''
    <textarea editorRenderSource [initialValue]="initialValue" [updateDelay]="updateDelay"></textarea>
    <button revertLastUpdate (click)="renderSource.revertLastUpdate()"></button>
    <button revertAllUpdates (click)="renderSource.revertAllUpdates()"></button>
              ''',
    directives: const [EditorRenderSource],
    changeDetection: ChangeDetectionStrategy.OnPush)
class RenderSourceTemplateComponent {
  String initialValue;

  Duration updateDelay = new Duration(milliseconds: 100);

  @ViewChild(EditorRenderSource)
  EditorRenderSource renderSource;
}

@EnsureTag('test')
class TestPO {
  @ByTagName('textarea')
  PageLoaderElement _editorRenderSource;

  Future clear() async => await _editorRenderSource.clear();

  Future type(String s) async => await _editorRenderSource.type(s);

  Future revertLastUpdate() async => await _revertLastUpdate.click();

  Future revertAllUpdates() async => await _revertAllUpdates.click();

  Future<String> actualValue() async => await _revertLastUpdate.innerText;

  @ByTagName('[revertLastUpdate]')
  PageLoaderElement _revertLastUpdate;

  @ByTagName('[revertAllUpdates]')
  PageLoaderElement _revertAllUpdates;
}

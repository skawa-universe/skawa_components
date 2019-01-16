@TestOn('browser')
import 'dart:async';
import 'package:pageloader/html.dart';
import 'package:skawa_components/markdown_editor/editor_render_source.dart';
import 'package:test/test.dart';
import 'package:angular/core.dart';
import 'package:angular_test/angular_test.dart';
import 'editor_render_source_test.template.dart' as ng;

part 'editor_render_source_test.g.dart';

void main() {
  ng.initReflector();
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
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      pageObject = TestPO.create(context);
    });
    test('initialized to empty', () async {
      expect(fixture.assertOnlyInstance.updates.length, 1);
      expect(fixture.assertOnlyInstance.updates.last, isNull);
    });
    test('can revert to empty', () async {
      await pageObject.type(_first);
      await pageObject.type(_second);
      await pageObject.revertAllUpdates();
      await Future.delayed(Duration(milliseconds: 101));
      expect(fixture.assertOnlyInstance.updates.length, 3);
      expect(fixture.assertOnlyInstance.updates.last, null);
    });
  });
  group('EditorRenderSource | with initial value ', () {
    setUp(() async {
      fixture = await testBed.create(beforeChangeDetection: (testElement) => testElement.initialValue = _initialValue);
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      pageObject = TestPO.create(context);
    });
    test('initialization', () async {
      expect(fixture.assertOnlyInstance.updates.length, 1);
      expect(fixture.assertOnlyInstance.updates.last, _initialValue);
    });
    test('revertLastUpdate emits change', () async {
      await pageObject.type(_first);
      await pageObject.type(_second);
      await pageObject.revertLastUpdate();
      await Future.delayed(Duration(milliseconds: 101));
      expect(fixture.assertOnlyInstance.updates.length, 3);
      expect(fixture.assertOnlyInstance.updates.last, '$_first$_second');
    });
    test('can\'t revert beyond initial value with revertLastUpdate', () async {
      await pageObject.type(_first);
      await pageObject.revertLastUpdate();
      await pageObject.revertLastUpdate();
      await Future.delayed(Duration(milliseconds: 101));
      expect(fixture.assertOnlyInstance.updates.length, 3);
      expect(fixture.assertOnlyInstance.updates.last, _initialValue);
    });
    test('can revert all updates', () async {
      await pageObject.type(_first);
      await pageObject.type(_second);
      await pageObject.revertAllUpdates();
      await Future.delayed(Duration(milliseconds: 101));
      expect(fixture.assertOnlyInstance.updates.length, 3);
      expect(fixture.assertOnlyInstance.updates.last, _initialValue);
    });
    test('can\'t revert beyond initial value with revertAllUpdates', () async {
      await pageObject.type('1');
      await pageObject.type('2');
      await pageObject.type('3');
      await pageObject.type('4');
      await Future.delayed(Duration(milliseconds: 101));
      await pageObject.type('5');
      await pageObject.type('6');
      await pageObject.type('7');
      await Future.delayed(Duration(milliseconds: 101));
      await pageObject.type('8');
      await pageObject.type('9');
      await Future.delayed(Duration(milliseconds: 101));
      await pageObject.type('10');
      await pageObject.type('11');
      await pageObject.type('12');
      await Future.delayed(Duration(milliseconds: 101));
      await pageObject.type(' 13');
      await pageObject.revertAllUpdates();
      await pageObject.revertAllUpdates();
      await Future.delayed(Duration(milliseconds: 101));
      expect(fixture.assertOnlyInstance.updates.length, 7);
      expect(fixture.assertOnlyInstance.updates.last, _initialValue);
    });
  });
}

@Component(selector: 'test', template: '''
    <textarea editorRenderSource [initialValue]="initialValue" [updateDelay]="updateDelay" (update)="update(\$event)">
    </textarea>
    <button revertLastUpdate (click)="renderSource.revertLastUpdate()"></button>
    <button revertAllUpdates (click)="renderSource.revertAllUpdates()"></button>
    ''', directives: const [EditorRenderSource])
class RenderSourceTemplateComponent {
  String initialValue;
  Duration updateDelay = new Duration(milliseconds: 100);
  List<String> updates = [];

  @ViewChild(EditorRenderSource)
  EditorRenderSource renderSource;

  void update(String lastUpdate) => updates.add(lastUpdate);
}

@PageObject()
@CheckTag('test')
abstract class TestPO {
  TestPO();

  factory TestPO.create(PageLoaderElement context) = $TestPO.create;

  @ByTagName('textarea')
  PageLoaderElement get editorRenderSource;

  Future<void> clear() async => await editorRenderSource.clear();

  Future<void> type(String s) async => await editorRenderSource.type(s);

  Future<void> revertLastUpdate() async => await _revertLastUpdate.click();

  Future<void> revertAllUpdates() async => await _revertAllUpdates.click();

  String actualValue() => _revertLastUpdate.innerText;

  @ByTagName('[revertLastUpdate]')
  PageLoaderElement get _revertLastUpdate;

  @ByTagName('[revertAllUpdates]')
  PageLoaderElement get _revertAllUpdates;
}

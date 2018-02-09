@Tags(const ['aot'])
@TestOn('browser')
import 'package:pageloader/objects.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:test/test.dart';
import 'package:angular2/core.dart';
import 'package:angular_test/angular_test.dart';

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);
  final testBed = new NgTestBed<RenderSourceTemplateComponent>();
  NgTestFixture<RenderSourceTemplateComponent> fixture;
  TestPO pageObject;
  group('Test | 1X | ', () {
    setUp(() async {
      fixture = await testBed.create();
      pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
    });
    test('1X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('2X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('3X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('4X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('5X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('6X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('7X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('8X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
  });
  group('Test | 2X | ', () {
    setUp(() async {
      fixture = await testBed.create();
      pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
    });
    test('1X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('2X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('3X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('4X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('5X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('6X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('7X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('8X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
  });
  group('Test | 3X | ', () {
    setUp(() async {
      fixture = await testBed.create();
      pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
    });
    test('1X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('2X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('3X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('4X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('5X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('6X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('7X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('8X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
  });
  group('Test | 4X | ', () {
    setUp(() async {
      fixture = await testBed.create();
      pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
    });
    test('1X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('2X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('3X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('4X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('5X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('6X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('7X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('8X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
  });
  group('Test | 5X | ', () {
    setUp(() async {
      fixture = await testBed.create();
      pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
    });
    test('1X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('2X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('3X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('4X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('5X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('6X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('7X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
    test('8X', () async {
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      await pageObject.div.click();
      expect(await pageObject.div.innerText, 'Test button');
    });
  });
}

@Component(
  selector: 'test',
  template: '''<div>Test button</div>''',
)
class RenderSourceTemplateComponent {}

@EnsureTag('test')
class TestPO {
  @ByTagName('div')
  PageLoaderElement div;
}

@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/src/components/infobar/infobar.dart';
import 'package:test/test.dart';

@AngularEntrypoint()
Future main() async {
  tearDown(disposeAnyRunningTest);
  group('Infobar | ', () {
    test('initialization with zero input', () async {
      final fixture = await new NgTestBed<InfobarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      expect(await pageObject.trigger.innerText, '0');
      expect(await pageObject.infobar.glyph.innerText, '');
    });
    test('initialization with icon', () async {
      final fixture = await new NgTestBed<InfobarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement.icon = 'code';
      });
      expect(await pageObject.trigger.innerText, 0.toString());
      expect(await pageObject.infobar.glyph.innerText, 'code');
    });
    test('initialization with url', () async {
      final fixture = await new NgTestBed<InfobarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement.url = 'https://github.com/skawa-universe/skawa_components/';
      });
      expect(await pageObject.trigger.innerText, 0.toString());
      expect(await pageObject.infobar.materialButton.attributes['title'],
          'https://github.com/skawa-universe/skawa_components/');
      expect(await pageObject.infobar.glyph.innerText, '');
    });
    test('initialization with url and url', () async {
      final fixture = await new NgTestBed<InfobarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement.icon = 'code';
        testElement.url = 'https://github.com/skawa-universe/skawa_components/';
      });
      expect(await pageObject.trigger.innerText, 0.toString());
      expect(await pageObject.infobar.materialButton.attributes['title'],
          'https://github.com/skawa-universe/skawa_components/');
      expect(await pageObject.infobar.glyph.innerText, 'code');
    });
    test('initialization with url then click 1X on the infobar button', () async {
      final fixture = await new NgTestBed<InfobarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement.url = 'https://github.com/skawa-universe/skawa_components/';
      });
      await pageObject.infobar.materialButton.click();
      expect(await pageObject.trigger.innerText, 1.toString());
      expect(await pageObject.infobar.materialButton.attributes['title'],
          'https://github.com/skawa-universe/skawa_components/');
      expect(await pageObject.infobar.glyph.innerText, '');
    });
    test(' with url then click 4X on the infobar button', () async {
      print('before create');
      final fixture = await new NgTestBed<InfobarTestComponent>().create();
      print('before resolve');
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      print('before 1x click');
      await pageObject.infobar.materialButton.click();
      print('before 2x click');
      await pageObject.infobar.materialButton.click();
      print('before 3x click');
      await pageObject.infobar.materialButton.click();
      print('before 4x click');
      await pageObject.infobar.materialButton.click();
      print('before 1x expect');
      expect(await pageObject.trigger.innerText, 4.toString());
      print('before 2x expect');
      expect(await pageObject.infobar.materialButton.attributes['title'], '');
      print('before 3x expect');
      expect(await pageObject.infobar.glyph.innerText, '');
      print('end');
    });
  });
}

@Component(
  selector: 'test',
  template: '''
    <skawa-infobar [icon]="icon" [url]="url" (trigger)="increment()"></skawa-infobar>
    <div increment>{{triggered}}</div>
     ''',
  directives: const [
    SkawaInfobarComponent,
  ],
)
class InfobarTestComponent {
  String icon;
  String url;

  int triggered = 0;

  void increment() {
    triggered = triggered + 1;
  }
}

@EnsureTag('test')
class TestPO {
  @ByTagName('skawa-infobar')
  InforbarPO infobar;

  @ByTagName('[increment]')
  PageLoaderElement trigger;
}

class InforbarPO {
  @ByTagName('material-button')
  PageLoaderElement materialButton;

  @ByTagName('glyph')
  PageLoaderElement glyph;
}

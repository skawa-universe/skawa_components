@Tags(const ['aot'])
@TestOn('browser')
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/infobar/infobar.dart';
import 'package:test/test.dart';

void main() {
  tearDown(disposeAnyRunningTest);
  group('Infobar | ', () {
    final String testLink = 'https://github.com/skawa-universe/skawa_components/';
    final String materialIcon = 'code';
    test('initialization with zero input', () async {
      final fixture = await new NgTestBed<InfobarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      expect(pageObject.trigger.innerText, completion(0.toString()));
      expect(pageObject.infobar.materialIcon.innerText, completion(isEmpty));
    });
    test('initialization with icon', () async {
      final fixture = await new NgTestBed<InfobarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) => testElement.icon = materialIcon);
      expect(pageObject.trigger.innerText, completion(0.toString()));
      expect(pageObject.infobar.materialIcon.innerText, completion(materialIcon));
    });
    test('initialization with url', () async {
      final fixture = await new NgTestBed<InfobarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) => testElement.url = testLink);
      expect(pageObject.trigger.innerText, completion(0.toString()));
      expect(pageObject.infobar.materialButton.attributes['title'], completion(testLink));
      expect(pageObject.infobar.materialIcon.innerText, completion(isEmpty));
    });
    test('initialization with url and url', () async {
      final fixture = await new NgTestBed<InfobarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement.icon = materialIcon;
        testElement.url = testLink;
      });
      expect(pageObject.trigger.innerText, completion(0.toString()));
      expect(pageObject.infobar.materialButton.attributes['title'], completion(testLink));
      expect(pageObject.infobar.materialIcon.innerText, completion(materialIcon));
    });
    test('initialization with url then click 1X on the infobar button', () async {
      final fixture = await new NgTestBed<InfobarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) => testElement.url = testLink);
      await pageObject.infobar.materialButton.click();
      expect(pageObject.trigger.innerText, completion(1.toString()));
      expect(pageObject.infobar.materialButton.attributes['title'], completion(testLink));
      expect(pageObject.infobar.materialIcon.innerText, completion(isEmpty));
    });
    test(' with url then click 3X on the infobar button', () async {
      final fixture = await new NgTestBed<InfobarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.infobar.materialButton.click();
      await pageObject.infobar.materialButton.click();
      await pageObject.infobar.materialButton.click();
      expect(pageObject.trigger.innerText, completion(3.toString()));
      expect(pageObject.infobar.materialButton.attributes['title'], completion(''));
      expect(pageObject.infobar.materialIcon.innerText, completion(isEmpty));
    }, tags: 'flaky-on-travis');
  });
}

@Component(
  selector: 'test',
  template: '''
    <skawa-infobar [icon]="icon" [url]="url" (trigger)="increment()"></skawa-infobar>
    <div increment>{{triggered}}</div>
     ''',
  directives: const [SkawaInfobarComponent],
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

  @ByTagName('material-icon')
  PageLoaderElement materialIcon;
}

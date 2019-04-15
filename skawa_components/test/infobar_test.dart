@TestOn('browser')
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:skawa_components/infobar/infobar.dart';
import 'package:test/test.dart';
import 'infobar_test.template.dart' as ng;

part 'infobar_test.g.dart';

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);
  final testBed = NgTestBed<InfobarTestComponent>();
  NgTestFixture<InfobarTestComponent> fixture;
  TestPO pageObject;
  group('Infobar | ', () {
    setUp(() async {
      fixture = await testBed.create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      pageObject = TestPO.create(context);
    });
    final String testLink = 'https://github.com/skawa-universe/skawa_components/';
    final String materialIcon = 'code';
    test('initialization with zero input', () async {
      expect(pageObject.trigger.innerText, 0.toString());
      expect(pageObject.infobar.materialIcon.innerText, isEmpty);
    });
    test('initialization with icon', () async {
      await fixture.update((testElement) => testElement.icon = materialIcon);
      expect(pageObject.trigger.innerText, 0.toString());
      expect(pageObject.infobar.materialIcon.innerText, materialIcon);
    });
    test('initialization with url', () async {
      await fixture.update((testElement) => testElement.url = testLink);
      expect(pageObject.trigger.innerText, 0.toString());
      expect(pageObject.infobar.materialButton.attributes['title'], testLink);
      expect(pageObject.infobar.materialIcon.innerText, 'info');
    });
    test('initialization with url and url', () async {
      await fixture.update((testElement) {
        testElement.icon = materialIcon;
        testElement.url = testLink;
      });
      expect(pageObject.trigger.innerText, 0.toString());
      expect(pageObject.infobar.materialButton.attributes['title'], testLink);
      expect(pageObject.infobar.materialIcon.innerText, materialIcon);
    });
    test('initialization with url then click 1X on the infobar button', () async {
      await fixture.update((testElement) => testElement.url = testLink);
      await pageObject.infobar.materialButton.click();
      expect(pageObject.trigger.innerText, 1.toString());
      expect(pageObject.infobar.materialButton.attributes['title'], testLink);
      expect(pageObject.infobar.materialIcon.innerText, 'info');
    });
    test('without url then click 3X on the infobar button', () async {
      await pageObject.infobar.materialButton.click();
      await pageObject.infobar.materialButton.click();
      await pageObject.infobar.materialButton.click();
      expect(pageObject.trigger.innerText, 3.toString());
      expect(pageObject.infobar.materialButton.attributes['title'], isNull);
      expect(pageObject.infobar.materialIcon.innerText, isEmpty);
    });
  });
}

@Component(selector: 'test', template: '''
    <skawa-infobar [icon]="icon" [url]="url" (trigger)="increment()"></skawa-infobar>
    <div increment>{{triggered}}</div>
     ''', directives: [SkawaInfobarComponent])
class InfobarTestComponent {
  String icon;
  String url;
  int triggered = 0;

  void increment() => triggered = triggered + 1;
}

@PageObject()
@CheckTag('test')
abstract class TestPO {
  TestPO();

  factory TestPO.create(PageLoaderElement context) = $TestPO.create;

  @ByTagName('skawa-infobar')
  InforbarPO get infobar;

  @ByTagName('[increment]')
  PageLoaderElement get trigger;
}

@PageObject()
abstract class InforbarPO {
  InforbarPO();

  factory InforbarPO.create(PageLoaderElement context) = $InforbarPO.create;

  @ByTagName('material-button')
  PageLoaderElement get materialButton;

  @ByTagName('material-icon')
  PageLoaderElement get materialIcon;
}

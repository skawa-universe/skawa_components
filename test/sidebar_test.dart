@Tags(const ['aot'])
@TestOn('browser')
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/sidebar/sidebar.dart';
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';

void main() {
  tearDown(disposeAnyRunningTest);
  group('Sidebar | ', () {
    final String cssClass = 'opened';
    test('initialization with open sidebar', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(ClickCounterPO);
      expect(pageObject.sidebar.rootElement.classes, mayEmit(cssClass));
      expect(pageObject.sidebar.aside.classes, mayEmit(cssClass));
    });
    test('initialization with open sidebar then toogle 1X', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(ClickCounterPO);
      await pageObject.button.click();
      expect(pageObject.sidebar.rootElement.classes, neverEmits(cssClass));
      expect(pageObject.sidebar.aside.classes, neverEmits(cssClass));
    });
    test('initialization with open sidebar then toogle 2X', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(ClickCounterPO);
      await pageObject.button.click();
      await pageObject.button.click();
      expect(pageObject.sidebar.rootElement.classes, mayEmit(cssClass));
      expect(pageObject.sidebar.aside.classes, mayEmit(cssClass));
    });
    test('initialization with open sidebar then toogle 3X', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(ClickCounterPO);
      await pageObject.button.click();
      await pageObject.button.click();
      await pageObject.button.click();
      expect(pageObject.sidebar.rootElement.classes, neverEmits(cssClass));
      expect(pageObject.sidebar.aside.classes, neverEmits(cssClass));
    });
    test('initialization with closed sidebar', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create(beforeChangeDetection: (testElement) {
        testElement.isOpen = false;
      });
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(ClickCounterPO);
      expect(pageObject.sidebar.rootElement.classes, neverEmits(cssClass));
      expect(pageObject.sidebar.aside.classes, neverEmits(cssClass));
    });
    test('initialization with closed sidebar then toogle 1X', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create(beforeChangeDetection: (testElement) {
        testElement.isOpen = false;
      });
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(ClickCounterPO);
      await pageObject.button.click();
      expect(pageObject.sidebar.rootElement.classes, mayEmit(cssClass));
      expect(pageObject.sidebar.aside.classes, mayEmit(cssClass));
    });
    test('initialization with closed sidebar then toogle 2X', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create(beforeChangeDetection: (testElement) {
        testElement.isOpen = false;
      });
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(ClickCounterPO);
      await pageObject.button.click();
      await pageObject.button.click();
      expect(pageObject.sidebar.rootElement.classes, neverEmits(cssClass));
      expect(pageObject.sidebar.aside.classes, neverEmits(cssClass));
    });
    test('initialization with closed sidebar then toogle 3X', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create(beforeChangeDetection: (testElement) {
        testElement.isOpen = false;
      });
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(ClickCounterPO);
      await pageObject.button.click();
      await pageObject.button.click();
      await pageObject.button.click();
      expect(pageObject.sidebar.rootElement.classes, mayEmit(cssClass));
      expect(pageObject.sidebar.aside.classes, mayEmit(cssClass));
    });
  });
}

@Component(
  selector: 'test',
  template: '''
    <skawa-sidebar #f [isOn]="isOpen"></skawa-sidebar>
    <button (click)="f.toggle()"></button>
     ''',
  directives: const [
    SkawaSidebarComponent,
  ],
)
class SidebarTestComponent {
  bool isOpen = true;
}

@EnsureTag('test')
class ClickCounterPO {
  @ByTagName('button')
  PageLoaderElement button;

  @ByTagName('skawa-sidebar')
  SidebarPO sidebar;
}

class SidebarPO {
  @root
  PageLoaderElement rootElement;

  @ByTagName('aside')
  PageLoaderElement aside;
}

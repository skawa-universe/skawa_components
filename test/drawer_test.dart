@Tags(const ['aot'])
@TestOn('browser')
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/drawer/drawer.dart';
import 'package:test/test.dart';

void main() {
  tearDown(disposeAnyRunningTest);
  group('Drawer | ', () {
    final String cssClass = 'opened';
    test('initialization with closed drawer', () async {
      final fixture = await new NgTestBed<DrawerTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      expect(pageObject.drawer.rootElement.classes, neverEmits(cssClass));
      expect(pageObject.drawer.sidebar.rootElement.classes, neverEmits(cssClass));
      expect(pageObject.drawer.sidebar.aside.classes, neverEmits(cssClass));
    });
    test('initialization with open drawer', () async {
      final fixture = await new NgTestBed<DrawerTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) => testElement.isOn = true);
      expect(pageObject.drawer.rootElement.classes, mayEmit(cssClass));
      expect(pageObject.drawer.sidebar.rootElement.classes, mayEmit(cssClass));
      expect(pageObject.drawer.sidebar.aside.classes, mayEmit(cssClass));
    });
    test('initialization with closed drawer then toggle 1X', () async {
      final fixture = await new NgTestBed<DrawerTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.button.click();
      expect(pageObject.drawer.rootElement.classes, mayEmit(cssClass));
      expect(pageObject.drawer.sidebar.rootElement.classes, mayEmit(cssClass));
      expect(pageObject.drawer.sidebar.aside.classes, mayEmit(cssClass));
    });
    test('initialization with closed drawer then toggle 2X', () async {
      final fixture = await new NgTestBed<DrawerTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.button.click();
      await pageObject.button.click();
      expect(pageObject.drawer.rootElement.classes, neverEmits(cssClass));
      expect(pageObject.drawer.sidebar.rootElement.classes, neverEmits(cssClass));
      expect(pageObject.drawer.sidebar.aside.classes, neverEmits(cssClass));
    });
  });
}

@Component(
  selector: 'test',
  template: '''
    <skawa-drawer #f [isOn]="isOn"></skawa-drawer>
    <button (click)="f.toggle();"></button>
     ''',
  directives: const [
    SkawaDrawerComponent,
  ],
)
class DrawerTestComponent {
  bool isOn = false;
}

@EnsureTag('test')
class TestPO {
  @ByTagName('button')
  PageLoaderElement button;

  @ByTagName('skawa-drawer')
  DrawerPO drawer;
}

class DrawerPO {
  @root
  PageLoaderElement rootElement;

  @ByTagName('skawa-sidebar')
  SidebarPO sidebar;
}

class SidebarPO {
  @root
  PageLoaderElement rootElement;

  @ByTagName('aside')
  PageLoaderElement aside;
}

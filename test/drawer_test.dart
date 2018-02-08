@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/src/components/drawer/drawer.dart';
import 'package:test/test.dart';

@AngularEntrypoint()
Future main() async {
  tearDown(disposeAnyRunningTest);
  group('Drawer | ', () {
    test('initialization with closed drawer', () async {
      final fixture = await new NgTestBed<DrawerTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      expect(await pageObject.drawer.rootElement.classes.contains('opened'), isFalse);
      expect(await pageObject.drawer.sidebar.rootElement.classes.contains('opened'), isFalse);
      expect(await pageObject.drawer.sidebar.aside.classes.contains('opened'), isFalse);
    });
    test('initialization with open drawer', () async {
      final fixture = await new NgTestBed<DrawerTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement.isOn = true;
      });
      expect(await pageObject.drawer.rootElement.classes.contains('opened'), isTrue);
      expect(await pageObject.drawer.sidebar.rootElement.classes.contains('opened'), isTrue);
      expect(await pageObject.drawer.sidebar.aside.classes.contains('opened'), isTrue);
    });
    test('initialization with closed drawer then toggle 1X', () async {
      final fixture = await new NgTestBed<DrawerTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.button.click();
      expect(await pageObject.drawer.rootElement.classes.contains('opened'), isTrue);
      expect(await pageObject.drawer.sidebar.rootElement.classes.contains('opened'), isTrue);
      expect(await pageObject.drawer.sidebar.aside.classes.contains('opened'), isTrue);
    });
    test('initialization with closed drawer then toggle 2X', () async {
      final fixture = await new NgTestBed<DrawerTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.button.click();
      await pageObject.button.click();
      expect(await pageObject.drawer.rootElement.classes.contains('opened'), isFalse);
      expect(await pageObject.drawer.sidebar.rootElement.classes.contains('opened'), isFalse);
      expect(await pageObject.drawer.sidebar.aside.classes.contains('opened'), isFalse);
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

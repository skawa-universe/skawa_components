@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/src/components/sidebar/sidebar.dart';
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';

@AngularEntrypoint()
Future main() async {
  tearDown(disposeAnyRunningTest);
  group('Sidebar | ', () {
    test('initialization with open sidebar', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(
        ClickCounterPO,
      );
      expect(await pageObject.sidebar.rootElement.classes.contains('opened'),
          isTrue);
      expect(await pageObject.sidebar.aside.classes.contains('opened'), isTrue);
    });
    test('initialization with open sidebar then toogle 1X', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(
        ClickCounterPO,
      );
      await pageObject.button.click();
      expect(await pageObject.sidebar.rootElement.classes.contains('opened'),
          isFalse);
      expect(
          await pageObject.sidebar.aside.classes.contains('opened'), isFalse);
    });
    test('initialization with open sidebar then toogle 2X', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(
        ClickCounterPO,
      );
      await pageObject.button.click();
      await pageObject.button.click();
      expect(await pageObject.sidebar.rootElement.classes.contains('opened'),
          isTrue);
      expect(await pageObject.sidebar.aside.classes.contains('opened'), isTrue);
    });
    test('initialization with open sidebar then toogle 3X', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(
        ClickCounterPO,
      );
      await pageObject.button.click();
      await pageObject.button.click();
      await pageObject.button.click();
      expect(await pageObject.sidebar.rootElement.classes.contains('opened'),
          isFalse);
      expect(
          await pageObject.sidebar.aside.classes.contains('opened'), isFalse);
    });
    test('initialization with closed sidebar', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create(
          beforeChangeDetection: (testElement) {
        testElement.isOpen = false;
      });
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(
        ClickCounterPO,
      );
      expect(await pageObject.sidebar.rootElement.classes.contains('opened'),
          isFalse);
      expect(
          await pageObject.sidebar.aside.classes.contains('opened'), isFalse);
    });
    test('initialization with closed sidebar then toogle 1X', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create(
          beforeChangeDetection: (testElement) {
        testElement.isOpen = false;
      });
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(
        ClickCounterPO,
      );
      await pageObject.button.click();
      expect(await pageObject.sidebar.rootElement.classes.contains('opened'),
          isTrue);
      expect(await pageObject.sidebar.aside.classes.contains('opened'), isTrue);
    });
    test('initialization with closed sidebar then toogle 2X', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create(
          beforeChangeDetection: (testElement) {
        testElement.isOpen = false;
      });
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(
        ClickCounterPO,
      );
      await pageObject.button.click();
      await pageObject.button.click();
      expect(await pageObject.sidebar.rootElement.classes.contains('opened'),
          isFalse);
      expect(
          await pageObject.sidebar.aside.classes.contains('opened'), isFalse);
    });
    test('initialization with closed sidebar then toogle 3X', () async {
      final fixture = await new NgTestBed<SidebarTestComponent>().create(
          beforeChangeDetection: (testElement) {
        testElement.isOpen = false;
      });
      final pageObject = await fixture.resolvePageObject/*<ClickCounterPO>*/(
        ClickCounterPO,
      );
      await pageObject.button.click();
      await pageObject.button.click();
      await pageObject.button.click();
      expect(await pageObject.sidebar.rootElement.classes.contains('opened'),
          isTrue);
      expect(await pageObject.sidebar.aside.classes.contains('opened'), isTrue);
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

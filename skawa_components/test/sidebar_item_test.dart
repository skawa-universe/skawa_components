@TestOn('browser')
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:skawa_components/sidebar_item/sidebar_item.dart';
import 'package:test/test.dart';
import 'sidebar_item_test.template.dart' as ng;

part 'sidebar_item_test.g.dart';

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);
  group('SidebarItem | ', () {
    test('initialization with zero input', () async {
      final fixture = await NgTestBed<SidebarItemTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      expect(pageObject.sideBarItemList.span.classes.contains('text-only'), isFalse);
      expect(pageObject.sideBarItemList.rootElement.attributes['textOnly'], isNull);
    });
    test('initialization with icon', () async {
      final fixture = await NgTestBed<SidebarItemTestComponent>()
          .create(beforeChangeDetection: (testElement) => testElement.icon = 'alarm');
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      expect(pageObject.sideBarItemList.materialIcon.rootElement.innerText, 'alarm');
      expect(pageObject.sideBarItemList.span.classes.contains('text-only'), isFalse);
      expect(pageObject.sideBarItemList.rootElement.attributes['textOnly'], isNull);
    });
    test('initialization with icon but with textOnly', () async {
      final fixture = await NgTestBed<SidebarItemTestComponent>().create(beforeChangeDetection: (testElement) {
        testElement
          ..icon = 'alarm'
          ..textOnly = '';
      });
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      expect(pageObject.sideBarItemList.span.classes.contains('text-only'), isTrue);
      expect(pageObject.sideBarItemList.rootElement.attributes['textOnly'], isNotNull);
    });
  });
}

@Component(
    selector: 'test',
    template: '<skawa-sidebar-item [icon]="icon" [textOnly]="textOnly"></skawa-sidebar-item>',
    directives: [SkawaSidebarItemComponent])
class SidebarItemTestComponent {
  String textOnly;
  String icon;
}

@PageObject()
@CheckTag('test')
abstract class TestPO {
  TestPO();

  factory TestPO.create(PageLoaderElement context) = $TestPO.create;

  @ByTagName('skawa-sidebar-item')
  SidebarItemPO get sideBarItemList;
}

@PageObject()
abstract class SidebarItemPO {
  SidebarItemPO();

  factory SidebarItemPO.create(PageLoaderElement context) = $SidebarItemPO.create;

  @root
  PageLoaderElement get rootElement;

  @ByTagName('span')
  PageLoaderElement get span;

  @ByTagName('material-icon')
  MaterialIconPO get materialIcon;
}

@PageObject()
abstract class MaterialIconPO {
  MaterialIconPO();

  factory MaterialIconPO.create(PageLoaderElement context) = $MaterialIconPO.create;

  @root
  PageLoaderElement get rootElement;
}

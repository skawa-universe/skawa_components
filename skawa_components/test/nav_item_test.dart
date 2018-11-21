//@TestOn('browser')
//import 'package:angular/angular.dart';
//import 'package:angular_test/angular_test.dart';
//import 'package:pageloader/html.dart';
//import 'package:skawa_components/nav_item/nav_item.dart';
//import 'package:test/test.dart';
//import 'nav_item_test.template.dart' as ng;
//
//part 'nav_item_test.g.dart';
//
//void main() {
//  ng.initReflector();
//  tearDown(disposeAnyRunningTest);
//  final testBed = new NgTestBed<NavItemTestComponent>();
//  NgTestFixture<NavItemTestComponent> fixture;
//  TestPO pageObject;
//  group('NavItem | ', () {
//    setUp(() async {
//      fixture = await testBed.create();
//      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
//      pageObject = TestPO.create(context);
//    });
//    test('initialization with zero input', () async {
//      expect(pageObject.sideNavItemList.rootElement.innerText, isEmpty);
//      expect(pageObject.sideNavItemList.sidebarItemList.span.classes.contains('text-only'), isFalse);
//      expect(pageObject.sideNavItemList.rootElement.attributes['textOnly'], isNull);
//    });
//    test('initialization with icon', () async {
//      await fixture.update((testElement) => testElement.icon = 'alarm');
//      expect((pageObject.sideNavItemList.sidebarItemList.materialIcon).rootElement.innerText, 'alarm');
//      expect(pageObject.sideNavItemList.sidebarItemList.span.classes.contains('text-only'), isFalse);
//      expect(pageObject.sideNavItemList.rootElement.attributes['textOnly'], isNull);
//    });
//    test('initialization with icon but with textOnly', () async {
//      await fixture.update((testElement) {
//        testElement
//          ..icon = 'alarm'
//          ..textOnly = '';
//      });
//      expect(pageObject.sideNavItemList.sidebarItemList.span.classes.contains('text-only'), isTrue);
//      expect(pageObject.sideNavItemList.rootElement.attributes['textOnly'], isNotNull);
//    });
//  });
//}
//
//@Component(selector: 'test', template: '''
//    <skawa-nav-item [icon]="icon" [textOnly]="textOnly" ></skawa-nav-item>
//     ''', directives: const [SkawaNavItemComponent])
//class NavItemTestComponent {
//  String textOnly;
//  String icon;
//}
//
//@PageObject()
//@CheckTag('test')
//abstract class TestPO {
//  TestPO();
//
//  factory TestPO.create(PageLoaderElement context) = $TestPO.create;
//
//  @ByTagName('skawa-nav-item')
//  NavItemPO get sideNavItemList;
//}
//
//@PageObject()
//abstract class NavItemPO {
//  NavItemPO();
//
//  factory NavItemPO.create(PageLoaderElement context) = $NavItemPO.create;
//
//  @root
//  PageLoaderElement get rootElement;
//
//  @ByTagName('skawa-sidebar-item')
//  SidebarItemPO get sidebarItemList;
//}
//
//@PageObject()
//abstract class SidebarItemPO {
//  SidebarItemPO();
//
//  factory SidebarItemPO.create(PageLoaderElement context) = $SidebarItemPO.create;
//
//  @ByTagName('span')
//  PageLoaderElement get span;
//
//  @ByTagName('material-icon')
//  MaterialIconPO get materialIcon;
//}
//
//@PageObject()
//abstract class MaterialIconPO {
//  MaterialIconPO();
//
//  factory MaterialIconPO.create(PageLoaderElement context) = $MaterialIconPO.create;
//
//  @root
//  PageLoaderElement get rootElement;
//}

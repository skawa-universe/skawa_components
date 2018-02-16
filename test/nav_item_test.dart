@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/src/components/nav_item/nav_item.dart';
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);
  group('NavItem | ', () {
    test('initialization with zero input', () async {
      final fixture = await new NgTestBed<NavItemTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      expect(pageObject.sideNavItemList.rootElement.innerText, completion(isEmpty));
      expect(pageObject.sideNavItemList.sidebarItemList.span.classes.contains('text-only'), completion(isFalse));
      expect(pageObject.sideNavItemList.rootElement.attributes['textOnly'], completion(isNull));
    });
    test('initialization with icon', () async {
      final fixture = await new NgTestBed<NavItemTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) => testElement.icon = 'alarm');
      expect((await pageObject.sideNavItemList.sidebarItemList.glyph).rootElement.innerText, completion('alarm'));
      expect(pageObject.sideNavItemList.sidebarItemList.span.classes.contains('text-only'), completion(isFalse));
      expect(pageObject.sideNavItemList.rootElement.attributes['textOnly'], completion(isNull));
    });
    test('initialization with icon but with textOnly', () async {
      final fixture = await new NgTestBed<NavItemTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement
          ..icon = 'alarm'
          ..textOnly = true;
      });
      expect(pageObject.sideNavItemList.sidebarItemList.span.classes.contains('text-only'), completion(isTrue));
      expect(pageObject.sideNavItemList.rootElement.attributes['textOnly'], completion(isNotNull));
    });
  });
}

@Component(
  selector: 'test',
  template: '''
    <skawa-nav-item [icon]="icon" [textOnly]="textOnly" ></skawa-nav-item>
     ''',
  directives: const [
    SkawaNavItemComponent,
  ],
)
class NavItemTestComponent {
  bool textOnly;

  String icon;
}

@EnsureTag('test')
class TestPO {
  @ByTagName('skawa-nav-item')
  NavItemPO sideNavItemList;
}

class NavItemPO {
  @root
  PageLoaderElement rootElement;

  @ByTagName('skawa-sidebar-item')
  SidebarItemPO sidebarItemList;
}

class SidebarItemPO {
  @inject
  PageLoader loader;

  @ByTagName('span')
  PageLoaderElement span;

  Future<GlyphPO> get glyph => loader.getInstance(GlyphPO, loader.globalContext);
}

@ByTagName('glyph')
class GlyphPO {
  @root
  PageLoaderElement rootElement;
}

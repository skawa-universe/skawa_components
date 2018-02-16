@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/src/components/sidebar_item/sidebar_item.dart';
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);
  group('SidebarItem | ', () {
    test('initialization with zero input', () async {
      final fixture = await new NgTestBed<SidebarItemTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      expect(pageObject.sideBarItemList.span.classes.contains('text-only'), completion(isFalse));
      expect(pageObject.sideBarItemList.rootElement.attributes['textOnly'], completion(isNull));
    });
    test('initialization with icon', () async {
      final fixture = await new NgTestBed<SidebarItemTestComponent>()
          .create(beforeChangeDetection: (testElement) => testElement.icon = 'alarm');
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      expect((await pageObject.sideBarItemList.glyph).rootElement.innerText, completion('alarm'));
      expect(pageObject.sideBarItemList.span.classes.contains('text-only'), completion(isFalse));
      expect(pageObject.sideBarItemList.rootElement.attributes['textOnly'], completion(isNull));
    });
    test('initialization with icon but with textOnly', () async {
      final fixture = await new NgTestBed<SidebarItemTestComponent>().create(beforeChangeDetection: (testElement) {
        testElement
          ..icon = 'alarm'
          ..textOnly = true;
      });
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      expect(pageObject.sideBarItemList.span.classes.contains('text-only'), completion(isTrue));
      expect(pageObject.sideBarItemList.rootElement.attributes['textOnly'], completion(isNotNull));
    });
  });
}

@Component(
  selector: 'test',
  template: '''
    <skawa-sidebar-item [icon]="icon" [textOnly]="textOnly"></skawa-sidebar-item>
     ''',
  directives: const [
    SkawaSidebarItemComponent,
  ],
)
class SidebarItemTestComponent {
  bool textOnly;

  String icon;
}

@EnsureTag('test')
class TestPO {
  @ByTagName('skawa-sidebar-item')
  SidebarItemPO sideBarItemList;
}

class SidebarItemPO {
  @root
  PageLoaderElement rootElement;

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

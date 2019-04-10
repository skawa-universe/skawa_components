@TestOn('browser')
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:skawa_components/master_detail/master_detail.dart';
import 'package:test/test.dart';
import 'master_detail_test.template.dart' as ng;

part 'master_detail_test.g.dart';

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);
  final testBed = NgTestBed<MasterDetailTestComponent>();
  NgTestFixture<MasterDetailTestComponent> fixture;
  TestPO pageObject;
  group('MasterDetail | ', () {
    setUp(() async {
      fixture = await testBed.create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      pageObject = TestPO.create(context);
    });
    test('initialization', () async {
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], isNull);
    });
    test('initialization then expand 1X', () async {
      await pageObject.expand.click();
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], isEmpty);
    });
    test('initialization then expand 2X', () async {
      await pageObject.expand.click();
      await pageObject.expand.click();
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], isEmpty);
    });
    test('initialization then expand 1X then toggle 1X', () async {
      await pageObject.expand.click();
      await pageObject.toggle.click();
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], isNull);
    });
    test('initialization then expand 1X then collapse 1X', () async {
      await pageObject.expand.click();
      await pageObject.collapse.click();
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], isNull);
    });
    test('initialization then toogle 1X then collapse 1X', () async {
      await pageObject.toggle.click();
      await pageObject.collapse.click();
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], isNull);
    });
    test('initialization then toggle 2X', () async {
      await pageObject.toggle.click();
      await pageObject.toggle.click();
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], isNull);
    });
  });
}

@Component(selector: 'test', template: '''
    <skawa-master-detail #masterDetail></skawa-master-detail>
    <button (click)="masterDetail.expand()" expand-button></button>
    <button (click)="masterDetail.collapse()" collapse-button></button>
    <button (click)="masterDetail.toggle()" toggle-button></button>
     ''', directives: [SkawaMasterDetailComponent])
class MasterDetailTestComponent {}

@PageObject()
@CheckTag('test')
abstract class TestPO {
  TestPO();

  factory TestPO.create(PageLoaderElement context) = $TestPO.create;

  @ByCss('[expand-button]')
  PageLoaderElement get expand;

  @ByCss('[collapse-button]')
  PageLoaderElement get collapse;

  @ByCss('[toggle-button]')
  PageLoaderElement get toggle;

  @ByTagName('skawa-master-detail')
  MasterDetailPage get sideMasterDetail;
}

@PageObject()
abstract class MasterDetailPage {
  MasterDetailPage();

  factory MasterDetailPage.create(PageLoaderElement context) = $MasterDetailPage.create;

  @root
  PageLoaderElement get rootElement;
}

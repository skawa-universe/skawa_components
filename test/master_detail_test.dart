@Tags(const ['aot'])
@TestOn('browser')
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_components/src/components/master_detail/master_detail.dart';
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);
  group('MasterDetail | ', () {
    test('initialization', () async {
      final fixture = await new NgTestBed<MasterDetailTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], completion(isNull));
    });
    test('initialization then expand 1X', () async {
      final fixture = await new NgTestBed<MasterDetailTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.expand.click();
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], completion(isEmpty));
    });
    test('initialization then expand 2X', () async {
      final fixture = await new NgTestBed<MasterDetailTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.expand.click();
      await pageObject.expand.click();
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], completion(isEmpty));
    });
    test('initialization then expand 1X then toggle 1X', () async {
      final fixture = await new NgTestBed<MasterDetailTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.expand.click();
      await pageObject.toggle.click();
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], completion(isNull));
    });
    test('initialization then expand 1X then collapse 1X', () async {
      final fixture = await new NgTestBed<MasterDetailTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.expand.click();
      await pageObject.collapse.click();
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], completion(isNull));
    });
    test('initialization then toogle 1X then collapse 1X', () async {
      final fixture = await new NgTestBed<MasterDetailTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.toggle.click();
      await pageObject.collapse.click();
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], completion(isNull));
    });
    test('initialization then toggle 2X', () async {
      final fixture = await new NgTestBed<MasterDetailTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await pageObject.toggle.click();
      await pageObject.toggle.click();
      expect(pageObject.sideMasterDetail.rootElement.attributes['expanded'], completion(isNull));
    });
  });
}

@Component(
  selector: 'test',
  template: '''
    <skawa-master-detail #masterDetail></skawa-master-detail>
    <button (click)="masterDetail.expand()" expand-button></button>
    <button (click)="masterDetail.collapse()" collapse-button></button>
    <button (click)="masterDetail.toggle()" toggle-button></button>
     ''',
  directives: const [
    SkawaMasterDetailComponent,
  ],
)
class MasterDetailTestComponent {}

@EnsureTag('test')
class TestPO {
  @ByCss('[expand-button]')
  PageLoaderElement expand;

  @ByCss('[collapse-button]')
  PageLoaderElement collapse;

  @ByCss('[toggle-button]')
  PageLoaderElement toggle;

  @ByTagName('skawa-master-detail')
  MasterDetailPage sideMasterDetail;
}

class MasterDetailPage {
  @root
  PageLoaderElement rootElement;

  @inject
  PageLoader loader;
}

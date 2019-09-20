@TestOn('browser')
import 'package:pageloader/html.dart';
import 'package:test/test.dart';
import 'package:angular_test/angular_test.dart';
import 'package:angular/core.dart';
import 'package:skawa_components/list_wrapper/list_wrapper.dart';
import 'package:skawa_components/list_wrapper/skawa_for_directive.dart';
import 'list_wrapper_test.template.dart' as ng;

part 'list_wrapper_test.g.dart';

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);

  setUpAll(() {});
  group('SkawaListWrapperComponent', () {
    final testBed = NgTestBed<ListWrapperTestComponent>();
    NgTestFixture<ListWrapperTestComponent> fixture;
    TestPO pageObject;
    setUp(() async {
      fixture = await testBed.create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      pageObject = TestPO.create(context);
    });
    test('initialization', () {
      expect(pageObject.listWrapper.spanList.length, 8);
      expect(pageObject.listWrapper.spanList.first.innerText, sampleList[0]);
    });
    test('scroll down 4 item', () async {
      await fixture.update((c) => c.scroll(350));
      expect(pageObject.listWrapper.spanList.first.innerText, sampleList[2]);
    });
    test('reverse the source', () async {
      await fixture.update((c) => c.reverse());
      expect(pageObject.listWrapper.spanList.length, 8);
      expect(pageObject.listWrapper.spanList.first.innerText, sampleList.last);
    });
    test('reverse the source, then scroll down', () async {
      await fixture.update((c) => c.reverse());
      await fixture.update((c) => c.scroll(700));
      expect(pageObject.listWrapper.spanList.length, 8);
      expect(pageObject.listWrapper.spanList.first.innerText, sampleList[sampleList.length - 9]);
    });
  });
}

@Component(
    selector: 'test',
    template: '''
      <list-wrapper #ll>
          <span *skawaFor="let item of list" style="height: 75px; display: block">{{item}}</span>
      </list-wrapper>
      <button (click)="reverse()">Reverse</button>
      <button (click)="double()">double</button>
   ''',
    styles: [':host list-wrapper{height: 300px;}', 'host: {max-height:300px;}'],
    directives: [SkawaForDirective, SkawaListWrapperComponent])
class ListWrapperTestComponent {
  SkawaForSource<String> list = SkawaForSource<String>(sampleList, true, 75);

  @ViewChild(SkawaForDirective)
  SkawaForDirective skawaForDirective;

  @ViewChild(SkawaListWrapperComponent)
  SkawaListWrapperComponent listWrapper;

  void scroll(int scrollTop) => listWrapper.htmlElement.scrollTop = scrollTop;

  void reverse() => list = SkawaForSource<String>(list.source.reversed.toList(), true, 75);

  void double() {
    List<String> listToAdd = list.source;
    list = SkawaForSource<String>(List.from(listToAdd)..addAll(listToAdd), true, 75);
  }
}

List<String> sampleList =
    '''Lorem ipsum dolor sit amet, quo at esse clita, dolorum accusata mei id. Dicam quidam petentium mea et, sit cu numquam tractatos, nec et etiam viderer legimus. Nam eu malis graece dissentiunt. Nibh mutat discere ius id. In everti menandri vix, duo tale altera molestiae ei, vim veritus molestie no. Ex usu eius deseruisse moderatius, nec te aeque detracto mentitum.
Te semper docendi invenire mei, laudem primis graeco eos te. Epicurei eloquentiam ius an, vim ex sumo wisi eloquentiam. Putant audiam expetendis an has, habeo abhorreant qui eu. Per altera propriae ne, nec at magna aliquam urbanitas. Dolorum propriae deterruisset eu vis, tale congue decore ei usu.
Eu qui illum novum elitr, prodesset persequeris eu mea. Ad eum postulant mediocrem hendrerit, vim omnes facete dissentiunt no. Te erant cotidieque vis. Mel ex atqui sanctus, ut has nusquam luptatum.
Ad per ferri sonet copiosae, veri indoctum ut mea. Melius senserit recteque eam et, homero vivendo ea eos, facilis signiferumque per eu. Id eros aliquip hendrerit ius. Diam oportere intellegat cum te. His ad delenit lobortis interesset.
Sit id case scaevola. Ad velit appareat vel, cu sea natum facilisi. Mel semper persius ocurreret at. Est diam stet fabellas ex, sea ullum iriure comprehensam et, ea atomorum sensibus mel. Pri ea meliore fastidii. Ex percipit assentior his, ut vix vidisse offendit. '''
        .split(' ');

@PageObject()
@CheckTag('test')
abstract class TestPO {
  @ByTagName('list-wrapper')
  ListWrapperPO get listWrapper;

  @ByTagName('div')
  List<PageLoaderElement> get divList;

  TestPO();

  factory TestPO.create(PageLoaderElement context) = $TestPO.create;
}

@PageObject()
abstract class ListWrapperPO {
  ListWrapperPO();

  factory ListWrapperPO.create(PageLoaderElement context) = $ListWrapperPO.create;

  @ByTagName('span')
  List<PageLoaderElement> get spanList;

  @root
  PageLoaderElement get rootElement;
}

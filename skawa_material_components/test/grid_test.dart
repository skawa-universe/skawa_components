@TestOn('browser')
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/webdriver.dart';
import 'package:skawa_material_components/grid/grid_component.dart';
import 'package:test/test.dart';
import 'grid_test.template.dart' as ng;

part 'grid_test.g.dart';

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);
  group('Grid | ', () {
    test('initialization with 3 grid', () async {
      final fixture = await new NgTestBed<GridTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      expect(pageObject.grid, isNotNull);
      var tiles = pageObject.grid.tiles;
      expect(tiles.length, 3);
      tiles.forEach((PageLoaderElement tile) => expect(tile.getBoundingClientRect().width.round(), 280));
    });
  });
}

@Component(selector: 'test', template: '''
  <skawa-grid #f>
    <div gridTile>Cat</div>
    <div gridTile>Dog</div>
    <div gridTile>Wolf</div>
  </skawa-grid>
     ''', directives: const [GridComponent, GridTileDirective])
class GridTestComponent {}

@PageObject()
@CheckTag('test')
abstract class TestPO {
  TestPO();

  factory TestPO.create(PageLoaderElement context) = $TestPO.create;

  @ByTagName('skawa-grid')
  GridPO get grid;
}

@PageObject()
abstract class GridPO {
  GridPO();

  factory GridPO.create(PageLoaderElement context) = $GridPO.create;

  @root
  PageLoaderElement get rootElement;

  @ByCss('[gridTile]')
  List<PageLoaderElement> get tiles;
}

@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:pageloader/webdriver.dart';
import 'package:skawa_components/src/components/grid/grid_component.dart';
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);
  group('Grid | ', () {
    test('initialization with 3 grid', () async {
      final fixture = await new NgTestBed<GridTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      expect(pageObject.grid, isNotNull);
      var tiles = await pageObject.grid.tiles;
      expect(tiles.length, 3);
      Future.forEach(tiles, (PageLoaderElement tile) async {
        expect((await tile.getBoundingClientRect()).width.round(), 280);
      });
    });
  });
}

@Component(
  selector: 'test',
  template: '''
  <skawa-grid #f>
    <div gridTile>Cat</div>
    <div gridTile>Dog</div>
    <div gridTile>Wolf</div>
  </skawa-grid>
     ''',
  directives: const [GridComponent, GridTileDirective],
)
class GridTestComponent {}

@EnsureTag('test')
class TestPO {
  @ByTagName('skawa-grid')
  GridPO grid;
}

class GridPO {
  @root
  PageLoaderElement rootElement;

  @ByCss('[gridTile]')
  List<PageLoaderElement> tiles;
}

@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:pageloader/webdriver.dart';
import 'package:skawa_components/src/components/grid/grid_component.dart';
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';

@AngularEntrypoint()
Future main() async {
  tearDown(disposeAnyRunningTest);
  group('Grid | ', () {
    test('initialization a raw card', () async {
      final fixture = await new NgTestBed<GridTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      print((await pageObject.grid.tiles[0].getBoundingClientRect()).width);
      print('cica');
      expect(pageObject.grid, isNotNull);
      expect(pageObject.grid.tiles.length, 3);
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
  <div (click)="f.updateAndDisplay()"></div>
     ''',
  directives: const [
    GridComponent,
    GridTileDirective,
  ],
)
class GridTestComponent {
}

@EnsureTag('test')
class TestPO {
  @ByTagName('skawa-grid')
  GridPO grid;
}

class GridPO{
  @root
  PageLoaderElement rootElement;

  @ByCss('[gridTile]')
  List<PageLoaderElement> tiles;
}


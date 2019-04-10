@TestOn('browser')
import 'dart:html';
import 'package:skawa_material_components/base_implementations/grid/grid.dart';
import 'package:test/test.dart';

void main() {
  group('GridUpdate | ', () {
    test('constructor', () {
      List<Point<int>> pointList = [Point(12, 13), Point(13122, 1), Point(412, 163), Point(312, 153), Point(212, 7613)];
      GridUpdate gridUpdate = GridUpdate(pointList, 116);
      expect(gridUpdate.tilePositions, pointList);
      expect(gridUpdate.gridHeight, 116);
    });
  });
  group('GridTile | ', () {
    Element tileElement;
    setUp(() {
      tileElement = Element.div();
      tileElement.style.height = '116px';
      tileElement.style.width = '16px';
      document.body.append(tileElement);
    });
    test('constructor', () {
      GridTile gridTile = GridTile(tileElement);
      expect(gridTile.height, 116);
      expect(gridTile.width, 16);
    });
    test('reposition method', () async {
      GridTile gridTile = GridTile(tileElement);
      Point<int> point = Point(321, 543);
      gridTile.reposition(point);
      expect(gridTile.height, 116);
      expect(gridTile.width, 16);
      expect(tileElement.style.transform, 'translate(${point.x}px, ${point.y}px)');
    });
  });
  group('Grid | ', () {
    List<GridTile> tileList;
    var tileElementList;
    Element gridElement;
    setUp(() {
      tileList = [];
      tileElementList = [];
      gridElement = Element.div();
      gridElement.style.height = '116px';
      gridElement.style.width = '48px';
      document.body.append(gridElement);
      for (int i = 0; i < 5; i++) {
        Element tileElement = Element.div();
        tileElement.style.height = '116px';
        tileElement.style.width = '16px';
        document.body.append(tileElement);
        tileElementList.add(tileElement);
        tileList.add(GridTile(tileElement));
      }
    });
    test('constructor', () {
      Grid grid = Grid(gridElement, tileList);
      expect(grid.tiles, tileList);
      expect(grid.visible, isTrue);
    });
    test('calculateGridUpdate method', () {
      Grid grid = Grid(gridElement, tileList);
      GridUpdate gridUpdate = grid.calculateGridUpdate(64);
      expect(grid.tiles, tileList);
      expect(grid.visible, isTrue);
      expect(gridUpdate.gridHeight, 412);
      expect(gridUpdate.tilePositions.length, grid.tiles.length);
      expect(gridUpdate.tilePositions, [Point(-8, 0), Point(24, 0), Point(-8, 132), Point(24, 132), Point(-8, 264)]);
    });
    test('updateAndDisplay method', () {
      Grid grid = Grid(gridElement, tileList);
      grid.visible = false;
      grid.updateAndDisplay(true);
      List<String> actual = [];
      List<String> expected = [];
      GridUpdate gridUpdate = grid.calculateGridUpdate(48);
      for (int i = 0; i < gridUpdate.tilePositions.length; i++) {
        expected.add('translate(${gridUpdate.tilePositions[i].x}px, ${gridUpdate.tilePositions[i].y}px)');
        actual.add(tileElementList[i].style.transform as String);
      }
      expect(grid.tiles, tileList);
      expect(grid.visible, isTrue);
      expect(gridElement.clientHeight, 676);
      expect(actual, expected);
    });
  });
}

@TestOn('browser')
import 'dart:html';
import 'package:skawa_materialish_components/base_implementations/grid/grid.dart';
import 'package:test/test.dart';

void main() {
  group('GridUpdate | ', () {
    test('constructor', () {
      List<Point> pointList = [
        new Point(12, 13),
        new Point(13122, 1),
        new Point(412, 163),
        new Point(312, 153),
        new Point(212, 7613)
      ];
      GridUpdate gridUpdate = new GridUpdate(pointList, 116);
      expect(gridUpdate.tilePositions, pointList);
      expect(gridUpdate.gridHeight, 116);
    });
  });
  group('GridTile | ', () {
    var tileElement;
    setUp(() {
      tileElement = new Element.div();
      tileElement.style.height = '116px';
      tileElement.style.width = '16px';
      document.body.append(tileElement);
    });
    test('constructor', () {
      GridTile gridTile = new GridTile(tileElement);
      expect(gridTile.height, 116);
      expect(gridTile.width, 16);
    });
    test('reposition method', () async {
      GridTile gridTile = new GridTile(tileElement);
      Point point = new Point(321, 543);
      gridTile.reposition(point);
      expect(gridTile.height, 116);
      expect(gridTile.width, 16);
      expect(tileElement.style.transform, 'translate(${point.x}px, ${point.y}px)');
    });
  });
  group('Grid | ', () {
    var tileList;
    var tileElementList;
    var gridElement;
    setUp(() {
      tileList = [];
      tileElementList = [];
      gridElement = new Element.div();
      gridElement.style.height = '116px';
      gridElement.style.width = '48px';
      document.body.append(gridElement);
      for (int i = 0; i < 5; i++) {
        Element tileElement = new Element.div();
        tileElement.style.height = '116px';
        tileElement.style.width = '16px';
        document.body.append(tileElement);
        tileElementList.add(tileElement);
        tileList.add(new GridTile(tileElement));
      }
    });
    test('constructor', () {
      Grid grid = new Grid(gridElement, tileList);
      expect(grid.tiles, tileList);
      expect(grid.visible, isTrue);
    });
    test('calculateGridUpdate method', () {
      Grid grid = new Grid(gridElement, tileList);
      GridUpdate gridUpdate = grid.calculateGridUpdate(64);
      expect(grid.tiles, tileList);
      expect(grid.visible, isTrue);
      expect(gridUpdate.gridHeight, 412);
      expect(gridUpdate.tilePositions.length, grid.tiles.length);
      expect(gridUpdate.tilePositions,
          [new Point(-8, 0), new Point(24, 0), new Point(-8, 132), new Point(24, 132), new Point(-8, 264)]);
    });
    test('updateAndDisplay method', () {
      Grid grid = new Grid(gridElement, tileList);
      grid.visible = false;
      grid.updateAndDisplay(true);
      List<String> actual = [];
      List<String> expected = [];
      GridUpdate gridUpdate = grid.calculateGridUpdate(48);
      for (int i = 0; i < gridUpdate.tilePositions.length; i++) {
        expected.add('translate(${gridUpdate.tilePositions[i].x}px, ${gridUpdate.tilePositions[i].y}px)');
        actual.add(tileElementList[i].style.transform);
      }
      expect(grid.tiles, tileList);
      expect(grid.visible, isTrue);
      expect(gridElement.clientHeight, 676);
      expect(actual, expected);
    });
  });
}

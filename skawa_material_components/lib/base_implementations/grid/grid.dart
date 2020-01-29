library skawa_component_collection.grid;

import 'dart:html';
import 'dart:math' show max;

/// Returns a set of updates to be performed on the DOM
/// to achieve the desired arrangement for the grid
class GridUpdate {
  final List<Point<int>> tilePositions;
  final int gridHeight;

  GridUpdate(this.tilePositions, this.gridHeight);
}

/// Represents a tile in the Grid
abstract class GridTile {
  factory GridTile(Element gridTile) {
    return _DomGridTile(gridTile);
  }

  /// Width of the grid tile
  int get width;

  /// Height of grid tile
  int get height;

  /// Repositions the tile to [pos]
  void reposition(Point<int> pos);
}

abstract class DomTransformReposition {
  Element get tile;

  int get width => tile.clientWidth;

  int get height => tile.clientHeight;

  void reposition(Point<int> pos) => tile.style.transform = 'translate(${pos.x}px, ${pos.y}px)';
}

abstract class GridBase implements Grid {
  /// Calculates the positions for [tiles] in a grid with width of [gridWidth]
  ///
  /// Default gutter size (spacing between tiles) is 16px
  @override
  GridUpdate calculateGridUpdate(int gridWidth, {int gutterSize = 16}) {
    final int tileWidth = tiles.first.width;
    final int tileWidthWithGutter = (tileWidth + gutterSize);
    final int colNumber = gridWidth ~/ tileWidthWithGutter == 0 ? 1 : gridWidth ~/ tileWidthWithGutter;
    final int xAdjustmentForCentering = (gridWidth - tileWidthWithGutter * colNumber - gutterSize) ~/ 2;
    final List<int> xTranslations =
        List.generate(colNumber, (int index) => index * tileWidthWithGutter + xAdjustmentForCentering, growable: false);
    final List<int> yTranslationForCol = List.filled(colNumber, 0, growable: false);
    final List<Point<int>> tileTransformations = List<Point<int>>(tiles.length);

    int colIndex = 0;
    for (int tileNumber = 0; tileNumber < tiles.length; ++tileNumber) {
      GridTile tile = tiles.elementAt(tileNumber);
      int maxYTranslation = yTranslationForCol.reduce(max);
      int maxColIndex = yTranslationForCol.indexOf(maxYTranslation);
      bool multiple = yTranslationForCol.where((e) => e == maxYTranslation).length > 1;
      if (!multiple && maxColIndex == colIndex) {
        colIndex = (colIndex + 1) % colNumber;
      }
      tileTransformations[tileNumber] = Point<int>(xTranslations[colIndex], yTranslationForCol[colIndex]);
      int tileBottom = tile.height + yTranslationForCol[colIndex] + gutterSize;
      yTranslationForCol[colIndex] = tileBottom;
      colIndex = (colIndex + 1) % colNumber;
    }

    int newGridHeight = yTranslationForCol.reduce(max) + gutterSize;
    return GridUpdate(tileTransformations, newGridHeight);
  }
}

abstract class Grid {
  factory Grid(Element grid, List<GridTile> tiles) {
    return _DomGrid(grid, tiles);
  }

  Iterable<GridTile> get tiles;

  set visible(bool val);

  bool get visible;

  GridUpdate calculateGridUpdate(int gridWidth, {int gutterSize = 16});

  /// Updates the grid
  void updateAndDisplay(bool forceRefresh);
}

class _DomGridTile implements GridTile {
  final Element _tile;

  _DomGridTile(this._tile);

  @override
  int get width => _tile.clientWidth;

  @override
  int get height => _tile.clientHeight;

  @override
  void reposition(Point<int> pos) => _tile.style.transform = 'translate(${pos.x}px, ${pos.y}px)';
}

class _DomGrid extends GridBase {
  @override
  final List<GridTile> tiles;
  final Element _grid;

  _DomGrid(this._grid, this.tiles);

  @override
  void updateAndDisplay(bool forceRefresh, [_]) {
    GridUpdate gridUpdate = calculateGridUpdate(_grid.clientWidth);
    visible = true;
    _grid.style..height = '${gridUpdate.gridHeight}px';
    for (int i = 0; i < gridUpdate.tilePositions.length; ++i) {
      Point<int> newPosition = gridUpdate.tilePositions[i];
      tiles[i].reposition(newPosition);
    }
  }

  @override
  bool get visible => _grid.style.visibility != 'hidden';

  @override
  set visible(bool val) => _grid.style.visibility = val ? '' : 'hidden';
}

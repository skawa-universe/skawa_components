import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import '../base_implementations/grid/grid.dart';

/// __Inputs__:
///
///   - `gridGutter`: padding between grid items
///
@Component(
    selector: 'skawa-grid',
    template: '<div class="grid-container" #grid><ng-content></ng-content></div>',
    changeDetection: ChangeDetectionStrategy.OnPush,
    styleUrls: const ['grid_component.css'],
    directives: const [GridTileDirective])
class GridComponent extends GridBase implements AfterViewInit, OnInit {
  List<GridTile> _tiles;

  @HostBinding('style.visibility')
  String visibility;

  @ContentChildren(GridTileDirective)
  @override
  set tiles(List<GridTile> tiles) {
    _tiles = tiles;
    updateAndDisplay(true);
  }

  @Input()
  String gridGutter = '16';

  @override
  bool get visible => visibility != 'hidden';

  @override
  set visible(bool val) {
    visibility = val ? '' : 'hidden';
  }

  @ViewChild('grid')
  HtmlElement grid;

  List<GridTile> get tiles => _tiles;

  @override
  void updateAndDisplay(bool forceRefresh) {
    _resizeTimer?.cancel();
    _resizeTimer = new Timer(new Duration(milliseconds: 100), () {
      // there are no tiles to update, return
      if (tiles.isEmpty) return;
      var gridWidth = grid.clientWidth;
      // width did not change, return
      if (_previousWidth == gridWidth && !forceRefresh) return;
      _previousWidth = gridWidth;

      GridUpdate gridUpdate = calculateGridUpdate(gridWidth, gutterSize: int.parse(gridGutter));
      visible = true;
      grid.style..height = '${gridUpdate.gridHeight}px';
      for (int i = 0; i < gridUpdate.tilePositions.length; ++i) {
        Point<int> newPosition = gridUpdate.tilePositions[i];
        tiles.elementAt(i).reposition(newPosition);
      }
    });
  }

  @override
  void ngAfterViewInit() {
    updateAndDisplay(true);
  }

  @override
  void ngOnInit() {
    window.onResize.listen((_) {
      updateAndDisplay(false);
    });
  }

  Timer _resizeTimer;
  int _previousWidth = -1;
}

@Directive(
  selector: '[gridTile]',
)
class GridTileDirective extends Object with DomTransformReposition implements GridTile {
  @override
  final HtmlElement tile;

  GridTileDirective(this.tile);
}

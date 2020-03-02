import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_components/utils/disposer/disposer.dart';

import 'list_wrapper.dart';

///   This directive based on the `NgFor` in usage. It should be usable only in a `SkawaListWrapperComponent`,
///
/// __Example usage:__
///           <list-wrapper >
///               <span *skawaFor="let item of list" style="height: 75px; display: block">{{item}}</span>
///           </list-wrapper>
///
///
/// __Inputs__:
///
///   - `itemHeight`: The minimal item height of the rendered component.

@Directive(selector: '[skawaFor][skawaForOf]', exportAs: 'skawaFor')
class SkawaForDirective<T> implements OnInit, OnDestroy {
  final StreamController<Null> _loadController = StreamController<Null>();
  final Disposer disposer = Disposer.oneShot();
  final ViewContainerRef viewContainerRef;
  final TemplateRef _templateRef;
  final SkawaListWrapperComponent skawaListParent;
  final NgZone _ngZone;
  final Map<T, int> _heightMap = {};

  int topHeight = 0;
  int scrollHeight = 0;
  int startIndex = 0;
  int _renderedComponentNumber = 0;
  int _lastScrollTop = 0;
  SkawaForSource<T> _source;

  SkawaForDirective(this.viewContainerRef, this._templateRef, this.skawaListParent, this._ngZone);

  @Output('load')
  Stream<Null> get onLoad => _loadController.stream;

  List<T> get _dataSource => _source.source;

  int get _itemHeight => _source.height;

  @Input()
  set skawaForOf(SkawaForSource<T> value) {
    _source = value;
    _tearDown(value.resetList);
    _renderOnResize(null, shouldTriggerBottomReach: false);
    skawaListParent.htmlElement.scrollTop = _lastScrollTop;
    _loadController.add(null);
  }

  void _tearDown(bool resetList) {
    if (resetList) {
      topHeight = 0;
      startIndex = 0;
    }
    _renderedComponentNumber = 0;
    while (viewContainerRef.length > 0) {
      viewContainerRef.remove();
    }
  }

  Future _checkTopDivPositions() async {
    int difference = topHeight - _lastScrollTop;
    await Future.doWhile(() async {
      if (!(startIndex > 0 && difference > -calculatedItemHeight(_dataSource[startIndex - 1]))) return false;
      await _scrollRefresh(startIndex - 1, false);
      difference = difference - calculatedItemHeight(_dataSource[startIndex]);
      return startIndex > 0 && difference > -calculatedItemHeight(_dataSource[startIndex - 1]);
    });
  }

  Future _checkBottomDivPositions() async {
    int difference =
        _lastScrollTop + scrollHeight - topHeight - subListHeight(startIndex, startIndex + _renderedComponentNumber);
    int index = _renderedComponentNumber + startIndex;
    await Future.doWhile(() async {
      if (!(index < _dataSource.length && difference > -calculatedItemHeight(_dataSource[index]))) return false;
      await _scrollRefresh(index, true);
      difference = difference - calculatedItemHeight(_dataSource[index]);
      index++;
      return index < _dataSource.length && difference > -calculatedItemHeight(_dataSource[index]);
    });
  }

  Future _scrollRefresh(int index, bool toBottom) async {
    int from = toBottom ? 0 : _renderedComponentNumber - 1;
    int to = toBottom ? _renderedComponentNumber - 1 : 0;
    EmbeddedViewRef templateToMove = viewContainerRef.get(from) as EmbeddedViewRef;
    viewContainerRef.move(templateToMove, to);
    await _updateValue(templateToMove, index, to + 1);
    startIndex = toBottom ? startIndex + 1 : startIndex - 1;
    _setUpHeights();
  }

  Future _checkPositionOnScroll(Event e) async {
    _lastScrollTop = (e?.target as Element)?.scrollTop ?? 0;
    await _checkBottomDivPositions();
    await _checkTopDivPositions();
  }

  void _renderOnResize(Event e, {bool shouldTriggerBottomReach = true}) {
    if (_dataSource == null) return;
    scrollHeight = skawaListParent.htmlElement.offsetHeight;
    final int calculatedComponentNumber = min(scrollHeight ~/ _itemHeight + 4, _dataSource.length);
    while (calculatedComponentNumber < _renderedComponentNumber) {
      viewContainerRef.remove();
      _renderedComponentNumber--;
    }
    while (calculatedComponentNumber > _renderedComponentNumber &&
        _renderedComponentNumber + startIndex < _dataSource.length) {
      int index = startIndex + _renderedComponentNumber;
      EmbeddedViewRef viewRef = viewContainerRef.createEmbeddedView(_templateRef);
      _updateValue(viewRef, index, _renderedComponentNumber + 1);
      _renderedComponentNumber++;
    }
    _setUpHeights(shouldTriggerBottomReach);
  }

  Future _updateValue(EmbeddedViewRef viewRef, int index, int localIndex) async {
    Completer completer = Completer();
    T dataSource = _dataSource[index];
    viewRef
      ..setLocal(r'$implicit', dataSource)
      ..setLocal('even', index.isEven)
      ..setLocal('odd', index.isOdd)
      ..markForCheck();
    if (!_source.defaultHeight && (_heightMap[dataSource] == null || _heightMap[dataSource] == 0)) {
      _ngZone.runAfterChangesObserved(() {
        _heightMap[dataSource] = viewRef.rootNodes.first.parent.children[localIndex].offsetHeight;
        completer.complete();
      });
    } else {
      completer.complete();
    }
    return completer.future;
  }

  void _setUpHeights([bool shouldTriggerBottomReach = true]) {
    if (_dataSource == null) return;
    topHeight = subListHeight(0, startIndex);
    int bottomHeight = subListHeight(_renderedComponentNumber + startIndex);
    skawaListParent.setUpHeights(topHeight, bottomHeight, shouldTriggerBottomReach);
  }

  int subListHeight(int startIndex, [int endIndex]) {
    if (_source.defaultHeight) {
      return _source.height * ((endIndex ?? _dataSource.length) - startIndex);
    } else {
      return _dataSource
          .sublist(startIndex, endIndex)
          .fold<int>(0, (int height, T item) => height + calculatedItemHeight(item));
    }
  }

  int calculatedItemHeight(T item) {
    if (_source.defaultHeight) {
      return _source.height;
    } else {
      return _heightMap[item] != 0 && _heightMap[item] != null ? _heightMap[item] : _itemHeight;
    }
  }

  @override
  void ngOnInit() {
    _renderOnResize(null);
    disposer
      ..addStreamSubscription(window.onResize.listen(_renderOnResize))
      ..addDisposable(_loadController);
    skawaListParent.htmlElement.onScroll.listen(_checkPositionOnScroll);
  }

  @override
  void ngOnDestroy() => disposer.dispose();
}

class SkawaForSource<T> {
  List<T> source;
  bool resetList;
  int height;
  bool defaultHeight;

  SkawaForSource(this.source, this.resetList, this.height, {this.defaultHeight = false});
}

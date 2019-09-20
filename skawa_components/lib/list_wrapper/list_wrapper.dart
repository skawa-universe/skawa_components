import 'dart:async';
import 'dart:html';

import 'package:angular/core.dart';

/// This component combined with the `SkawaForDirective` are used to be a minimal implementation for the
/// (flyweight pattern)[https://en.wikipedia.org/wiki/Flyweight_pattern]. The concept is if you have a list with potentially
/// 2-3000+ element with not small logic, it will a huge burden for the browser. Therefore this component will have some visible
/// element (depends on height and the promised element height) and the other part will be filled up with 2 empty div
/// (one on the top on e and the bottom). Pro it will much faster and have more fps then the normal `NgFor`,
/// but you can't search in it with normal browser search (only the visible element are rendered).
///
///
/// __Example usage:__
///           <list-wrapper >
///               <span *skawaFor="let item of list;itemHeight:75" style="height: 75px; display: block">{{item}}</span>
///           </list-wrapper>
///
///
/// __Events:__
///
/// - `reachBottom: Event` -- Published when the list will scrolled down to the bottom fully. I can be combined with
///                            auto loading data from the backend.
///

@Component(
    selector: 'list-wrapper',
    templateUrl: 'list_wrapper.html',
    styleUrls: ['list_wrapper.css'],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaListWrapperComponent implements OnDestroy {
  final StreamController<Null> _reachBottomController = StreamController<Null>();
  final StreamController<Null> _reachTopController = StreamController<Null>();
  final ChangeDetectorRef changeDetectorRef;
  final HtmlElement htmlElement;

  @ViewChild('topPlaceHolder')
  HtmlElement topPlaceHolder;

  @ViewChild('bottomPlaceholder')
  HtmlElement bottomPlaceholder;

  SkawaListWrapperComponent(this.changeDetectorRef, this.htmlElement);

  @Output('reachBottom')
  Stream<Null> get onReachBottom => _reachBottomController.stream;

  void setUpHeights(int topHeight, int bottomHeight, bool shouldTriggerBottomReach) {
    bottomPlaceholder.style.height = "${bottomHeight}px";
    topPlaceHolder.style.height = "${topHeight}px";
    if (bottomHeight == 0 && shouldTriggerBottomReach) _reachBottomController.add(null);
    if (topHeight == 0) _reachTopController.add(null);
  }

  @override
  void ngOnDestroy() {
    _reachBottomController.close();
    _reachTopController.close();
  }
}

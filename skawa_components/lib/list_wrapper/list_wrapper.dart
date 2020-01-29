import 'dart:async';
import 'dart:html';

import 'package:angular/core.dart';

/// This component combined with the `SkawaForDirective` can be used to efficiently display lists of arbitrary length.
/// The component and the directive together work by only leaving the currently visible list items in the DOM,
/// and replacing the out-of-view items with two empty div elements (one at the top and one the bottom).
/// This will result in a smooth list rendering and scrolling experience.
/// One caveat is that the browser "Find" command will not be able to search through all list items, as the non-visible
/// ones are physically removed from the DOM.
///
///
/// __Example usage:__
///           <list-wrapper >
///               <span *skawaFor="let item of list" style="height: 75px; display: block">{{item}}</span>
///           </list-wrapper>
///
///
/// __Events:__
///
/// - `reachBottom: Event` -- Published when the list is scrolled down to the bottom.
///                             It can be used to trigger loading further elements from a service.
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

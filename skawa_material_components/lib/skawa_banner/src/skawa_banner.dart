part of skawa_banner;

@Component(
    selector: 'skawa-banner',
    templateUrl: 'src/skawa_banner.html',
    styleUrls: ['src/skawa_banner.css'],
    directives: [MaterialIconComponent, MaterialButtonComponent, coreDirectives],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaBannerComponent implements OnInit, OnDestroy {
  final ChangeDetectorRef _changeDetectorRef;
  final SkawaBannerService _bannerService;
  final Disposer disposer = Disposer.oneShot();

  bool active = false;
  bool show = false;
  SkawaBannerMessage message;

  SkawaBannerComponent(this._changeDetectorRef, this._bannerService);

  bool get hasActions => message?.actions != null && message.actions.isNotEmpty;

  void animationEnd() {
    if (!show) {
      message.dismiss();
      message = null;
      active = false;
    }
  }

  Future<void> handleAction(BannerAction action) async {
    bool canDismiss = true;
    if (action.callback != null) {
      canDismiss = await action.callback();
    }
    if (canDismiss) {
      show = false;
      _changeDetectorRef.markForCheck();
    }
  }

  @override
  Future<void> ngOnInit() async {
    disposer.addStreamSubscription(_bannerService.dispatch.listen((SkawaBannerMessage event) async {
      message = null;
      show = false;
      active = true;
      _changeDetectorRef.markForCheck();
      await window.animationFrame;
      message = event;
      show = true;
      _changeDetectorRef.markForCheck();
    }));
  }

  @override
  void ngOnDestroy() => disposer.dispose();
}

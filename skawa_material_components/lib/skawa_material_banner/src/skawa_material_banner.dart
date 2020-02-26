part of skawa_material_banner;

@Component(
    selector: 'skawa-material-banner',
    templateUrl: 'src/skawa_material_banner.html',
    styleUrls: ['src/skawa_material_banner.css'],
    directives: [MaterialIconComponent, MaterialButtonComponent, coreDirectives],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaMaterialBannerComponent implements OnInit, OnDestroy {
  final ChangeDetectorRef _changeDetectorRef;
  final SkawaMaterialBannerService _bannerService;
  final Disposer disposer = Disposer.oneShot();

  bool active = false;
  bool show = false;
  SkawaMaterialBannerMessage message;

  SkawaMaterialBannerComponent(this._changeDetectorRef, this._bannerService);

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
    disposer.addStreamSubscription(_bannerService.dispatch.listen((SkawaMaterialBannerMessage event) async {
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

import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:skawa_material_components/skawa_banner/skawa_banner.dart';

@Component(
    selector: 'skawa-banner-host',
    templateUrl: 'skawa_banner_host.html',
    styleUrls: ['skawa_banner_host.css'],
    directives: [SkawaBannerComponent, MaterialButtonComponent])
class SkawaBannerHostComponent {
  final SkawaBannerService _bannerService;

  SkawaBannerMessage warningMessage;
  SkawaBannerMessage infoMessage;
  SkawaBannerMessage errorMessage;

  SkawaBannerHostComponent(this._bannerService);

  void showWarning() {
    warningMessage = SkawaBannerMessage.warning("This is a warning");
    _bannerService.showMessage(warningMessage);
  }

  void showInfo(bool priority) {
    infoMessage =
        infoMessage = SkawaBannerMessage.info("This is an info", beforeDispatch: priority ? null : () => false);
    _bannerService.showMessage(infoMessage);
  }

  void showError() {
    errorMessage = SkawaBannerMessage.error("This is an error");
    _bannerService.showMessage(errorMessage);
  }
}

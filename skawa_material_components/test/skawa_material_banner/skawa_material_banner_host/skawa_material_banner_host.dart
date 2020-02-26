import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:skawa_material_components/skawa_material_banner/skawa_material_banner.dart';

@Component(
    selector: 'skawa-material-banner-host-component',
    templateUrl: 'skawa_material_banner_host.html',
    styleUrls: ['skawa_material_banner_host.css'],
    directives: [SkawaMaterialBannerComponent, MaterialButtonComponent])
class SkawaMaterialBannerHostComponent {
  final SkawaMaterialBannerService _bannerService;

  SkawaMaterialBannerMessage warningMessage;
  SkawaMaterialBannerMessage infoMessage;
  SkawaMaterialBannerMessage errorMessage;

  SkawaMaterialBannerHostComponent(this._bannerService);

  void showWarning() {
    warningMessage = SkawaMaterialBannerMessage.warning("This is a warning");
    _bannerService.showMessage(warningMessage);
  }

  void showInfo(bool priority) {
    infoMessage =
        infoMessage = SkawaMaterialBannerMessage.info("This is an info", beforeDispatch: priority ? null : () => false);
    _bannerService.showMessage(infoMessage);
  }

  void showError() {
    errorMessage = SkawaMaterialBannerMessage.error("This is an error");
    _bannerService.showMessage(errorMessage);
  }
}

import 'package:pageloader/pageloader.dart';

import '../skawa_banner_po.dart';

part 'skawa_banner_host_po.g.dart';

@PageObject()
abstract class SkawaBannerHostPO {
  SkawaBannerHostPO();

  factory SkawaBannerHostPO.create(PageLoaderElement context) = $SkawaBannerHostPO.create;

  @root
  PageLoaderElement get rootElement;

  @ByCss('div.header')
  PageLoaderElement get header;

  @ByCheckTag()
  SkawaBannerPO get banner;

  @ByCss('.main-content')
  PageLoaderElement get content;

  @ByCss('material-button[raised]')
  List<PageLoaderElement> get actions;

  Future showWarning() async => await actions[0].click();

  Future showInfo() async => await actions[1].click();

  Future showInfoWithoutPriority() async => await actions[2].click();

  Future showError() async => await actions[3].click();
}

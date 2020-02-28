import 'package:pageloader/pageloader.dart';

part 'skawa_banner_po.g.dart';

@PageObject()
@CheckTag('skawa-banner')
abstract class SkawaBannerPO {
  SkawaBannerPO();

  factory SkawaBannerPO.create(PageLoaderElement context) = $SkawaBannerPO.create;

  @root
  PageLoaderElement get rootElement;

  @ByCss('section.banner')
  PageLoaderElement get section;

  @ByCss('div.message span')
  PageLoaderElement get messageText;

  @ByCss('div.message material-icon')
  PageLoaderElement get messageIcon;

  @ByCss('material-button')
  List<PageLoaderElement> get actions;

  PageLoaderElement get iconI =>
      messageIcon?.getElementsByCss("i") != null && messageIcon.getElementsByCss("i").isNotEmpty
          ? messageIcon.getElementsByCss("i").first
          : null;

  String get iconName => iconI?.innerText;

  String get iconClass => messageIcon.exists
      ? messageIcon.classes.firstWhere((String className) => className != "icon-large", orElse: () => null)
      : null;

  String get message => messageText.exists ? messageText.visibleText : null;

  Future<void> trigger(int i) async {
    if (actions == null || actions.length <= i) {
      throw StateError("No such action $i in $actions");
    }
    await actions.elementAt(i).click();
  }
}

// @dart=2.10
import 'package:pageloader/pageloader.dart';

part 'snackbar_test_po.g.dart';

@PageObject()
@CheckTag('test')
abstract class TestPO {
  TestPO();

  factory TestPO.create(PageLoaderElement context) = $TestPO.create;

  @Global(ByClass('snackbar-container'))
  SnackbarPO get snackbar;

  @ByTagName('span')
  PageLoaderElement get messageSpan;

  @ByTagName('p')
  PageLoaderElement get callbackP;
}

@PageObject()
abstract class SnackbarPO {
  SnackbarPO();

  factory SnackbarPO.create(PageLoaderElement context) = $SnackbarPO.create;

  @root
  PageLoaderElement get rootElement;

  @ByTagName('span')
  PageLoaderElement get messageContainer;

  @ByTagName('material-button')
  PageLoaderElement get materialButton;
}

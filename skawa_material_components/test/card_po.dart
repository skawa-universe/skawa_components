import 'package:pageloader/html.dart';
import 'package:pageloader/webdriver.dart';

part 'card_po.g.dart';

@PageObject()
@CheckTag('test')
abstract class TestPO {
  @ByTagName('skawa-card')
  CardPO get card;

  TestPO();

  factory TestPO.create(PageLoaderElement context) = $TestPO.create;
}

@PageObject()
abstract class CardPO {
  PageLoaderElement context;

  CardPO();

  factory CardPO.create(PageLoaderElement context) = $CardPO.create;

  @ByTagName('skawa-card-header')
  HeaderPO get header;

  @ByCss('.actions')
  ActionPO get actions;

  @ByTagName('skawa-card-content')
  ContentPO get content;
}

@PageObject()
abstract class ContentPO {
  ContentPO();

  factory ContentPO.create(PageLoaderElement context) = $ContentPO.create;

  @root
  PageLoaderElement get rootElement;
}

@PageObject()
abstract class ActionPO {
  ActionPO();

  factory ActionPO.create(PageLoaderElement context) = $ActionPO.create;

  @root
  PageLoaderElement get rootElement;
}

@PageObject()
abstract class HeaderPO {
  HeaderPO();

  factory HeaderPO.create(PageLoaderElement context) = $HeaderPO.create;

  @root
  PageLoaderElement get rootElement;

  @ByTagName('skawa-header-image')
  PageLoaderElement get image;

  @ByTagName('skawa-header-title')
  PageLoaderElement get title;

  @ByTagName('skawa-header-subhead')
  PageLoaderElement get subhead;

  @ByTagName('skawa-card-actions')
  PageLoaderElement get actions;
}

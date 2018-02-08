@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:pageloader/webdriver.dart';
import 'package:skawa_components/src/components/card/card.dart';
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';

@AngularEntrypoint()
Future main() async {
  tearDown(disposeAnyRunningTest);
  group('Card | ', () {
    test('initialization a raw card', () async {
      final fixture = await new NgTestBed<CardTestComponent>().create();
      await fixture.resolvePageObject/*<TestPO>*/(TestPO);
    });
    test('initialization a card with action and content', () async {
      final fixture = await new NgTestBed<CardTestComponent>().create(
          beforeChangeDetection: (testElement) {
        testElement.hasAction = true;
        testElement.hasContent = true;
      });
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      expect(
          await (await pageObject.card.actions)
              .rootElement
              .classes
              .contains('in-header'),
          isFalse);
      expect(
          await (await pageObject.card.content)
              .rootElement
              .classes
              .contains('with-header'),
          isFalse);
      expect(
          await (await pageObject.card.content)
              .rootElement
              .classes
              .contains('skawa-collapsed'),
          isFalse);
    });
    test(
        'initialization a card with action and content then toogle the content 1X',
        () async {
      final fixture = await new NgTestBed<CardTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement.hasAction = true;
        testElement.hasContent = true;
      });
      var content = (await pageObject.card.content).rootElement;
      await content.click();
      expect(
          await (await pageObject.card.actions)
              .rootElement
              .classes
              .contains('in-header'),
          isFalse);
      expect(await content.classes.contains('with-header'), isFalse);
      expect(await content.classes.contains('skawa-collapsed'), isTrue);
    });
    test(
        'initialization a card with action and content then toogle the content 2X',
        () async {
      final fixture = await new NgTestBed<CardTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement.hasContent = true;
        testElement.hasAction = true;
      });
      var content = (await pageObject.card.content).rootElement;
      await content.click();
      await content.click();
      expect(
          await (await pageObject.card.actions)
              .rootElement
              .classes
              .contains('in-header'),
          isFalse);
      expect(await content.classes.contains('with-header'), isFalse);
      expect(await content.classes.contains('skawa-collapsed'), isFalse);
    });
    test(
        'initialization a card with action, content, header and an action in the header',
        () async {
      final fixture = await new NgTestBed<CardTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement.hasHeader = true;
        testElement.hasHeaderAction = true;
        testElement.hasAction = true;
      });
      await fixture.update((testElement) {
        testElement.hasContent = true;
      });
      expect(
          await (await pageObject.card.actions)
              .rootElement
              .classes
              .contains('in-header'),
          isFalse);
      expect(
          await (await pageObject.card.content)
              .rootElement
              .classes
              .contains('with-header'),
          isTrue);
      expect(
          await (await pageObject.card.content)
              .rootElement
              .classes
              .contains('skawa-collapsed'),
          isFalse);
      expect(
          await (await pageObject.card.header)
              .rootElement
              .classes
              .contains('with-actions'),
          isTrue);
      expect(
          await (await pageObject.card.header)
              .rootElement
              .classes
              .contains('with-subhead'),
          isFalse);
      expect(
          await (await pageObject.card.header)
              .rootElement
              .classes
              .contains('with-title-image'),
          isFalse);
    });
    test(
        'initialization a card with action, content and a header with action, title, subheader and image',
        () async {
      final fixture = await new NgTestBed<CardTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement.hasHeader = true;
        testElement.hasHeaderAction = true;
        testElement.hasAction = true;
        testElement.hasImage = true;
        testElement.hasTitle = true;
        testElement.hasSubHead = true;
      });
      await fixture.update((testElement) {
        testElement.hasContent = true;
      });
      expect(
          await (await pageObject.card.actions)
              .rootElement
              .classes
              .contains('in-header'),
          isFalse);
      expect(
          await (await pageObject.card.content)
              .rootElement
              .classes
              .contains('with-header'),
          isTrue);
      expect(
          await (await pageObject.card.content)
              .rootElement
              .classes
              .contains('skawa-collapsed'),
          isFalse);
      expect(
          await (await pageObject.card.header)
              .rootElement
              .classes
              .contains('with-actions'),
          isTrue);
      expect(
          await (await pageObject.card.header)
              .rootElement
              .classes
              .contains('with-subhead'),
          isTrue);
      expect(
          await (await pageObject.card.header)
              .rootElement
              .classes
              .contains('with-title-image'),
          isTrue);
    });
  });
}

@Component(
  selector: 'test',
  template: '''
  <skawa-card>
    <skawa-card-header [statusColor]="statusColor" *ngIf="hasHeader">
        <skawa-header-image *ngIf="hasImage"></skawa-header-image>
        <skawa-header-title *ngIf="hasTitle"></skawa-header-title>
        <skawa-header-subhead *ngIf="hasSubHead"></skawa-header-subhead>
        <skawa-card-actions *ngIf="hasHeaderAction"></skawa-card-actions>
    </skawa-card-header>
    <skawa-card-actions class="actions" *ngIf="hasAction"></skawa-card-actions>
    <skawa-card-content *ngIf="hasContent" #f (click)="f.toggle()"></skawa-card-content>
  </skawa-card>
     ''',
  directives: const [
    skawaCardDirectives,
    NgIf,
  ],
)
class CardTestComponent {
  String statusColor;
  bool hasHeader = false;
  bool hasImage = false;
  bool hasTitle = false;
  bool hasSubHead = false;
  bool hasHeaderAction = false;
  bool hasContent = false;
  bool hasAction = false;
}

@EnsureTag('test')
class TestPO {
  @ByTagName('skawa-card')
  CardPO card;
}

class CardPO {
  @inject
  PageLoader loader;

  Future<HeaderPO> get header =>
      loader.getInstance(HeaderPO, loader.globalContext);

  Future<ActionPO> get actions =>
      loader.getInstance(ActionPO, loader.globalContext);

  Future<ContentPO> get content =>
      loader.getInstance(ContentPO, loader.globalContext);
}

@ByTagName('skawa-card-content')
class ContentPO {
  @root
  PageLoaderElement rootElement;
}

@ByCss('.actions')
class ActionPO {
  @root
  PageLoaderElement rootElement;
}

@ByTagName('skawa-card-header')
class HeaderPO {
  @root
  PageLoaderElement rootElement;

  @optional
  @ByTagName('skawa-header-image')
  PageLoaderElement image;

  @optional
  @ByTagName('skawa-header-title')
  PageLoaderElement title;

  @optional
  @ByTagName('skawa-header-subhead')
  PageLoaderElement subhead;

  @optional
  @ByTagName('skawa-card-actions')
  PageLoaderElement actions;
}

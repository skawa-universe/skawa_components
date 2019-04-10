@TestOn('browser')
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/webdriver.dart';
import 'package:skawa_material_components/card/card.dart';
import 'package:test/test.dart';

import 'card_po.dart';

import 'card_test.template.dart' as ng;

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);
  group('Card | ', () {
    test('initialization a raw card', () async {
      final fixture = await NgTestBed<CardTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      expect(pageObject.card, isNotNull);
    });
    final String inHeader = 'in-header';
    final String withHeader = 'with-header';
    final String collapsed = 'skawa-collapsed';
    final String withAction = 'with-actions';
    final String withSubhead = 'with-subhead';
    final String withTitleImage = 'with-title-image';
    test('initialization a card with action and content', () async {
      final fixture = await NgTestBed<CardTestComponent>().create(beforeChangeDetection: (testElement) {
        testElement
          ..hasAction = true
          ..hasContent = true;
      });
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      expect(pageObject.card.actions.rootElement.classes.contains(inHeader), isFalse);
      expect(pageObject.card.content.rootElement.classes.contains(withHeader), isFalse);
      expect(pageObject.card.content.rootElement.classes.contains(collapsed), isFalse);
    });
    test('initialization a card with action and content then toogle the content 1X', () async {
      final fixture = await NgTestBed<CardTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      await fixture.update((testElement) {
        testElement
          ..hasAction = true
          ..hasContent = true;
      });
      PageLoaderElement content = pageObject.card.content.rootElement;
      await content.click();
      expect(pageObject.card.actions.rootElement.classes.contains(inHeader), isFalse);
      expect(pageObject.card.content.rootElement.classes.contains(withHeader), isFalse);
      expect(pageObject.card.content.rootElement.classes.contains(collapsed), isTrue);
    });
    test('initialization a card with action and content then toogle the content 2X', () async {
      final fixture = await NgTestBed<CardTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      await fixture.update((testElement) {
        testElement
          ..hasAction = true
          ..hasContent = true;
      });
      PageLoaderElement content = pageObject.card.content.rootElement;
      await content.click();
      await content.click();
      expect(pageObject.card.actions.rootElement.classes.contains(inHeader), isFalse);
      expect(content.classes.contains(withHeader), isFalse);
      expect(content.classes.contains(collapsed), isFalse);
    });
    test('initialization a card with action, content, header and an action in the header', () async {
      final fixture = await NgTestBed<CardTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      await fixture.update((testElement) {
        testElement
          ..hasHeader = true
          ..hasHeaderAction = true
          ..hasAction = true;
      });
      await fixture.update((testElement) => testElement.hasContent = true);
      expect((pageObject.card.actions).rootElement.classes.contains(inHeader), isFalse);
      expect(pageObject.card.content.rootElement.classes.contains(withHeader), isTrue);
      expect(pageObject.card.content.rootElement.classes.contains(collapsed), isFalse);
      expect(pageObject.card.header.rootElement.classes.contains(withAction), isTrue);
      expect(pageObject.card.header.rootElement.classes.contains(withSubhead), isFalse);
      expect(pageObject.card.header.rootElement.classes.contains(withTitleImage), isFalse);
    });
    test('initialization a card with action, content and a header with action, title, subheader and image', () async {
      final fixture = await NgTestBed<CardTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      await fixture.update((testElement) {
        testElement
          ..hasHeader = true
          ..hasHeaderAction = true
          ..hasAction = true
          ..hasImage = true
          ..hasTitle = true
          ..hasSubHead = true;
      });
      await fixture.update((testElement) => testElement.hasContent = true);
      expect((pageObject.card.actions).rootElement.classes.contains(inHeader), isFalse);
      expect(pageObject.card.content.rootElement.classes.contains(withHeader), isTrue);
      expect(pageObject.card.header.rootElement.classes.contains(withAction), isTrue);
      expect(pageObject.card.header.rootElement.classes.contains(withSubhead), isTrue);
    });
  });
}

@Component(selector: 'test', template: '''
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
     ''', directives: [skawaCardDirectives, NgIf])
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

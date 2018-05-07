//@Tags(const ['aot'])
//@TestOn('browser')
//import 'dart:async';
//import 'package:angular/angular.dart';
//import 'package:angular_test/angular_test.dart';
//import 'package:pageloader/html.dart';
//import 'package:pageloader/src/annotations.dart';
//import 'package:pageloader/webdriver.dart';
//import 'package:skawa_material_components/card/card.dart';
//import 'package:test/test.dart';
//import 'package:pageloader/objects.dart';
//
//void main() {
//  tearDown(disposeAnyRunningTest);
//  group('Card | ', () {
//    test('initialization a raw card', () async {
//      final fixture = await new NgTestBed<CardTestComponent>().create();
//      await fixture.resolvePageObject/*<TestPO>*/(TestPO);
//    });
//    final String inHeader = 'in-header';
//    final String withHeader = 'with-header';
//    final String collapsed = 'skawa-collapsed';
//    final String withAction = 'with-actions';
//    final String withSubhead = 'with-subhead';
//    final String withTitleImage = 'with-title-image';
//    test('initialization a card with action and content', () async {
//      final fixture = await new NgTestBed<CardTestComponent>().create(beforeChangeDetection: (testElement) {
//        testElement
//          ..hasAction = true
//          ..hasContent = true;
//      });
//      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
//      expect((await pageObject.card.actions).rootElement.classes, neverEmits(inHeader));
//      expect((await pageObject.card.content).rootElement.classes, neverEmits(withHeader));
//      expect((await pageObject.card.content).rootElement.classes, neverEmits(collapsed));
//    });
//    test('initialization a card with action and content then toogle the content 1X', () async {
//      final fixture = await new NgTestBed<CardTestComponent>().create();
//      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
//      await fixture.update((testElement) {
//        testElement
//          ..hasAction = true
//          ..hasContent = true;
//      });
//      PageLoaderElement content = (await pageObject.card.content).rootElement;
//      await content.click();
//      expect((await pageObject.card.actions).rootElement.classes, neverEmits(inHeader));
//      expect(content.classes, neverEmits(withHeader));
//      expect(content.classes, mayEmit(collapsed));
//    });
//    test('initialization a card with action and content then toogle the content 2X', () async {
//      final fixture = await new NgTestBed<CardTestComponent>().create();
//      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
//      await fixture.update((testElement) {
//        testElement
//          ..hasAction = true
//          ..hasContent = true;
//      });
//      PageLoaderElement content = (await pageObject.card.content).rootElement;
//      await content.click();
//      await content.click();
//      expect((await pageObject.card.actions).rootElement.classes, neverEmits(inHeader));
//      expect(content.classes, neverEmits(withHeader));
//      expect(content.classes, neverEmits(collapsed));
//    });
//    test('initialization a card with action, content, header and an action in the header', () async {
//      final fixture = await new NgTestBed<CardTestComponent>().create();
//      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
//      await fixture.update((testElement) {
//        testElement
//          ..hasHeader = true
//          ..hasHeaderAction = true
//          ..hasAction = true;
//      });
//      await fixture.update((testElement) => testElement.hasContent = true);
//      expect((await pageObject.card.actions).rootElement.classes, neverEmits(inHeader));
//      expect((await pageObject.card.content).rootElement.classes, mayEmit(withHeader));
//      expect((await pageObject.card.content).rootElement.classes, neverEmits(collapsed));
//      expect((await pageObject.card.header).rootElement.classes, mayEmit(withAction));
//      expect((await pageObject.card.header).rootElement.classes, neverEmits(withSubhead));
//      expect((await pageObject.card.header).rootElement.classes, neverEmits(withTitleImage));
//    });
//    test('initialization a card with action, content and a header with action, title, subheader and image', () async {
//      final fixture = await new NgTestBed<CardTestComponent>().create();
//      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
//      await fixture.update((testElement) {
//        testElement
//          ..hasHeader = true
//          ..hasHeaderAction = true
//          ..hasAction = true
//          ..hasImage = true
//          ..hasTitle = true
//          ..hasSubHead = true;
//      });
//      await fixture.update((testElement) => testElement.hasContent = true);
//      expect((await pageObject.card.actions).rootElement.classes, neverEmits(inHeader));
//      expect((await pageObject.card.content).rootElement.classes, mayEmit(withHeader));
//      expect((await pageObject.card.content).rootElement.classes, neverEmits(collapsed));
//      expect((await pageObject.card.header).rootElement.classes, mayEmit(withAction));
//      expect((await pageObject.card.header).rootElement.classes, mayEmit(withSubhead));
//      expect((await pageObject.card.header).rootElement.classes, mayEmit(withTitleImage));
//    });
//  });
//}
//
//@Component(
//    selector: 'test',
//    template: '''
//  <skawa-card>
//    <skawa-card-header [statusColor]="statusColor" *ngIf="hasHeader">
//        <skawa-header-image *ngIf="hasImage"></skawa-header-image>
//        <skawa-header-title *ngIf="hasTitle"></skawa-header-title>
//        <skawa-header-subhead *ngIf="hasSubHead"></skawa-header-subhead>
//        <skawa-card-actions *ngIf="hasHeaderAction"></skawa-card-actions>
//    </skawa-card-header>
//    <skawa-card-actions class="actions" *ngIf="hasAction"></skawa-card-actions>
//    <skawa-card-content *ngIf="hasContent" #f (click)="f.toggle()"></skawa-card-content>
//  </skawa-card>
//     ''',
//    directives: const [skawaCardDirectives, NgIf])
//class CardTestComponent {
//  String statusColor;
//  bool hasHeader = false;
//  bool hasImage = false;
//  bool hasTitle = false;
//  bool hasSubHead = false;
//  bool hasHeaderAction = false;
//  bool hasContent = false;
//  bool hasAction = false;
//}
//
//@EnsureTag('test')
//class TestPO {
//  @ByTagName('skawa-card')
//  CardPO card;
//}
//
//class CardPO {
//  @inject
//  PageLoader loader;
//
//  Future<HeaderPO> get header => loader.getInstance(HeaderPO, loader.globalContext);
//
//  Future<ActionPO> get actions => loader.getInstance(ActionPO, loader.globalContext);
//
//  Future<ContentPO> get content => loader.getInstance(ContentPO, loader.globalContext);
//}
//
//@ByTagName('skawa-card-content')
//class ContentPO {
//  @root
//  PageLoaderElement rootElement;
//}
//
//@ByCss('.actions')
//class ActionPO {
//  @root
//  PageLoaderElement rootElement;
//}
//
//@ByTagName('skawa-card-header')
//class HeaderPO {
//  @root
//  PageLoaderElement rootElement;
//
//  @optional
//  @ByTagName('skawa-header-image')
//  PageLoaderElement image;
//
//  @optional
//  @ByTagName('skawa-header-title')
//  PageLoaderElement title;
//
//  @optional
//  @ByTagName('skawa-header-subhead')
//  PageLoaderElement subhead;
//
//  @optional
//  @ByTagName('skawa-card-actions')
//  PageLoaderElement actions;
//}

// @dart=2.10
@TestOn('browser')
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:skawa_components/directives/language_direction_directive.dart';
import 'package:test/test.dart';

import 'language_direction_test.template.dart' as ng;

part 'language_direction_test.g.dart';

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);
  group('LanguageDirection | ', () {
    final String textAlign = 'text-align';
    final String direction = 'direction';
    final String start = 'start';
    final String ltr = 'ltr';
    test('initialization on div element', () async {
      final fixture = await NgTestBed<DivTemplateComponent>(ng.DivTemplateComponentNgFactory).create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = DivTestPO.create(context);
      expect(pageObject.languageDirection.computedStyle[textAlign], start);
      expect(pageObject.languageDirection.computedStyle[direction], ltr);
    });
    test('setLanguageDirection on div element by latin text', () async {
      final fixture = await NgTestBed<DivTemplateComponent>(ng.DivTemplateComponentNgFactory)
          .create(beforeChangeDetection: (testElement) => testElement.content = 'cat');
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = DivTestPO.create(context);
      await pageObject.languageDirection.click();
      expect(pageObject.languageDirection.computedStyle[textAlign], start);
      expect(pageObject.languageDirection.computedStyle[direction], ltr);
    });
    test('setLanguageDirection on div element by arabic text', () async {
      final fixture = await NgTestBed<DivTemplateComponent>(ng.DivTemplateComponentNgFactory)
          .create(beforeChangeDetection: (testElement) => testElement.content = 'عن فكانت اسبوعين');
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = DivTestPO.create(context);
      await pageObject.languageDirection.click();
      expect(pageObject.languageDirection.computedStyle[textAlign], 'right');
      expect(pageObject.languageDirection.computedStyle[direction], 'rtl');
    });
    test('initialization on div element', () async {
      final fixture = await NgTestBed<InputTemplateComponent>(ng.InputTemplateComponentNgFactory).create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = InputTestPO.create(context);
      expect(pageObject.languageDirection.computedStyle[textAlign], start);
      expect(pageObject.languageDirection.computedStyle[direction], ltr);
    });
    test('setLanguageDirection on input element by latin text', () async {
      final fixture = await NgTestBed<InputTemplateComponent>(ng.InputTemplateComponentNgFactory)
          .create(beforeChangeDetection: (testElement) => testElement.content = 'cat');
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = InputTestPO.create(context);
      await pageObject.languageDirection.click();
      expect(pageObject.languageDirection.computedStyle[textAlign], start);
      expect(pageObject.languageDirection.computedStyle[direction], ltr);
    });
    test('setLanguageDirection on input element by arabic text', () async {
      final fixture = await NgTestBed<InputTemplateComponent>(ng.InputTemplateComponentNgFactory)
          .create(beforeChangeDetection: (testElement) => testElement.content = 'عن فكانت اسبوعين');
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = InputTestPO.create(context);
      await pageObject.languageDirection.click();
      expect(pageObject.languageDirection.computedStyle[textAlign], start);
      expect(pageObject.languageDirection.computedStyle[direction], 'rtl');
    });
  });
}

@Component(
    selector: 'test',
    template:
        '''<div class="dir" skawaLangugageDirection #f="skawaLangugageDirection" (click)="f.setLanguageDirection(content)"></div>''',
    directives: [LanguageDirectionDirective])
class DivTemplateComponent {
  String content;
}

@PageObject()
@CheckTag('test')
abstract class DivTestPO {
  DivTestPO();

  factory DivTestPO.create(PageLoaderElement context) = $DivTestPO.create;

  @ByClass('dir')
  PageLoaderElement get languageDirection;
}

@Component(
    selector: 'test',
    template:
        '''<input skawaLangugageDirection #f="skawaLangugageDirection" (click)="f.setLanguageDirection(content)"/>''',
    directives: [LanguageDirectionDirective])
class InputTemplateComponent {
  String content;
}

@PageObject()
@CheckTag('test')
abstract class InputTestPO {
  InputTestPO();

  factory InputTestPO.create(PageLoaderElement context) = $InputTestPO.create;

  @ByTagName('input')
  PageLoaderElement get languageDirection;
}

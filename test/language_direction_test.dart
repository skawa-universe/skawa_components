@Tags(const ['aot'])
@TestOn('browser')
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:angular/core.dart';
import 'package:skawa_components/src/directives/language_direction/language_direction_directive.dart';
import 'package:angular_test/angular_test.dart';

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);
  group('LanguageDirection | ', () {
    final String textAlign = 'text-align';
    final String direction = 'direction';
    final String start = 'start';
    final String ltr = 'ltr';
    test('initialization on div element', () async {
      final fixture = await new NgTestBed<DivTemplateComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<DivTestPO>*/(DivTestPO);
      expect(pageObject.languageDirection.computedStyle[textAlign], completion(start));
      expect(pageObject.languageDirection.computedStyle[direction], completion(ltr));
    });
    test('setLanguageDirection on div element by latin text', () async {
      final fixture = await new NgTestBed<DivTemplateComponent>()
          .create(beforeChangeDetection: (testElement) => testElement.content = 'cat');
      final pageObject = await fixture.resolvePageObject/*<DivTestPO>*/(DivTestPO);
      await pageObject.languageDirection.click();
      expect(pageObject.languageDirection.computedStyle[textAlign], completion(start));
      expect(pageObject.languageDirection.computedStyle[direction], completion(ltr));
    });
    test('setLanguageDirection on div element by arabic text', () async {
      final fixture = await new NgTestBed<DivTemplateComponent>()
          .create(beforeChangeDetection: (testElement) => testElement.content = 'عن فكانت اسبوعين');
      final pageObject = await fixture.resolvePageObject/*<DivTestPO>*/(DivTestPO);
      await pageObject.languageDirection.click();
      expect(pageObject.languageDirection.computedStyle[textAlign], completion('right'));
      expect(pageObject.languageDirection.computedStyle[direction], completion('rtl'));
    });
    test('initialization on div element', () async {
      final fixture = await new NgTestBed<InputTemplateComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<InputTestPO>*/(InputTestPO);
      expect(pageObject.languageDirection.computedStyle[textAlign], completion(start));
      expect(pageObject.languageDirection.computedStyle[direction], completion(ltr));
    });
    test('setLanguageDirection on input element by latin text', () async {
      final fixture = await new NgTestBed<InputTemplateComponent>()
          .create(beforeChangeDetection: (testElement) => testElement.content = 'cat');
      final pageObject = await fixture.resolvePageObject/*<InputTestPO>*/(InputTestPO);
      await pageObject.languageDirection.click();
      expect(pageObject.languageDirection.computedStyle[textAlign], completion(start));
      expect(pageObject.languageDirection.computedStyle[direction], completion(ltr));
    });
    test('setLanguageDirection on input element by arabic text', () async {
      final fixture = await new NgTestBed<InputTemplateComponent>()
          .create(beforeChangeDetection: (testElement) => testElement.content = 'عن فكانت اسبوعين');
      final pageObject = await fixture.resolvePageObject/*<InputTestPO>*/(InputTestPO);
      await pageObject.languageDirection.click();
      expect(pageObject.languageDirection.computedStyle[textAlign], completion(start));
      expect(pageObject.languageDirection.computedStyle[direction], completion('rtl'));
    });
  });
}

@Component(
    selector: 'test',
    template:
        '''<div skawaLangugageDirection #f="skawaLangugageDirection" (click)="f.setLanguageDirection(content)"></div>''',
    directives: const [LanguageDirectionDirective])
class DivTemplateComponent {
  String content;
}

@EnsureTag('test')
class DivTestPO {
  @ByTagName('div')
  PageLoaderElement languageDirection;
}

@Component(
    selector: 'test',
    template:
        '''<input skawaLangugageDirection #f="skawaLangugageDirection" (click)="f.setLanguageDirection(content)"/>''',
    directives: const [LanguageDirectionDirective])
class InputTemplateComponent {
  String content;
}

@EnsureTag('test')
class InputTestPO {
  @ByTagName('input')
  PageLoaderElement languageDirection;
}

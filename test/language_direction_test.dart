@Tags(const ['aot'])
@TestOn('browser')
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:angular2/core.dart';
import 'package:skawa_components/src/directives/language_direction/language_direction_directive.dart';
import 'package:angular_test/angular_test.dart';

@AngularEntrypoint()
main() {
  tearDown(disposeAnyRunningTest);
  group('LanguageDirection | ', () {
    test('initialization on div element', () async {
      final fixture = await new NgTestBed<DivTemplateComponent>().create();
      final pageobject = await fixture.resolvePageObject /*<DivTestPO>*/(
        DivTestPO,
      );
      expect(await pageobject.langugageDirection.computedStyle['text-align'], 'start');
      expect(await pageobject.langugageDirection.computedStyle['direction'], 'ltr');
    });
    test('setLanguageDirection on div element by latin text', () async {
      final fixture = await new NgTestBed<DivTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.content = 'cat';
      });
      final pageobject = await fixture.resolvePageObject /*<DivTestPO>*/(
        DivTestPO,
      );
      await pageobject.langugageDirection.click();
      expect(await pageobject.langugageDirection.computedStyle['text-align'], 'start');
      expect(await pageobject.langugageDirection.computedStyle['direction'], 'ltr');
    });
    test('setLanguageDirection on div element by arabic text', () async {
      final fixture = await new NgTestBed<DivTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.content = 'عن فكانت اسبوعين';
      });
      final pageobject = await fixture.resolvePageObject /*<DivTestPO>*/(
        DivTestPO,
      );
      await pageobject.langugageDirection.click();
      expect(await pageobject.langugageDirection.computedStyle['text-align'], 'right');
      expect(await pageobject.langugageDirection.computedStyle['direction'], 'rtl');
    });
    test('initialization on div element', () async {
      final fixture = await new NgTestBed<InputTemplateComponent>().create();
      final pageobject = await fixture.resolvePageObject /*<InputTestPO>*/(
        InputTestPO,
      );
      expect(await pageobject.langugageDirection.computedStyle['text-align'], 'start');
      expect(await pageobject.langugageDirection.computedStyle['direction'], 'ltr');
    });
    test('setLanguageDirection on div element by latin text', () async {
      final fixture = await new NgTestBed<InputTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.content = 'cat';
      });
      final pageobject = await fixture.resolvePageObject /*<InputTestPO>*/(
        InputTestPO,
      );
      await pageobject.langugageDirection.click();
      expect(await pageobject.langugageDirection.computedStyle['text-align'], 'start');
      expect(await pageobject.langugageDirection.computedStyle['direction'], 'ltr');
    });
    test('setLanguageDirection on div element by arabic text', () async {
      final fixture = await new NgTestBed<InputTemplateComponent>().create(beforeChangeDetection: (testElement) {
        testElement.content = 'عن فكانت اسبوعين';
      });
      final pageobject = await fixture.resolvePageObject /*<InputTestPO>*/(
        InputTestPO,
      );
      await pageobject.langugageDirection.click();
      expect(await pageobject.langugageDirection.computedStyle['text-align'], 'start');
      expect(await pageobject.langugageDirection.computedStyle['direction'], 'rtl');
    });
  });
}

@Component(
    selector: 'test',
    template: '''
    <div skawaLangugageDirection #f="skawaLangugageDirection" (click)="f.setLanguageDirection(content)"></div>
  ''',
    directives: const [LanguageDirectionDirective]
)
class DivTemplateComponent {
  String content;

  @ViewChild(LanguageDirectionDirective)
  LanguageDirectionDirective languageDirectionDirective;
}

@EnsureTag('test')
class DivTestPO {
  @ByTagName('div')
  PageLoaderElement langugageDirection;
}


@Component(
    selector: 'test',
    template: '''
    <input skawaLangugageDirection #f="skawaLangugageDirection" (click)="f.setLanguageDirection(content)"/>
  ''',
    directives: const [LanguageDirectionDirective])
class InputTemplateComponent {
  String content;
}

@EnsureTag('test')
class InputTestPO {
  @ByTagName('input')
  PageLoaderElement langugageDirection;
}
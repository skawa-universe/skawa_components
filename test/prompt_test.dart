@Tags(const ['aot'])
@TestOn('browser')
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:angular_components/laminate/popup/module.dart';
import 'package:skawa_components/src/components/prompt/prompt.dart';
import 'package:test/test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';

void main() {
  tearDown(disposeAnyRunningTest);
  group('Prompt |', () {
    test('initialization', () async {
      final fixture = await new NgTestBed<PromptTestComponent>().create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      expect(pageObject.prompt, isNotNull);
    });

    test('displays a message', () async {
      final fixture = await new NgTestBed<PromptTestComponent>().create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.query<PromptComponent>((debugElement) {
        return debugElement.componentInstance is PromptComponent;
      }, (PromptComponent component) {
        expect((component.messageText.nativeElement as Element).innerHtml, 'Should you?');
      });
    });

    test('calls yes function', () async {
      final fixture = await new NgTestBed<PromptTestComponent>().create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.query<PromptComponent>((debugElement) {
        return debugElement.componentInstance is PromptComponent;
      }, (PromptComponent component) {
        component.yesNoButtonsComponent.yesButton.handleClick(new MouseEvent('test'));
      });
      String msg = await pageObject.messageSpan.innerText;
      expect(msg, 'Yes');
    });

    test('calls no function', () async {
      final fixture = await new NgTestBed<PromptTestComponent>().create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.query<PromptComponent>((debugElement) {
        return debugElement.componentInstance is PromptComponent;
      }, (PromptComponent component) {
        component.yesNoButtonsComponent.noButton.handleClick(new MouseEvent('test'));
      });
      String msg = await pageObject.messageSpan.innerText;
      expect(msg, 'No');
    });

    test('modal disappears after clicking yes or no if we want it to', () async {
      final fixture = await new NgTestBed<PromptTestComponent>().create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.query<PromptComponent>((debugElement) {
        return debugElement.componentInstance is PromptComponent;
      }, (PromptComponent component) {
        component.yesNoButtonsComponent.noButton.handleClick(new MouseEvent('test'));
      });
      await fixture.query<PromptComponent>((debugElement) {
        return debugElement.componentInstance is PromptComponent;
      }, (PromptComponent component) {
        expect((component.messageText.nativeElement as Element).ownerDocument.querySelector('.pane.modal').classes,
            isNot(contains('visible')));
      });
    });
  });
}

@Component(
    selector: 'test',
    directives: const [PromptComponent],
    template: '''
  <prompt [message]="message" [yes]="yesCallback" [no]="noCallback" [visible]="isVisible"></prompt>
  <span #messageSpan></span>
  ''',
    providers: const [popupBindings],
    changeDetection: ChangeDetectionStrategy.OnPush)
class PromptTestComponent {
  @ViewChild('messageSpan')
  ElementRef messageSpan;

  void changeText(String input) => (messageSpan.nativeElement as SpanElement).innerHtml = input;

  void yesCallback() {
    changeText('Yes');
    isVisible = false;
  }

  void noCallback() {
    changeText('No');
    isVisible = false;
  }

  final String message = 'Should you?';

  bool isVisible = true;
}

@EnsureTag('test')
class TestPO {
  @ByTagName('prompt')
  PageLoaderElement prompt;

  @ByTagName('span')
  PageLoaderElement messageSpan;
}

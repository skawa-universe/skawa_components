@TestOn('browser')
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:angular_components/laminate/popup/module.dart';
import 'package:skawa_components/prompt/prompt.dart';
import 'package:test/test.dart';
import 'package:pageloader/html.dart';

import 'prompt_test.template.dart' as ng;

part 'prompt_test.g.dart';

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);
  final testBed = new NgTestBed<PromptTestComponent>();
  NgTestFixture<PromptTestComponent> fixture;
  TestPO pageObject;
  group('Prompt |', () {
    setUp(() async {
      fixture = await testBed.create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      pageObject = TestPO.create(context);
    });
    test('initialization', () async {
      expect(pageObject.prompt, isNotNull);
      expect(fixture.assertOnlyInstance.prompt.messageText.text, ' Should you?');
      expect(fixture.assertOnlyInstance.prompt.modal.visible, isTrue);
    });
    test('calls yes function', () async {
      await fixture.update(
          (PromptTestComponent cmp) => cmp.prompt.yesNoButtonsComponent.yesButton..handleClick(new MouseEvent('test')));
      expect(fixture.assertOnlyInstance.prompt.messageText.text, ' Should you?');
      expect(pageObject.messageSpan.innerText, 'Yes');
      expect(fixture.assertOnlyInstance.prompt.modal.visible, isFalse);
    });

    test('calls no function', () async {
      await fixture.update(
          (PromptTestComponent cmp) => cmp.prompt.yesNoButtonsComponent.noButton.handleClick(new MouseEvent('test')));
      expect(fixture.assertOnlyInstance.prompt.messageText.text, ' Should you?');
      expect(pageObject.messageSpan.innerText, 'No');
      expect(fixture.assertOnlyInstance.prompt.modal.visible, isFalse);
    });

    test('modal disappears after clicking yes or no if we want it to', () async {
      await fixture.update(
          (PromptTestComponent cmp) => cmp.prompt.yesNoButtonsComponent.noButton.handleClick(new MouseEvent('test')));
      expect(fixture.assertOnlyInstance.prompt.modal.visible, isFalse);
    });
  });
}

@Component(selector: 'test', template: '''
  <skawa-prompt [message]="message" [yes]="yesCallback" [no]="noCallback" [visible]="isVisible"></skawa-prompt>
  <span #messageSpan></span>
  ''', directives: [SkawaPromptComponent], providers: [popupBindings])
class PromptTestComponent {
  final String message = 'Should you?';

  bool isVisible = true;

  @ViewChild('messageSpan')
  HtmlElement messageSpan;

  @ViewChild(SkawaPromptComponent)
  SkawaPromptComponent prompt;

  void changeText(String input) => (messageSpan as SpanElement).innerHtml = input;

  void yesCallback() {
    changeText('Yes');
    isVisible = false;
  }

  void noCallback() {
    changeText('No');
    isVisible = false;
  }
}

@PageObject()
@CheckTag('test')
abstract class TestPO {
  TestPO();

  factory TestPO.create(PageLoaderElement context) = $TestPO.create;

  @root
  PageLoaderElement get rootElement;

//  PageLoaderElement get messageP => rootElement.getElementsByCss('message').first;

  @ByTagName('skawa-prompt')
  PromptPO get prompt;

  @ByTagName('span')
  PageLoaderElement get messageSpan;
}

@PageObject()
abstract class PromptPO {
  PromptPO();

  factory PromptPO.create(PageLoaderElement context) = $PromptPO.create;

  @ByClass('message')
  PageLoaderElement get messageP;

  @ByClass('btn-yes')
  PageLoaderElement get yesButton;

  @ByClass('btn-no')
  PageLoaderElement get noButton;
}

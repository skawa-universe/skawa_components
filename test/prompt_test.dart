@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:skawa_components/src/components/prompt/prompt.dart';
import 'package:test/test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);
  group('Prompt |', () {
    test('initialization', () async {
      final fixture = await new NgTestBed<PromptTestComponent>().create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      expect(pageObject.prompt, isNotNull);
    });
  });
}

@Component(
    selector: 'test',
    directives: const [PromptComponent],
    template: '''
  <prompt [message]="message" [yes]="yesCallback" [no]="noCallBack" [visible]="true"></prompt>
  <span #messageSpan></span>
  ''',
    changeDetection: ChangeDetectionStrategy.OnPush
)
class PromptTestComponent {
  @ViewChild('messageSpan')
  ElementRef messageSpan;

  void changeText(String input) => (messageSpan.nativeElement as SpanElement).innerHtml = input;

  void yesCallback() => null;

  void noCallback() => null;

  final String message = 'Should you?';
}

@EnsureTag('test')
class TestPO {
  @ByTagName('prompt')
  PromptPO prompt;

  @ByTagName('span')
  PageLoaderElement messageSpan;
}

class PromptPO {
  @root
  PageLoaderElement rootElement;

  @optional
  @ByTagName('p')
  PageLoaderElement question;

  @optional
  @ByTagName('material-yes-no-buttons')
  PageLoaderElement buttons;
}

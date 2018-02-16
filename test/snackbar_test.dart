@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:skawa_components/src/components/snackbar/snackbar.dart';
import 'package:test/test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);
  group('Snackbar |', () {
    test('initializing', () async {
      final bed = new NgTestBed<SnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      expect(pageObject.snackbar, isNotNull);
    });

    test('displays a message', () async {
      final bed = new NgTestBed<SnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.update((testElement) {
        testElement.showMessage('hello');
      });
      await new Future.delayed(new Duration(milliseconds: 2000), () => null);
      await fixture.query<SkawaSnackbarComponent>((element) {
        return element.componentInstance is SkawaSnackbarComponent;
      }, (SkawaSnackbarComponent snackbar) {
        expect(snackbar.message.text, 'hello');
        expect(snackbar.show, true);
      });
      expect(pageObject.snackbar.messageContainer.classes, mayEmit('show'));
    });

    test('slides out after default duration (3 seconds)', () async {
      final bed = new NgTestBed<SnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.update((testElement) {
        testElement.showMessage('hello');
      });
      await new Future.delayed(new Duration(seconds: 5), () => null);
      expect(pageObject.snackbar.messageContainer.classes, neverEmits('show'));
    });

    test('slides out after specified duration(2 seconds)', () async {
      final bed = new NgTestBed<SnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.update((testElement) {
        testElement.showMessage('hello', duration: new Duration(seconds: 2));
      });
      await new Future.delayed(new Duration(seconds: 3), () => null);
      expect(pageObject.snackbar.messageContainer.classes, neverEmits('show'));
    });

    test('displays button if callback is specified', () async {
      final bed = new NgTestBed<SnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.update((testElement) {
        testElement.showMessageWithCallback('call me back', callback: () => print('call me back'));
      });
      await new Future.delayed(new Duration(milliseconds: 1000), () => null);
      PageLoaderElement button = await pageObject.snackbar.rootElement.getElementsByCss('material-button').first;
      String buttonText = await button.visibleText;
      expect(button, isNotNull);
      expect(buttonText, 'call me back');
    });

    test('callback on button click', () async {
      final bed = new NgTestBed<SnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.update((testElement) {
        testElement.showMessageWithCallback('call me back',
            callback: () => testElement.displayMsgOnSpan('callback done'));
      });
      await new Future.delayed(new Duration(milliseconds: 1000), () => null);
      PageLoaderElement button = await pageObject.snackbar.rootElement.getElementsByCss('material-button').first;
      await button.click();
      String spanText = await pageObject.messageSpan.innerText;
      expect(spanText, contains('callback done'));
    });
  });
}

@Component(
    selector: 'test',
    directives: const [SkawaSnackbarComponent],
    template: '''
  <skawa-snackbar></skawa-snackbar>
  <span #messageSpan></span>
  ''',
    providers: const [SnackbarService],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SnackbarTestComponent {
  final SnackbarService _snackbarService;
  final ChangeDetectorRef cd;

  SnackbarTestComponent(this._snackbarService, this.cd);

  @ViewChild('messageSpan')
  ElementRef messageSpan;

  void showMessage(String message, {Duration duration}) => _snackbarService.showMessage(message, duration: duration);

  void showMessageWithCallback(String message, {Duration duration, Function callback}) =>
      _snackbarService.showMessage(message,
          duration: duration,
          action: new SnackAction()
            ..label = 'call me back'
            ..callback = callback);

  void displayMsgOnSpan(String message) => (messageSpan.nativeElement as SpanElement).innerHtml = message;
}

@EnsureTag('test')
class TestPO {
  @ByTagName('skawa-snackbar')
  SnackbarPO snackbar;

  @ByTagName('span')
  PageLoaderElement messageSpan;
}

class SnackbarPO {
  @root
  PageLoaderElement rootElement;

  @optional
  @ByTagName('div')
  PageLoaderElement messageContainer;

  @optional
  @ByTagName('material-button')
  PageLoaderElement materialButton;
}

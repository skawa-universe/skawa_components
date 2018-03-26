@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:skawa_materialish_components/snackbar/snackbar.dart';
import 'package:test/test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';

void main() {
  tearDown(disposeAnyRunningTest);
  final testBed = new NgTestBed<SnackbarTestComponent>();
  NgTestFixture<SnackbarTestComponent> fixture;
  TestPO pageObject;
  group('Snackbar |', () {
    setUp(() async {
      fixture = await testBed.create();
      pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
    });
    test('initializing', () async {
      expect(pageObject.snackbar, isNotNull);
    });

    test('displays a message', () async {
      await fixture.update((testElement) {
        testElement.callbackString = 'hello';
      });
      await pageObject.messageSpan.click();
      await fixture.query<SkawaSnackbarComponent>((element) => element.componentInstance is SkawaSnackbarComponent,
          (SkawaSnackbarComponent snackbar) {
        expect(snackbar.message.text, 'hello');
        expect(snackbar.show, true);
      });
      expect(pageObject.snackbar.messageContainer.classes, mayEmit('show'));
    });

    test('slides out after default duration (3 seconds)', () async {
      await pageObject.messageSpan.click();
      await new Future.delayed(new Duration(seconds: 5), () => null);
      await fixture.query<SkawaSnackbarComponent>((element) => element.componentInstance is SkawaSnackbarComponent,
          (SkawaSnackbarComponent snackbar) => expect(snackbar.show, false));
    });

    test('slides out after specified duration(2 seconds)', () async {
      await fixture.update((testElement) {
        testElement
          ..callbackString = 'hello'
          ..callbackDuration = (new Duration(seconds: 2));
      });
      await pageObject.messageSpan.click();
      await new Future.delayed(new Duration(seconds: 3), () => null);
      await fixture.query<SkawaSnackbarComponent>((element) => element.componentInstance is SkawaSnackbarComponent,
          (SkawaSnackbarComponent snackbar) => expect(snackbar.show, false));
    });

    test('displays button if callback is specified', () async {
      await fixture.update((testElement) async {
        testElement
          ..callbackString = 'call me back'
          ..callbackFunction = (() => print('call me back'));
      });
      await pageObject.callbackP.click();
      PageLoaderElement button = await pageObject.snackbar.rootElement.getElementsByCss('material-button').first;
      String buttonText = await button.visibleText;
      expect(button, isNotNull);
      expect(buttonText, 'call me back');
    });

    test('callback on button click', () async {
      await fixture.update((testElement) async {
        testElement
          ..callbackString = 'call me back'
          ..callbackFunction = (() => testElement.callbackValue = 'callback done');
      });
      await pageObject.callbackP.click();
      PageLoaderElement button = await pageObject.snackbar.rootElement.getElementsByCss('material-button').first;
      await button.click();
      String spanText = await pageObject.messageSpan.innerText;
      expect(spanText, contains('callback done'));
    });
  });
}

@Component(
    selector: 'test',
    template: '''
                <skawa-snackbar></skawa-snackbar>
                <span (click)="showMessage(callbackString,callbackDuration)">{{callbackValue}}</span>
                <p (click)="showMessageWithCallback(callbackString,callbackDuration,callbackFunction)">
                  {{callbackValue}}
                </p>
              ''',
    directives: const [SkawaSnackbarComponent],
    providers: const [SnackbarService])
class SnackbarTestComponent {
  final SnackbarService _snackbarService;
  final ChangeDetectorRef cd;

  String callbackValue;

  String callbackString;

  Duration callbackDuration;

  Function callbackFunction;

  @ViewChild(SkawaSnackbarComponent)
  SkawaSnackbarComponent snackbar;

  SnackbarTestComponent(this._snackbarService, this.cd);

  void showMessage(String message, [Duration duration]) => _snackbarService.showMessage(message, duration: duration);

  void showMessageWithCallback(String message, [Duration duration, Function callback]) =>
      _snackbarService.showMessage(message,
          duration: duration,
          action: new SnackAction()
            ..label = 'call me back'
            ..callback = callback);
}

@EnsureTag('test')
class TestPO {
  @ByTagName('skawa-snackbar')
  SnackbarPO snackbar;

  @ByTagName('span')
  PageLoaderElement messageSpan;

  @ByTagName('p')
  PageLoaderElement callbackP;
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

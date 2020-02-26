@TestOn('browser')
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:skawa_material_components/snackbar/snackbar.dart';
import 'package:test/test.dart';
import 'package:pageloader/html.dart';

import 'snackbar_test.template.dart' as ng;
import 'snackbar_test_po.dart';

@GenerateInjector([ClassProvider(SnackbarService)])
final InjectorFactory rootInjector = ng.rootInjector$Injector;

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);
  final testBed = NgTestBed<SnackbarTestComponent>(rootInjector: rootInjector);
  NgTestFixture<SnackbarTestComponent> fixture;
  TestPO pageObject;
  group('Snackbar |', () {
    setUp(() async {
      fixture = await testBed.create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      pageObject = TestPO.create(context);
    });
    test('initializing', () async => expect(pageObject.snackbar, isNotNull));
    test('displays a message', () async {
      await fixture.update((testElement) => testElement.callbackString = 'hello');
      await pageObject.messageSpan.click();
      await Future.delayed(SkawaSnackbarComponent.minimumSlideInDelay);
      expect(pageObject.snackbar.rootElement.displayed, isTrue);
      expect(pageObject.snackbar.messageContainer.visibleText, 'hello');
      expect(pageObject.snackbar.rootElement.classes.contains('show'), isTrue);
    });
    test('slides out after default duration (3 seconds)', () async {
      await pageObject.messageSpan.click();
      await Future.delayed(Duration(seconds: 5), () => null);
      expect(pageObject.snackbar.rootElement.classes.contains('show'), isFalse);
    }, skip: "This test is flaky currently");
    test('slides out after specified duration(2 seconds)', () async {
      await fixture.update((testElement) {
        testElement
          ..callbackString = 'hello'
          ..callbackDuration = (Duration(seconds: 2));
      });
      await pageObject.messageSpan.click();
      await Future.delayed(Duration(seconds: 3), () => null);
      expect(pageObject.snackbar.rootElement.classes.contains('show'), isFalse);
    });
    test('displays button if callback is specified', () async {
      await fixture.update((testElement) async {
        testElement
          ..callbackString = 'call me back'
          ..callbackFunction = (() => print('call me back'));
      });
      await pageObject.callbackP.click();
      await Future.delayed(SkawaSnackbarComponent.minimumSlideInDelay);
      PageLoaderElement button = pageObject.snackbar.materialButton;
      expect(button, isNotNull);
      expect(button.visibleText, 'call me back');
    });
    test('callback on button click', () async {
      await fixture.update((testElement) async {
        testElement
          ..callbackString = 'call me back'
          ..callbackFunction = (() => testElement.callbackValue = 'callback done');
      });
      await pageObject.callbackP.click();
      await Future.delayed(SkawaSnackbarComponent.minimumSlideInDelay);
      await pageObject.snackbar.materialButton.click();
      expect(pageObject.callbackP.innerText, contains('callback done'));
    });
  });
}

@Component(selector: 'test', template: '''
                <skawa-snackbar></skawa-snackbar>
                <span (click)="showMessage(callbackString,callbackDuration)"></span>
                <p (click)="showMessageWithCallback(callbackString,callbackDuration,callbackFunction)">
                  {{callbackValue}}
                </p>
              ''', directives: [SkawaSnackbarComponent])
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

  void showMessage(String message, [Duration duration]) {
    _snackbarService.showMessage(message, duration: duration);
  }

  void showMessageWithCallback(String message, [Duration duration, Function callback]) {
    SnackAction action = SnackAction()
      ..label = 'call me back'
      ..callback = callback;
    _snackbarService.showMessage(message, duration: duration, action: action);
  }
}

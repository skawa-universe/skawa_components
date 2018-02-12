@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:skawa_components/src/components/skawa_snackbar/skawa_snackbar.dart';
import 'package:test/test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';

@AngularEntrypoint()
main() {
  tearDown(disposeAnyRunningTest);
  group('SkawaSnackbar |', () {
    test('initializing', () async {
      final bed = new NgTestBed<SkawaSnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      expect(pageObject.skawaSnackbar, isNotNull);
    });

    test('displays a message (default duration: 3 sec)', () async {
      final bed = new NgTestBed<SkawaSnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.update((testElement) {
        testElement.showMessage('hello');
      });
      await new Future.delayed(new Duration(milliseconds: 1000), () async {
        await fixture.update();
        await fixture.query<SkawaSnackbarComponent>((element) {
          return element.componentInstance is SkawaSnackbarComponent;
        }, (SkawaSnackbarComponent snackbar) {
          expect(snackbar.message.text, 'hello');
          expect(snackbar.show, true);
          return false;
        });
        expect(pageObject.skawaSnackbar.messageContainer.classes, mayEmit('show'));
      });

      await new Future.delayed(new Duration(milliseconds: 1000), () => null);
      await fixture.query<SkawaSnackbarComponent>((element) {
        return element.componentInstance is SkawaSnackbarComponent;
      }, (SkawaSnackbarComponent snackbar) {
        expect(snackbar.message.text, 'hello');
        expect(snackbar.show, true);
      });

      await new Future.delayed(new Duration(milliseconds: 3000), () => null);
      await fixture.update();
      expect(pageObject.skawaSnackbar.messageContainer.classes, neverEmits('show'));
    });

    test('slides out after specified duration(2 seconds)', () async {
      final bed = new NgTestBed<SkawaSnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.update((testElement) {
        testElement.showMessage('hello', duration: new Duration(milliseconds: 2000));
      });
      await new Future.delayed(new Duration(milliseconds: 1000), () => null);
      await fixture.query<SkawaSnackbarComponent>((element) {
        return element.componentInstance is SkawaSnackbarComponent;
      }, (SkawaSnackbarComponent snackbar) {
        expect(snackbar.message.text, 'hello');
        expect(snackbar.show, true);
      });

      await new Future.delayed(new Duration(milliseconds: 1000), () => null);
      await fixture.query<SkawaSnackbarComponent>((element) {
        return element.componentInstance is SkawaSnackbarComponent;
      }, (SkawaSnackbarComponent snackbar) {
        expect(snackbar.message.text, 'hello');
        expect(snackbar.show, true);
      });

      await new Future.delayed(new Duration(milliseconds: 2000), () => null);
      await fixture.update();
      expect(pageObject.skawaSnackbar.messageContainer.classes, neverEmits('show'));
    });
  });
}

@Component(
  selector: 'test',
  directives: const [SkawaSnackbarComponent],
  template: '''
  <skawa-snackbar></skawa-snackbar>
  ''',
  providers: const [SnackbarService],
  changeDetection: ChangeDetectionStrategy.OnPush
)
class SkawaSnackbarTestComponent {
  final SnackbarService _snackbarService;
  final ChangeDetectorRef cd;

  SkawaSnackbarTestComponent(this._snackbarService, this.cd);

  void showMessage(String message, {Duration duration}) => _snackbarService.showMessage(message, duration: duration);
}

@EnsureTag('test')
class TestPO {
  @ByTagName('skawa-snackbar')
  SkawaSnackbarPO skawaSnackbar;
}

class SkawaSnackbarPO {
  @root
  PageLoaderElement rootElement;

  @optional
  @ByTagName('div')
  PageLoaderElement messageContainer;
}

@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:skawa_components/src/components/material_snackbar/material_snackbar.dart';
import 'package:test/test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';

@AngularEntrypoint()
main() {
  tearDown(disposeAnyRunningTest);
  group('MaterialSnackbar |', () {
    test('initializing', () async {
      final bed = new NgTestBed<MaterialSnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      expect(pageObject.materialSnackbar, isNotNull);
    });

    test('displays a message (default duration: 3 sec)', () async {
      final bed = new NgTestBed<MaterialSnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.update((testElement) {
        testElement.showMessage('hello');
      });
      await new Future.delayed(new Duration(milliseconds: 1000), () async {
        await fixture.update();
        await fixture.query<MaterialSnackbarComponent>((element) {
          return element.componentInstance is MaterialSnackbarComponent;
        }, (MaterialSnackbarComponent snackbar) {
          expect(snackbar.message.text, 'hello');
          expect(snackbar.show, true);
        });
        expect(pageObject.materialSnackbar.messageContainer.classes, mayEmit('show'));
        print('snackbar shows up');
      });


      await new Future.delayed(new Duration(milliseconds: 1000), () => null);
      await fixture.query<MaterialSnackbarComponent>((element) {
        return element.componentInstance is MaterialSnackbarComponent;
      }, (MaterialSnackbarComponent snackbar) {
        expect(snackbar.message.text, 'hello');
        expect(snackbar.show, true);
      });
      print('snackbar is still there after 1 second');

      await new Future.delayed(new Duration(milliseconds: 3000), () => null);
      await fixture.update();
      expect(pageObject.materialSnackbar.messageContainer.classes, neverEmits('show'));
      print('snackbar disappears after 3 seconds');
    });

    test('slides out after specified duration(2 seconds)', () async {
      final bed = new NgTestBed<MaterialSnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.update((testElement) {
        testElement.showMessage('hello', duration: new Duration(milliseconds: 2000));
      });
      await new Future.delayed(new Duration(milliseconds: 1000), () => null);
      await fixture.query<MaterialSnackbarComponent>((element) {
        return element.componentInstance is MaterialSnackbarComponent;
      }, (MaterialSnackbarComponent snackbar) {
        expect(snackbar.message.text, 'hello');
        expect(snackbar.show, true);
        print('snackbar shows up');
      });

      await new Future.delayed(new Duration(milliseconds: 1000), () => null);
      await fixture.query<MaterialSnackbarComponent>((element) {
        return element.componentInstance is MaterialSnackbarComponent;
      }, (MaterialSnackbarComponent snackbar) {
        expect(snackbar.message.text, 'hello');
        expect(snackbar.show, true);
      });
      print('snackbar is still there after 1 second');

      await new Future.delayed(new Duration(milliseconds: 2000), () => null);
      await fixture.update();
      expect(pageObject.materialSnackbar.messageContainer.classes, neverEmits('show'));
      print('snackbar disappears after 2 seconds');
    });
  });
}

@Component(
  selector: 'test',
  directives: const [MaterialSnackbarComponent],
  template: '''
  <material-snackbar></material-snackbar>
  ''',
  providers: const [SnackbarService],
  changeDetection: ChangeDetectionStrategy.OnPush
)
class MaterialSnackbarTestComponent {
  final SnackbarService _snackbarService;
  final ChangeDetectorRef cd;

  MaterialSnackbarTestComponent(this._snackbarService, this.cd);

  void showMessage(String message, {Duration duration}) => _snackbarService.showMessage(message, duration: duration);
}

@EnsureTag('test')
class TestPO {
  @ByTagName('material-snackbar')
  MaterialSnackbarPO materialSnackbar;
}

class MaterialSnackbarPO {
  @root
  PageLoaderElement rootElement;

  @optional
  @ByTagName('div')
  PageLoaderElement messageContainer;
}

@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:skawa_components/src/components/material_snackbar/material_snackbar.dart';
import 'package:angular_components/src/components/material_button/material_button.dart';
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
    test('displaying a message', () async {
      final bed = new NgTestBed<MaterialSnackbarTestComponent>();
      final fixture = await bed.create();
      final pageObject = await fixture.resolvePageObject(TestPO);
      await fixture.update((testElement) {
        testElement.showMessage('hello');
      });
      await new Future.delayed(new Duration(milliseconds: 1000), () => null);
      await fixture.query<MaterialSnackbarComponent>((element) {
        return element.componentInstance is MaterialSnackbarComponent;
      }, (MaterialSnackbarComponent snackbar) {
        expect(snackbar.message.text, 'hello');
        expect(snackbar.show, true);
      });
      expect(pageObject.materialSnackbar.classes, mayEmit('show'));
    });
  });
}

@Component(
  selector: 'test',
  directives: const [MaterialSnackbarComponent, MaterialButtonComponent],
  template: '''
  <material-snackbar></material-snackbar>
  <material-button (trigger)="showMessage('hello');"></material-button>
  ''',
  providers: const [SnackbarService],
  changeDetection: ChangeDetectionStrategy.OnPush
)
class MaterialSnackbarTestComponent {
  final SnackbarService _snackbarService;
  final ChangeDetectorRef cd;

  MaterialSnackbarTestComponent(this._snackbarService, this.cd);

  void showMessage(String message) => _snackbarService.showMessage(message);
}

@EnsureTag('test')
class TestPO {
  @ByTagName('material-snackbar')
  MaterialSnackbarPO materialSnackbar;

  @ByTagName('material-button')
  PageLoaderElement materialButton;
}

class MaterialSnackbarPO {
  @root
  PageLoaderElement rootElement;

  @optional
  @ByTagName('div')
  PageLoaderElement messageContainer;

  @optional
  @ByTagName('span')
  PageLoaderElement messageSpan;
}

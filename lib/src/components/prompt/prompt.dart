import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_components/src/components/material_dialog/material_dialog.dart';
import 'package:angular_components/src/components/material_yes_no_buttons/material_yes_no_buttons.dart';
import 'package:angular_components/src/laminate/components/modal/modal.dart';

@Component(
    selector: 'prompt',
    templateUrl: 'prompt.html',
    directives: const [
      MaterialDialogComponent,
      ModalComponent,
      MaterialYesNoButtonsComponent,
    ],
    preserveWhitespace: false,
    changeDetection: ChangeDetectionStrategy.OnPush)
class PromptComponent {
  final ChangeDetectorRef _cd;
  @Input('yes')
  Function yesCallback;

  @Input('no')
  Function noCallback;

  @Input()
  String message;

  @Input()
  String textYes = _textYes;

  @Input()
  String textNo = _textNo;

  @Input('visible')
  bool isVisible = false;

  // Only here for testing purposes
  @ViewChild('messageText')
  ElementRef messageText;
  //Only here for testing purposes
  @ViewChild(MaterialYesNoButtonsComponent)
  MaterialYesNoButtonsComponent yesNoButtonsComponent;

  bool pending = false;

  PromptComponent(this._cd);

  void yes() {
    if (yesCallback == null) return;
    var yesReturn = yesCallback();
    if (yesReturn is Future) {
      pending = true;
      _cd.markForCheck();
      yesReturn.then((_) {
        pending = false;
        _cd.markForCheck();
      });
    }
  }

  void no() {
    if (noCallback == null) return;
    var noReturn = noCallback();
    if (noReturn is Future) {
      pending = true;
      _cd.markForCheck();
      noReturn.then((_) {
        pending = false;
        _cd.markForCheck();
      });
    }
  }

  static final String _textYes = "Yes";
  static final String _textNo = "No";
}

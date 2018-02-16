import 'dart:html';
import 'package:angular/core.dart';
import 'package:intl/intl.dart' as intl;

@Directive(selector: "[skawaLangugageDirection]", exportAs: 'skawaLangugageDirection')
class LanguageDirectionDirective {
  final ElementRef _elementRef;

  @HostBinding('style.direction')
  String textDirection = 'ltr';

  @HostBinding('style.text-align')
  String textAlign;

  LanguageDirectionDirective(this._elementRef);

  bool get _elementIsInput => _elementRef.nativeElement is InputElement || _elementRef.nativeElement is TextAreaElement;

  void setLanguageDirection(String value) {
    textDirection = intl.Bidi.estimateDirectionOfText(value).spanText;
    textAlign = _elementIsInput || textDirection == 'ltr' ? null : 'right';
  }
}

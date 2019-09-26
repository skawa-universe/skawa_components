import 'package:js/js_util.dart';

class CodeMirrorConfig {
  final String value;
  final String mode;
  final String lineSeparator;
  final String theme;
  final int indentUnit;

  final bool smartIndent;
  final int tabSize;
  final bool indentWithTabs;
  final bool electricChars;
  final RegExp specialChars;

  /// function(char) → Element
  final Function specialCharPlaceholder;

  ///  "ltr" | "rtl"
  final String direction;

  final bool rtlMoveVisually;

  /// "emacs" | "sublime" | "vim"
  final String keyMap;

  final bool lineWrapping;

  final bool lineNumbers;
  final int firstLineNumber;

  /// function(line: integer) → string
  final Function lineNumberFormatter;

  final List<String> gutters;
  final bool fixedGutter;
  final String scrollbarStyle;
  final bool coverGutterNextToScrollbar;
  final String inputStyle;
  final bool readOnly;
  final bool showCursorWhenSelecting;
  final bool lineWiseCopyCut;
  final bool pasteLinesPerSelection;
  final int undoDepth;

  final int historyEventDelay;

  final int tabindex;
  final bool autofocus;
  final bool dragDrop;
  final List<String> allowDropFileTypes;
  final int cursorBlinkRate;
  final int cursorScrollMargin;
  final int cursorHeight;

  final bool resetSelectionOnContextMenu;

  final int workTime;

  final int workDelay;

  final int pollInterval;
  final bool flattenSpans;
  final bool addModeClass;
  final int maxHighlightLength;

  final int viewportMargin;
  final Map<String, Function> extraKeys;
  final bool styleActiveLine;
  final bool lint;

  CodeMirrorConfig(
      {this.mode,
      this.value,
      this.lineSeparator,
      this.theme,
      this.indentUnit: 2,
      this.smartIndent = true,
      this.tabSize = 4,
      this.indentWithTabs = false,
      this.electricChars = true,
      this.specialChars,
      this.specialCharPlaceholder,
      this.direction,
      this.rtlMoveVisually,
      this.keyMap,
      this.lineWrapping = false,
      this.lineNumbers = true,
      this.firstLineNumber = 1,
      this.lineNumberFormatter,
      this.gutters,
      this.fixedGutter,
      this.scrollbarStyle,
      this.coverGutterNextToScrollbar,
      this.inputStyle,
      this.readOnly,
      this.showCursorWhenSelecting = false,
      this.lineWiseCopyCut,
      this.pasteLinesPerSelection,
      this.undoDepth = 200,
      this.historyEventDelay = 1250,
      this.tabindex,
      this.autofocus,
      this.dragDrop,
      this.allowDropFileTypes,
      this.cursorBlinkRate,
      this.cursorScrollMargin = 0,
      this.cursorHeight = 1,
      this.resetSelectionOnContextMenu = true,
      this.workTime = 200,
      this.workDelay = 300,
      this.pollInterval = 100,
      this.flattenSpans,
      this.addModeClass,
      this.maxHighlightLength = 10000,
      this.viewportMargin = 10,
      this.extraKeys,
      this.styleActiveLine = true,
      this.lint = true});

  dynamic get toJsConfig {
    Map map = {
      'mode': mode,
      'value': value,
      'lineSeparator': lineSeparator,
      'lint': lint,
      'styleActiveLine': styleActiveLine,
      'extraKeys': extraKeys,
      'theme': theme,
      'indentUnit': indentUnit,
      'smartIndent': smartIndent,
      'tabSize': tabSize,
      'indentWithTabs': indentWithTabs,
      'electricChars': electricChars,
      'specialChars': specialChars,
      'specialCharPlaceholder': specialCharPlaceholder,
      'direction': direction,
      'rtlMoveVisually': rtlMoveVisually,
      'keyMap': keyMap,
      'lineWrapping': lineWrapping,
      'lineNumbers': lineNumbers,
      'firstLineNumber': firstLineNumber,
      'lineNumberFormatter': lineNumberFormatter,
      'gutters': gutters,
      'fixedGutter': fixedGutter,
      'scrollbarStyle': scrollbarStyle,
      'coverGutterNextToScrollbar': coverGutterNextToScrollbar,
      'inputStyle': inputStyle,
      'readOnly': readOnly,
      'showCursorWhenSelecting': showCursorWhenSelecting,
      'lineWiseCopyCut': lineWiseCopyCut,
      'pasteLinesPerSelection': pasteLinesPerSelection,
      'undoDepth': undoDepth,
      'historyEventDelay': historyEventDelay,
      'tabindex': tabindex,
      'autofocus': autofocus,
      'dragDrop': dragDrop,
      'allowDropFileTypes': allowDropFileTypes,
      'cursorBlinkRate': cursorBlinkRate,
      'cursorScrollMargin': cursorScrollMargin,
      'cursorHeight': cursorHeight,
      'resetSelectionOnContextMenu': resetSelectionOnContextMenu,
      'workTime': workTime,
      'workDelay': workDelay,
      'pollInterval': pollInterval,
      'flattenSpans': flattenSpans,
      'addModeClass': addModeClass,
      'maxHighlightLength': maxHighlightLength,
      'viewportMargin': viewportMargin
    };
    Map nulledMap = {};
    map.forEach((key, value) {
      if (value != null) nulledMap[key] = value;
    });
    return jsify(nulledMap);
  }
}

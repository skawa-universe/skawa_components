import 'code_mirror_mode.dart';

class CodeMirrorModeWithLink extends CodeMirrorMode {
  final String hint;
  final String lint;
  final String linterScript;
  final String linterJsScript;
  final List<CodeMirrorModeWithLink> additionalModes;

  const CodeMirrorModeWithLink(
      {String mode,
      String modeName,
      String linter,
      String theme = 'eclipse',
      this.hint,
      this.lint,
      this.linterScript,
      this.linterJsScript,
      this.additionalModes})
      : super(mode: mode, modeName: modeName, linter: linter, theme: theme);

  List<String> get scriptList => [
        if (mode != null) _modeCdnLink.replaceAll(_replaceString, mode),
        if (hint != null) _hintCdnLink.replaceAll(_replaceString, hint),
        if (additionalModes != null)
          ...additionalModes.fold<List<String>>([], (list, mode) => list..addAll(mode.scriptList))
      ];

  List<String> get linterScriptList => [
        if (linterJsScript != null || lint != null) linterJsScript ?? _lintCdnLink.replaceAll(_replaceString, lint),
        if (linterScript != null) linterScript,
        if (additionalModes != null)
          ...additionalModes.fold<List<String>>([], (list, mode) => list..addAll(mode.linterScriptList))
      ];

  static const String _replaceString = 'REPLACE';
  static const String _hintCdnLink =
      'https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/addon/hint/$_replaceString-hint.js';
  static const String _lintCdnLink =
      'https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/addon/lint/$_replaceString-lint.js';
  static const String _modeCdnLink =
      'https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/mode/$_replaceString/$_replaceString.js';
  static const String cssLint = 'https://unpkg.com/csslint@1.0.5/dist/csslint.js';

  static const String jsLint = 'https://codemirror.net/addon/lint/javascript-lint.js';

  static const CodeMirrorModeWithLink javascript = const CodeMirrorModeWithLink(
      mode: 'javascript',
      hint: 'javascript',
      lint: 'javascript',
      linterScript: 'https://cdnjs.cloudflare.com/ajax/libs/jshint/2.9.5/jshint.min.js',
      linterJsScript: jsLint,
      linter: 'javascript');
  static const CodeMirrorModeWithLink css =
      const CodeMirrorModeWithLink(mode: 'css', hint: 'css', lint: 'css', linterScript: cssLint, linter: 'css');
  static const CodeMirrorModeWithLink html = const CodeMirrorModeWithLink(
      mode: 'htmlmixed',
      hint: 'html',
      lint: 'html',
      linterScript: 'https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/addon/hint/html-hint.js',
      linter: 'html',
      additionalModes: const [javascript, css, xml, _json]);
  static const CodeMirrorModeWithLink xml = const CodeMirrorModeWithLink(mode: 'xml', hint: 'xml');
  static const CodeMirrorModeWithLink json = const CodeMirrorModeWithLink(
      mode: 'javascript',
      modeName: 'application/json',
      hint: 'javascript',
      lint: 'javascript',
      linterScript: 'https://cdnjs.cloudflare.com/ajax/libs/jshint/2.9.5/jshint.min.js',
      linterJsScript: 'https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/addon/lint/javascript-lint.js',
      linter: 'json',
      additionalModes: const [_json]);
  static const CodeMirrorModeWithLink _json = const CodeMirrorModeWithLink(
      lint: 'json', linterScript: 'https://cdnjs.cloudflare.com/ajax/libs/jsonlint/1.6.0/jsonlint.js');
}

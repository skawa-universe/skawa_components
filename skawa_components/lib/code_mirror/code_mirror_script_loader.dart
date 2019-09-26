import 'dart:async';
import 'package:skawa_components/code_mirror/base_loader.dart';

import 'code_mirror_mode_with_link.dart';

class CodeMirrorScriptLoader {
  final BaseLoader _baseLoader = BaseLoader();

  Future load(CodeMirrorModeWithLink mode) async {
    await _baseLoader.loadList([ScriptLoader(_codeMirrorCdnLink), LinkLoader(_codeMirrorCssCdnLink)]);
    await _baseLoader.loadList([
      ...<String>[...mode.linterScriptList].map((String script) => ScriptLoader(script)),
      ScriptLoader(_showHintJsCdnLink),
      ScriptLoader(_lintJsCdnLink),
      ...<String>[...mode.scriptList].map((String script) => ScriptLoader(script)),
      LinkLoader(_themeCdnLink.replaceAll(_replaceString, mode.theme)),
      LinkLoader(_lintCssCdnLink),
      LinkLoader(_showHintCssCdnLink)
    ]);
  }

  static const String _codeMirrorCdnLink = 'https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/codemirror.js';
  static const String _codeMirrorCssCdnLink = 'https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/codemirror.css';
  static const String _themeCdnLink =
      'https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/theme/$_replaceString.css';
  static const String _showHintJsCdnLink =
      'https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/hint/show-hint.js';
  static const String _showHintCssCdnLink =
      'https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/hint/show-hint.css';
  static const String _lintJsCdnLink = 'https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/lint/lint.js';
  static const String _lintCssCdnLink = 'https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/lint/lint.css';
  static const String _replaceString = 'REPLACE';
}

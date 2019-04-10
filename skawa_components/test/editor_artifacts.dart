import 'dart:html';
import 'package:mockito/mockito.dart';
import 'package:skawa_components/markdown_editor/editor_render_target.dart';

class MockRenderer extends Mock implements EditorRenderer {
  MockRenderer() {
    print('created');
    when(this.render('')).thenAnswer((Invocation inv) {
      var str = inv.positionalArguments[0];
      return DocumentFragment.html('$str');
    });
  }
}

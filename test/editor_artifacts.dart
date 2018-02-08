import 'dart:html';
import 'package:mockito/mockito.dart';
import 'package:skawa_components/src/components/markdown_editor/editor_render_target.dart';

class MockRenderer extends Mock implements EditorRenderer {
  MockRenderer() {
    when(this.render(any)).thenAnswer((Invocation inv) {
      var str = inv.positionalArguments[0];
      return new DocumentFragment.html('$str');
    });
  }
}

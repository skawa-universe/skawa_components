@Tags(const ['aot'])
@TestOn('browser')
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:skawa_components/src/components/ckeditor/ckeditor.dart';
import 'package:test/test.dart';
import 'dart:convert' show HTML_ESCAPE;
import 'package:html_unescape/html_unescape.dart';

@AngularEntrypoint()
main() {
  tearDown(disposeAnyRunningTest);
  test('CKEditor', () async {
    var bed = new NgTestBed<TestEditorComponent>();
    var fixture = await bed.create();
    await fixture.update();
    await fixture.query<SkawaCkeditorComponent>((element) {
      return element.componentInstance is SkawaCkeditorComponent;
    }, (SkawaCkeditorComponent editor) {
      expect(editor.editorName, "editor");
      expect(editor.extraPlugins, allOf(isList, hasLength(1)));
      expect(editor.extraPlugins.first, predicate((ExtraPlugin plugin) {
        return plugin.path == '/plugin' && plugin.name == 'some-plugin' && plugin.entrypoint == 'plugin.js';
      }));
      expect(editor.configUrl, '/some-url');
      expect(new HtmlUnescape().convert(editor.value), TestEditorComponent._TEST_MARKUP);
    });
  });
}

@Component(
  selector: 'dummy-cke',
  directives: const [SkawaCkeditorComponent],
  template: '''
  <skawa-ckeditor editorName="editor" [extraPlugins]="plugins" configUrl="/some-url" [content]="escaped">
  </skawa-ckeditor>
  ''',
)
class TestEditorComponent {
  var plugins = [new ExtraPlugin('some-plugin', '/plugin', 'plugin.js')];

  String get escaped => HTML_ESCAPE.convert(_TEST_MARKUP);
  static const String _TEST_MARKUP = 'Some <br /> content <p>comes here.</p>';
}

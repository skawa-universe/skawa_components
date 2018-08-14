@TestOn('browser')
import 'dart:convert' show htmlEscape;
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:skawa_components/ckeditor/ckeditor.dart';
import 'package:test/test.dart';
import 'package:html_unescape/html_unescape.dart';

import 'ckeditor_test.template.dart' as ng;

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);
  test('CKEditor', () async {
    var bed = new NgTestBed<TestEditorComponent>();
    var fixture = await bed.create();
    await fixture.update();
    expect(fixture.assertOnlyInstance.editor.editorName, "editor");
    expect(fixture.assertOnlyInstance.editor.extraPlugins, allOf(isList, hasLength(1)));
    expect(fixture.assertOnlyInstance.editor.extraPlugins.first, predicate((ExtraPlugin plugin) {
      return plugin.path == '/plugin' && plugin.name == 'some-plugin' && plugin.entrypoint == 'plugin.js';
    }));
    expect(fixture.assertOnlyInstance.editor.configUrl, '/some-url');
    expect(new HtmlUnescape().convert(fixture.assertOnlyInstance.editor.value), TestEditorComponent._TEST_MARKUP);
  });
}

@Component(selector: 'dummy-cke', template: '''
  <skawa-ckeditor editorName="editor" [extraPlugins]="plugins" configUrl="/some-url" [content]="escaped">
  </skawa-ckeditor>
  ''', directives: const [SkawaCkeditorComponent])
class TestEditorComponent {
  List<ExtraPlugin> plugins = [new ExtraPlugin('some-plugin', '/plugin', 'plugin.js')];

  @ViewChild(SkawaCkeditorComponent)
  SkawaCkeditorComponent editor;

  String get escaped => htmlEscape.convert(_TEST_MARKUP);

  static const String _TEST_MARKUP = 'Some <br /> content <p>comes here.</p>';
}

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
    var bed = NgTestBed<TestEditorComponent>();
    var fixture = await bed.create();
    await fixture.update();
    expect(fixture.assertOnlyInstance.editor.editorName, "editor");
    expect(fixture.assertOnlyInstance.editor.extraPlugins, allOf(isList, hasLength(1)));
    expect(fixture.assertOnlyInstance.editor.extraPlugins.first, predicate((ExtraPlugin plugin) {
      return plugin.path == '/ckeditor/dartlogo/plugin.js' && plugin.name == 'dartlogo' && plugin.entrypoint == '';
    }));
    expect(fixture.assertOnlyInstance.editor.configUrl, '/dartlogo/config.js');
    expect(HtmlUnescape().convert(fixture.assertOnlyInstance.editor.value), TestEditorComponent._TEST_MARKUP);
  });
  test('CKEditorConfig', () async {
    var bed = NgTestBed<ConfigEditorComponent>();
    var fixture = await bed.create();
    await fixture.update();
    expect(fixture.assertOnlyInstance.editor.config['language'], 'en');
  });
}

@Component(selector: 'dummy-cke', template: '''
  <skawa-ckeditor editorName="editor" 
                  [extraPlugins]="plugins" 
                  configUrl="/dartlogo/config.js" 
                  [content]="escaped">
  </skawa-ckeditor>
  ''', directives: [SkawaCkeditorComponent])
class TestEditorComponent {
  List<ExtraPlugin> plugins = [ExtraPlugin('dartlogo', '/ckeditor/dartlogo/plugin.js', '')];

  @ViewChild(SkawaCkeditorComponent)
  SkawaCkeditorComponent editor;

  String get escaped => htmlEscape.convert(_TEST_MARKUP);

  static const String _TEST_MARKUP = 'Some <br /> content <p>comes here.</p>';
}

@Component(selector: 'config-cke', template: '''
  <skawa-ckeditor editorName="editor" 
                  [config]="config">
  </skawa-ckeditor>
  ''', directives: [SkawaCkeditorComponent])
class ConfigEditorComponent {
  Map<String, dynamic> config = {'language': 'en'};

  @ViewChild(SkawaCkeditorComponent)
  SkawaCkeditorComponent editor;
}

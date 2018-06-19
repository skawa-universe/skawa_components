//@Tags(const ['aot'])
//@TestOn('browser')
//import 'dart:convert' show htmlEscape;
//import 'package:angular/angular.dart';
//import 'package:angular_test/angular_test.dart';
//import 'package:skawa_components/ckeditor/ckeditor.dart';
//import 'package:test/test.dart';
//import 'package:html_unescape/html_unescape.dart';
//
//void main() {
//  tearDown(disposeAnyRunningTest);
//  test('CKEditor', () async {
//    var bed = new NgTestBed<TestEditorComponent>();
//    var fixture = await bed.create();
//    await fixture.update();
//    await fixture.query<SkawaCkeditorComponent>((element) {
//      return element.componentInstance is SkawaCkeditorComponent;
//    }, (SkawaCkeditorComponent editor) {
//      expect(editor.editorName, "editor");
//      expect(editor.extraPlugins, allOf(isList, hasLength(1)));
//      expect(editor.extraPlugins.first, predicate((ExtraPlugin plugin) {
//        return plugin.path == '/plugin' && plugin.name == 'some-plugin' && plugin.entrypoint == 'plugin.js';
//      }));
//      expect(editor.configUrl, '/some-url');
//      expect(new HtmlUnescape().convert(editor.value), TestEditorComponent._TEST_MARKUP);
//    });
//  });
//}
//
//@Component(selector: 'dummy-cke', template: '''
//  <skawa-ckeditor editorName="editor" [extraPlugins]="plugins" configUrl="/some-url" [content]="escaped">
//  </skawa-ckeditor>
//  ''', directives: const [SkawaCkeditorComponent])
//class TestEditorComponent {
//  List<ExtraPlugin> plugins = [new ExtraPlugin('some-plugin', '/plugin', 'plugin.js')];
//
//  String get escaped => htmlEscape.convert(_TEST_MARKUP);
//  static const String _TEST_MARKUP = 'Some <br /> content <p>comes here.</p>';
//}

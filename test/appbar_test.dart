// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:pageloader/webdriver.dart';
import 'package:skawa_components/src/components/appbar/appbar.dart';
import 'package:test/test.dart';
import 'package:pageloader/objects.dart';

@AngularEntrypoint()
Future main() async {
  tearDown(disposeAnyRunningTest);
  group('Appbar | ', () {
    test('initialization without button', () async {
      final fixture = await new NgTestBed<AppbarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject /*<TestPO>*/(TestPO);
      expect(await pageObject.trigger.innerText, '0');
    });
    test('initialization with button', () async {
      final fixture = await new NgTestBed<AppbarTestComponent>().create();
      final pageObject = await fixture.resolvePageObject /*<TestPO>*/(TestPO);
      await fixture.update((testElement) {
        testElement.showNavToggle = true;
      });
      expect(await pageObject.trigger.innerText, '0');
      expect(await pageObject.appbar, isNotNull);
    });
    test('initialization with button and trigger 2X', () async {
      final fixture = await new NgTestBed<AppbarTestComponent>().create(beforeChangeDetection: (testElement) {
        testElement.showNavToggle = true;
      });
      final pageObject = await fixture.resolvePageObject /*<TestPO>*/(TestPO);
//      await fixture.update((testElement) {
//        testElement.showNavToggle = true;
//      });
      await pageObject.appbar.materialButton.click();
      await pageObject.appbar.materialButton.click();
      expect(await pageObject.trigger.innerText, '2');
      expect(await pageObject.appbar, isNotNull);
    });
  });
}

@Component(
  selector: 'test',
  template: '''
    <skawa-appbar [showNavToggle]="showNavToggle"  (navToggle)="increment()"></skawa-appbar>
    <div increment>{{triggered}}</div>
     ''',
  directives: const [
    SkawaAppbarComponent,
  ],
)
class AppbarTestComponent {
  bool showNavToggle = false;

  int triggered = 0;

  void increment() {
    triggered = triggered + 1;
  }
}

@EnsureTag('test')
class TestPO {
  @ByTagName('[increment]')
  PageLoaderElement trigger;

  @ByTagName('skawa-appbar')
  AppbarPO appbar;
}

class AppbarPO {
  @root
  PageLoaderElement rootElement;

  @optional
  @ByTagName('material-button')
  PageLoaderElement materialButton;
}
import 'dart:html';

@TestOn('browser')
//import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/utils.dart';
import 'package:skawa_material_components/skawa_banner/skawa_banner.dart';
import 'package:test/test.dart';

import 'skawa_banner_host/skawa_banner_host.dart';
import 'skawa_banner_host/skawa_banner_host.template.dart' as ng;
import 'skawa_banner_host/skawa_banner_host_po.dart';
import 'skawa_banner_test.template.dart' as self;

@GenerateInjector([ClassProvider(SkawaBannerService)])
final InjectorFactory rootInjector = self.rootInjector$Injector;

void main() {
  SkawaBannerHostPO bannerHostPO;
  tearDown(disposeAnyRunningTest);

  group('Banner', () {
    final defaultTestBed = NgTestBed.forComponent<SkawaBannerHostComponent>(ng.SkawaBannerHostComponentNgFactory,
        rootInjector: rootInjector);
    NgTestFixture<SkawaBannerHostComponent> fixture;

    setUp(() async {
      fixture = await defaultTestBed.create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      bannerHostPO = SkawaBannerHostPO.create(context);
    });

    test('displays message and icon', () async {
      expect(bannerHostPO.header.visibleText, contains("header"));
      expect(bannerHostPO.content.visibleText, contains("doge"));
      expect(bannerHostPO.banner.section, notExists);
      await bannerHostPO.showWarning();
      await fixture.update((SkawaBannerHostComponent host) async => await host.warningMessage.dispatchEvent.future);
      expect(bannerHostPO.banner.section, exists);
      expect(bannerHostPO.banner.message, equals("This is a warning"));
      expect(bannerHostPO.banner.iconName, equals("warning"));
      expect(bannerHostPO.banner.iconClass, equals("color-warning"));
    });

    test('low priority message gets queued', () async {
      // Send a normal priority message
      await bannerHostPO.showError();
      await fixture.update((SkawaBannerHostComponent host) async => await host.errorMessage.dispatchEvent.future);
      expect(bannerHostPO.banner.section, exists);
      expect(bannerHostPO.banner.message, equals("This is an error"));
      expect(bannerHostPO.banner.iconName, equals("error"));
      expect(bannerHostPO.banner.iconClass, equals("color-error"));

      // Send a low priority message which should not disrupt the current message
      await fixture.update();
      await bannerHostPO.showInfo();
      await fixture.update();
      expect(bannerHostPO.banner.section, exists);
      expect(bannerHostPO.banner.message, equals("This is an error"));
      expect(bannerHostPO.banner.iconName, equals("error"));
      expect(bannerHostPO.banner.iconClass, equals("color-error"));

      // Dismiss the first message, and expect the second message to be dispatched
      await bannerHostPO.banner.trigger(0);
      await fixture.update((SkawaBannerHostComponent host) async => await host.errorMessage.dismissEvent.future);
      await fixture.update();
      await fixture.update((SkawaBannerHostComponent host) async {
        await host.infoMessage.dispatchEvent.future;
        expect(bannerHostPO.banner.message, equals("This is an info"));
        expect(bannerHostPO.banner.iconName, equals("info"));
        expect(bannerHostPO.banner.iconClass, equals("color-info"));
      });
    });

    test('beforeDispatch callback can be used to discard obsolete messages', () async {
      // Send a normal priority message
      await bannerHostPO.showError();
      await fixture.update((SkawaBannerHostComponent host) async => await host.errorMessage.dispatchEvent.future);
      await fixture.update();
      expect(bannerHostPO.banner.section, exists);
      expect(bannerHostPO.banner.message, equals("This is an error"));
      expect(bannerHostPO.banner.iconName, equals("error"));
      expect(bannerHostPO.banner.iconClass, equals("color-error"));

      // Send a low priority message which should not disrupt the current message
      await fixture.update();
      await bannerHostPO.showInfoWithoutPriority();
      expect(bannerHostPO.banner.section, exists);
      expect(bannerHostPO.banner.message, equals("This is an error"));
      expect(bannerHostPO.banner.iconName, equals("error"));
      expect(bannerHostPO.banner.iconClass, equals("color-error"));

      // Dismiss the first message, and expect the second message to be discarded due to it's beforeDispatch callback
      // returning false
      await bannerHostPO.banner.trigger(0);
      await fixture.update();
      await fixture.update((SkawaBannerHostComponent host) async {
        await host.errorMessage.dismissEvent.future;
        expect(bannerHostPO.banner.section, notExists);
      });
    });
  });

  group('Layout (html)', () {
    final defaultTestBed = NgTestBed.forComponent<SkawaBannerHostComponent>(ng.SkawaBannerHostComponentNgFactory,
        rootInjector: rootInjector);
    NgTestFixture<SkawaBannerHostComponent> fixture;

    setUp(() async {
      fixture = await defaultTestBed.create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      bannerHostPO = SkawaBannerHostPO.create(context);
    });

    test('banner is sticky', () async {
      const int scrollY = 200;
      await bannerHostPO.showWarning();
      await fixture.update((SkawaBannerHostComponent host) async => await host.warningMessage.dispatchEvent.future);
      await fixture.update();
      num hostInitialPosition = bannerHostPO.rootElement.getBoundingClientRect().top;
      window.scrollTo(0, scrollY);
      expect(bannerHostPO.rootElement.getBoundingClientRect().top, equals(hostInitialPosition - scrollY));
      expect(bannerHostPO.banner.section.getBoundingClientRect().top, equals(0));
    });
  });
}

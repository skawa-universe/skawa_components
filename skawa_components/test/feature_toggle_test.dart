@TestOn('browser')
import 'package:angular_test/angular_test.dart';
import 'package:angular/angular.dart';
import 'package:angular/src/di/injector/hierarchical.dart';
import 'package:mockito/mockito.dart';
import 'package:skawa_components/feature_toggle/feature_toggle.dart';
import 'package:test/test.dart';

import 'feature_toggle_test.template.dart' as self;

void main() {
  setUpAll(() {
    self.initReflector();
  });
  group('FeatureToggleBase', () {
    final mockViewContainerRef = MockViewContainerRef();
    setUp(() {
      reset(mockViewContainerRef);
      when(mockViewContainerRef.createEmbeddedView(any)).thenReturn(null);
      when(mockViewContainerRef.clear()).thenReturn(Null);
    });
    test('toggleDisplay should invoked shouldDisplay', () {
      final inst = enabledToggleBase;
      inst.toggleDisplay('SomeFeature', null, mockViewContainerRef);
      expect(inst.lastCheckedFeature, 'SomeFeature');
    });
    test('toggleDisplay should short circuit of feature name and state matches', () {
      final inst = disabledToggleBase;
      inst.toggleDisplay('SomeFeature', null, mockViewContainerRef);
      verify(mockViewContainerRef.clear());
      expect(() => inst.toggleDisplay('SomeFeature', null, mockViewContainerRef), returnsNormally);
      verifyNoMoreInteractions(mockViewContainerRef);
    });
    test('toggleDisplay should hide when feature changes', () {
      final inst = disabledToggleBase;
      inst.toggleDisplay('SomeFeature', null, mockViewContainerRef);
      expect(() => inst.toggleDisplay('OtherFeature', null, mockViewContainerRef), returnsNormally);
      verify(mockViewContainerRef.clear()).called(2);
      verifyNoMoreInteractions(mockViewContainerRef);
    });
    test('toggleDisplay should toggles when feature display state changes', () {
      final inst = disabledToggleBase;
      inst.toggleDisplay('SomeFeature', null, mockViewContainerRef);
      inst.testShouldDisplay = true;
      expect(() => inst.toggleDisplay('SomeFeature', null, mockViewContainerRef), returnsNormally);
      verify(mockViewContainerRef.clear());
      verify(mockViewContainerRef.createEmbeddedView(any));
      verifyNoMoreInteractions(mockViewContainerRef);
    });
  });
  group('FeatureToggleDirectives', () {
    group('when feature is enabled', () {
      tearDown(() async {
        await disposeAnyRunningTest();
      });
      final rootInjectorCb = ([Injector parent]) {
        return Injector.map({
          FeatureToggleService: enabledTestService,
        }, parent as HierarchicalInjector);
      };
      test('with [featureEnabled] creates embedded view', () async {
        final bed = NgTestBed.forComponent(self.TestEnabledComponentNgFactory, rootInjector: rootInjectorCb);
        final fixture = await bed.create();
        expect(fixture.text, contains('Displayed'));
      });
      test('with [featureDisabled] clears embedded view', () async {
        final bed = NgTestBed.forComponent(self.TestDisabledComponentNgFactory, rootInjector: rootInjectorCb);
        final fixture = await bed.create();
        expect(fixture.text, isEmpty);
      });
    });
    group('when feature is disabled', () {
      tearDown(() async {
        await disposeAnyRunningTest();
      });
      final rootInjectorCb = ([Injector parent]) {
        return Injector.map({
          FeatureToggleService: disabledTestService,
        }, parent as HierarchicalInjector);
      };
      test('with [featureEnabled] clears embedded view', () async {
        final bed = NgTestBed.forComponent(self.TestEnabledComponentNgFactory, rootInjector: rootInjectorCb);
        final fixture = await bed.create();
        expect(fixture.text, isEmpty);
      });
      test('with [featureDisabled] creates embedded view', () async {
        final bed = NgTestBed.forComponent(self.TestDisabledComponentNgFactory, rootInjector: rootInjectorCb);
        final fixture = await bed.create();
        expect(fixture.text, contains('Displayed'));
      });
    });
  });
  group('FeatureToggleStructureDirective', () {
    tearDown(() async {
      await disposeAnyRunningTest();
    });
    test('when feature is enabled, should display and hide appropriately', () async {
      final bed = NgTestBed.forComponent(self.TestStructuralComponentNgFactory, rootInjector: ([Injector parent]) {
        return Injector.map({
          FeatureToggleService: enabledTestService,
        }, parent as HierarchicalInjector);
      });
      final fixture = await bed.create();
      expect(fixture.text, contains('EnabledCheck'));
      expect(fixture.text, isNot(contains('DisabledCheck')));
    });
    test('when feature is disabled, should display and hide appropriately', () async {
      final bed = NgTestBed.forComponent(self.TestStructuralComponentNgFactory, rootInjector: ([Injector parent]) {
        return Injector.map({
          FeatureToggleService: disabledTestService,
        }, parent as HierarchicalInjector);
      });
      final fixture = await bed.create();
      expect(fixture.text, isNot(contains('EnabledCheck')));
      expect(fixture.text, contains('DisabledCheck'));
    });
  });
  group('changing feature name', () {
    const features = {
      'enabledFeature': true,
      'disabledFeature': false,
    };
    tearDown(() async {
      await disposeAnyRunningTest();
    });
    test('changing feature updates UI', () async {
      final mockService = MockToggleService();
      when(mockService.isEnabled(captureAny)).thenAnswer((realInvocation) {
        final featureName = realInvocation.positionalArguments.first as String;
        return features[featureName];
      });
      final bed = NgTestBed.forComponent<TestUpdatableStructuralComponent>(
          self.TestUpdatableStructuralComponentNgFactory, rootInjector: ([Injector parent]) {
        return Injector.map({
          FeatureToggleService: mockService,
        }, parent as HierarchicalInjector);
      });
      final fixture = await bed.create();
      expect(fixture.text, isEmpty);
      await fixture.update((inst) {
        inst.featureName = 'enabledFeature';
      });
      expect(fixture.text, contains('enabledFeature'));
    });
  });
}

@Component(
  selector: 'test-cmp',
  template: '<template featureEnabled="SomeFeature">Displayed</template>',
  directives: [FeatureToggleEnabledDirective],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class TestEnabledComponent {}

@Component(
  selector: 'test-cmp',
  template: '<template featureDisabled="SomeFeature">Displayed</template>',
  directives: [FeatureToggleDisabledDirective],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class TestDisabledComponent {}

@Component(
  selector: 'test-cmp',
  template: '''
  <span *featureEnabled="'SomeFeature'">EnabledCheck</span>
  <span *featureDisabled="'SomeFeature'">DisabledCheck</span>
  ''',
  directives: [FeatureToggleEnabledDirective, FeatureToggleDisabledDirective],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class TestStructuralComponent {}

@Component(
  selector: 'test-cmp',
  template: '''
  <span *featureEnabled="featureName">{{featureName}}</span>
  ''',
  directives: [FeatureToggleEnabledDirective, FeatureToggleDisabledDirective],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class TestUpdatableStructuralComponent {
  final ChangeDetectorRef changeDetectorRef;
  String _featureName = 'disabledFeature';

  TestUpdatableStructuralComponent(this.changeDetectorRef);

  String get featureName => _featureName;

  set featureName(String value) {
    _featureName = value;
    changeDetectorRef.markForCheck();
  }
}

class TestFeatureToggleImpl extends FeatureToggleBase {
  bool testShouldDisplay;
  String lastCheckedFeature;

  TestFeatureToggleImpl(FeatureToggleService toggleService) : super(toggleService);

  @override
  bool shouldDisplay(String featureName) {
    lastCheckedFeature = featureName;
    return testShouldDisplay;
  }
}

TestFeatureToggleImpl get enabledToggleBase => TestFeatureToggleImpl(null)..testShouldDisplay = true;

TestFeatureToggleImpl get disabledToggleBase => TestFeatureToggleImpl(null)..testShouldDisplay = false;

class MockViewContainerRef extends Mock implements ViewContainerRef {}

class MockToggleService extends Mock implements FeatureToggleService {}

FeatureToggleService enabledToggleServiceFactory() => enabledTestService;

FeatureToggleService disabledToggleServiceFactory() => disabledTestService;

/// A service always returns true for `isEnabled`
FeatureToggleService get enabledTestService {
  final mock = MockToggleService();
  when(mock.isEnabled(any)).thenReturn(true);
  return mock;
}

/// A service always returns false for `isEnabled`
FeatureToggleService get disabledTestService {
  final mock = MockToggleService();
  when(mock.isEnabled(any)).thenReturn(false);
  return mock;
}

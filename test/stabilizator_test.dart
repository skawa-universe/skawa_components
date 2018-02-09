@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';
import 'dart:html';
import 'package:pageloader/objects.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:test/test.dart';
import 'package:angular2/core.dart';
import 'package:angular_test/angular_test.dart';

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);
  final testBed = new NgTestBed<RenderSourceTemplateComponent>();
  NgTestFixture<RenderSourceTemplateComponent> fixture;
  TestPO pageObject;
  final String _initialValue = "some initial content";
  group('EditorRenderSource | with initial value ', () {
    setUp(() async {
      fixture = await testBed.create(beforeChangeDetection: (testElement) => testElement.initialValue = _initialValue);
      pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
    });
    test('can\'t revert beyond initial value with revertAllUpdates', () async {
      await pageObject.type(' 1');
      await pageObject.type(' 2');
      await pageObject.type(' 3');
      await pageObject.type(' 4');
      await pageObject.type(' 5');
      await pageObject.type(' 6');
      await pageObject.type(' 7');
      await pageObject.type(' 8');
      await pageObject.type(' 9');
      await pageObject.type(' 10');
      await pageObject.type(' 11');
      await pageObject.type(' 12');
      await pageObject.type(' 13');
      await pageObject.revertAllUpdates();
      await pageObject.revertAllUpdates();
      await fixture.update((testComponent) => expect(testComponent.renderSource.onUpdated, mayEmit(_initialValue)));
    });
  });
}

@Component(
    selector: 'test',
    template: '''
    <textarea editorRenderSource [initialValue]="initialValue"></textarea>
    <button revertLastUpdate (click)="cica('revertLastUpdate'); renderSource.revertLastUpdate()"></button>
    <button revertAllUpdates (click)="cica('revertAllUpdates'); renderSource.revertAllUpdates()"></button>
              ''',
    directives: const [EditorRenderSource],
    changeDetection: ChangeDetectionStrategy.OnPush)
class RenderSourceTemplateComponent {
  String initialValue;

  void cica(String ev) {
    print('cica: $ev');
  }

  @ViewChild(EditorRenderSource)
  EditorRenderSource renderSource;
}

@EnsureTag('test')
class TestPO {
  @ByTagName('textarea')
  PageLoaderElement _editorRenderSource;

  Future clear() async => await _editorRenderSource.clear();

  Future type(String s) async => await _editorRenderSource.type(s);

  Future revertLastUpdate() async => await _revertLastUpdate.click();

  Future revertAllUpdates() async => await _revertAllUpdates.click();

  Future<String> actualValue() async => await _revertLastUpdate.innerText;

  @ByTagName('[revertLastUpdate]')
  PageLoaderElement _revertLastUpdate;

  @ByTagName('[revertAllUpdates]')
  PageLoaderElement _revertAllUpdates;
}

@Directive(
    selector: '[editorRenderSource]',
    exportAs: 'editorRenderSource',
    host: const {'(input)': r'contentChanged($event)'})
class EditorRenderSource implements AfterViewInit, OnDestroy {
  final ElementRef elementRef;
  final StreamController _onUpdatedController = new StreamController.broadcast();
  final List<String> _changeStack = <String>[];

  @Input()
  String initialValue;

  DeferredCallback _emit;

  EditorRenderSource(this.elementRef) {
    _emit = new DeferredCallback(_onUpdatedController.add);
  }

  @Output('update')
  Stream get onUpdated => _onUpdatedController.stream;

  String get value {
    if (initialValue != null && _changeStack.isEmpty) {
      return initialValue;
    } else {
      return elementRef.nativeElement.value;
    }
  }

  /// Sets the value of editor
  set value(String val) {
    _changeStack.insert(0, value);
    elementRef.nativeElement.value = val;
  }

  /// Gets the previous or initial value
  String get previousValue => _changeStack.length > 0 ? _changeStack.first : initialValue;

  void revertLastUpdate() {
    print('revertLastUpdate');
    if (_changeStack.length <= 1) {
      revertAllUpdates();
    } else {
      _changeStack.removeAt(0);
      elementRef.nativeElement.value = _changeStack.first;
    }
    _emit(value);
  }

  void revertAllUpdates() {
    print('revertAllUpdates');
    value = initialValue;
    _changeStack.clear();
    _emit(initialValue);
  }

  void contentChanged(Event ev) {
    print('contentChanged : $ev');
    if (_changeStack.isEmpty || _changeStack.first != value) {
      _changeStack.insert(0, value);
    }
    _emit(value);
    ev.stopPropagation();
  }

  @override
  void ngAfterViewInit() {
    print('ngAfterViewInit');
    // sync initial value to DOM
    _emit(initialValue);
    if (initialValue != null) elementRef.nativeElement.value = initialValue;
  }

  @override
  void ngOnDestroy() {
    _onUpdatedController.close();
  }
}

/// Responsible for debounced execution of a callback at most once in every
/// pre-defined interval
///
/// __Usage__:
///
///     var cb = new DeferredCallback(someAction, new Duration(seconds: 1));
///     cb(paramToPassToSomeAction);
///
class DeferredCallback<T, K> {
  final Duration timeout;

  Function _cb;

  Timer _timer;

  T previuslyEmitted;

  /// [callback] is the action that will be executed once every
  /// [timeout] duration
  DeferredCallback(K callback(T param), [Duration timeout])
      : timeout = timeout ?? defaultTimeout,
        _cb = callback;

  Future<K> call(T param) {
    print('call: $param');
    if (_timer != null) {
      _timer.cancel();
      print('cancel timer ${_timer.isActive}');
    }
    var c = new Completer<K>();
    _timer = new Timer(timeout, () {
      print('time run out');
      try {
        if (param == previuslyEmitted) {
          return;
        } else {
          previuslyEmitted = param;
          c.complete(_cb(param));
          print('after complete: $previuslyEmitted');
        }
      } catch (e) {
        c.completeError(e);
      }
    });
    return c.future;
  }

  static final Duration defaultTimeout = new Duration(milliseconds: 500);
}

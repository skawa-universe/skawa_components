import 'dart:async';

import 'package:angular/core.dart';
import 'package:angular_components/model/ui/has_factory.dart';
import 'package:angular_components/model/ui/has_renderer.dart';

import 'sort.dart';
export 'sort.dart';

typedef String DataTableAccessor<T>(T rowData);

class SkawaDataTableColumn<T> {
  final StreamController<T> _triggerController = StreamController<T>.broadcast();

  DataTableAccessor<T> accessor;

  DataTableAccessor<T> titleAccessor;

  String header;

  String footer;

  SortModel sortModel;

  bool skipFooter = true;

  String classString;

  @Output('trigger')
  Stream<T> get onTrigger => _triggerController.stream;

  bool get useAccessorAsLink => _triggerController.hasListener;

  bool get useColumnRenderer => false;

  void trigger(T row) {
    _triggerController.add(row);
  }

  Iterable<String> getClasses([String suffix]) =>
      classString?.trim()?.split(' ')?.map((className) => suffix != null ? '$className$suffix' : className);

  void cleanup() {
    _triggerController.close();
  }
}

typedef K RenderValueProducer<K, T>(T row);

class SkawaDataTableRenderColumn<T, K> extends SkawaDataTableColumn<T> implements HasFactoryRenderer<RendersValue, K> {
  @override
  FactoryRenderer<RendersValue, K> factoryRenderer;

  RenderValueProducer<K, T> valueProducer;

  bool get useColumnRenderer => true;
}

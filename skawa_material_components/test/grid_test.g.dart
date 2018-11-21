//// GENERATED CODE - DO NOT MODIFY BY HAND
//
//part of 'grid_test.dart';
//
//// **************************************************************************
//// PageObjectGenerator
//// **************************************************************************
//
//// ignore_for_file: private_collision_in_mixin_application
//// ignore_for_file: unused_field, non_constant_identifier_names
//// ignore_for_file: overridden_fields, annotate_overrides
//class $TestPO extends TestPO with $$TestPO {
//  PageLoaderElement $__root__;
//  $TestPO.create(PageLoaderElement currentContext)
//      : $__root__ = currentContext {
//    $__root__.addCheckers([CheckTag('test')]);
//  }
//  factory $TestPO.lookup(PageLoaderSource source) =>
//      $TestPO.create(source.byTag('test'));
//  static String get tagName => 'test';
//}
//
//class $$TestPO {
//  PageLoaderElement $__root__;
//  PageLoaderMouse __mouse__; // ignore: unused_field
//  PageLoaderElement get $root => $__root__;
//  GridPO get grid {
//    for (final __listener in $__root__.listeners) {
//      __listener.startPageObjectMethod('TestPO', 'grid');
//    }
//    final element = $__root__.createElement(ByTagName('skawa-grid'), [], []);
//    final returnMe = GridPO.create(element);
//    for (final __listener in $__root__.listeners) {
//      __listener.endPageObjectMethod('TestPO', 'grid');
//    }
//    return returnMe;
//  }
//}
//
//class $GridPO extends GridPO with $$GridPO {
//  PageLoaderElement $__root__;
//  $GridPO.create(PageLoaderElement currentContext)
//      : $__root__ = currentContext {
//    $__root__.addCheckers([]);
//  }
//  factory $GridPO.lookup(PageLoaderSource source) =>
//      throw "'lookup' constructor for class "
//      "GridPO is not generated and can only be used on Page Object "
//      "classes that have @CheckTag annotation.";
//  static String get tagName =>
//      throw '"tagName" is not defined by Page Object "GridPO". Requires @CheckTag annotation in order for "tagName" to be generated.';
//}
//
//class $$GridPO {
//  PageLoaderElement $__root__;
//  PageLoaderMouse __mouse__; // ignore: unused_field
//  PageLoaderElement get $root => $__root__;
//  PageLoaderElement get rootElement {
//    for (final __listener in $__root__.listeners) {
//      __listener.startPageObjectMethod('GridPO', 'rootElement');
//    }
//    final element = $__root__;
//    final returnMe = element;
//    for (final __listener in $__root__.listeners) {
//      __listener.endPageObjectMethod('GridPO', 'rootElement');
//    }
//    return returnMe;
//  }
//
//  PageObjectList<PageLoaderElement> get tiles {
//    for (final __listener in $__root__.listeners) {
//      __listener.startPageObjectMethod('GridPO', 'tiles');
//    }
//    final returnMe = PageObjectList<PageLoaderElement>(
//        $__root__.createList(ByCss('[gridTile]'), [], []),
//        (PageLoaderElement e) => e);
//    for (final __listener in $__root__.listeners) {
//      __listener.endPageObjectMethod('GridPO', 'tiles');
//    }
//    return returnMe;
//  }
//}

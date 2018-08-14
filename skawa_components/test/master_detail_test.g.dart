// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_detail_test.dart';

// **************************************************************************
// PageObjectGenerator
// **************************************************************************

// ignore_for_file: private_collision_in_mixin_application
// ignore_for_file: unused_field, non_constant_identifier_names
// ignore_for_file: overridden_fields, annotate_overrides
class $TestPO extends TestPO with $$TestPO {
  PageLoaderElement $__root__;
  $TestPO.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([CheckTag('test')]);
  }
  factory $TestPO.lookup(PageLoaderSource source) =>
      $TestPO.create(source.byTag('test'));
  static String get tagName => 'test';
}

class $$TestPO {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__; // ignore: unused_field
  PageLoaderElement get $root => $__root__;
  PageLoaderElement get expand {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('TestPO', 'expand');
    }
    final element = $__root__.createElement(ByCss('[expand-button]'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('TestPO', 'expand');
    }
    return returnMe;
  }

  PageLoaderElement get collapse {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('TestPO', 'collapse');
    }
    final element = $__root__.createElement(ByCss('[collapse-button]'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('TestPO', 'collapse');
    }
    return returnMe;
  }

  PageLoaderElement get toggle {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('TestPO', 'toggle');
    }
    final element = $__root__.createElement(ByCss('[toggle-button]'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('TestPO', 'toggle');
    }
    return returnMe;
  }

  MasterDetailPage get sideMasterDetail {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('TestPO', 'sideMasterDetail');
    }
    final element =
        $__root__.createElement(ByTagName('skawa-master-detail'), [], []);
    final returnMe = MasterDetailPage.create(element);
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('TestPO', 'sideMasterDetail');
    }
    return returnMe;
  }
}

class $MasterDetailPage extends MasterDetailPage with $$MasterDetailPage {
  PageLoaderElement $__root__;
  $MasterDetailPage.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([]);
  }
  factory $MasterDetailPage.lookup(PageLoaderSource source) =>
      throw "'lookup' constructor for class "
      "MasterDetailPage is not generated and can only be used on Page Object "
      "classes that have @CheckTag annotation.";
  static String get tagName =>
      throw '"tagName" is not defined by Page Object "MasterDetailPage". Requires @CheckTag annotation in order for "tagName" to be generated.';
}

class $$MasterDetailPage {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__; // ignore: unused_field
  PageLoaderElement get $root => $__root__;
  PageLoaderElement get rootElement {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('MasterDetailPage', 'rootElement');
    }
    final element = $__root__;
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('MasterDetailPage', 'rootElement');
    }
    return returnMe;
  }
}

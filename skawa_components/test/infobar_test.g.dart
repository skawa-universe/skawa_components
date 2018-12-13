// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infobar_test.dart';

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
  InforbarPO get infobar {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('TestPO', 'infobar');
    }
    final element = $__root__.createElement(ByTagName('skawa-infobar'), [], []);
    final returnMe = InforbarPO.create(element);
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('TestPO', 'infobar');
    }
    return returnMe;
  }

  PageLoaderElement get trigger {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('TestPO', 'trigger');
    }
    final element = $__root__.createElement(ByTagName('[increment]'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('TestPO', 'trigger');
    }
    return returnMe;
  }
}

class $InforbarPO extends InforbarPO with $$InforbarPO {
  PageLoaderElement $__root__;
  $InforbarPO.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([]);
  }
  factory $InforbarPO.lookup(PageLoaderSource source) =>
      throw "'lookup' constructor for class "
      "InforbarPO is not generated and can only be used on Page Object "
      "classes that have @CheckTag annotation.";
  static String get tagName =>
      throw '"tagName" is not defined by Page Object "InforbarPO". Requires @CheckTag annotation in order for "tagName" to be generated.';
}

class $$InforbarPO {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__; // ignore: unused_field
  PageLoaderElement get $root => $__root__;
  PageLoaderElement get materialButton {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('InforbarPO', 'materialButton');
    }
    final element =
        $__root__.createElement(ByTagName('material-button'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('InforbarPO', 'materialButton');
    }
    return returnMe;
  }

  PageLoaderElement get materialIcon {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('InforbarPO', 'materialIcon');
    }
    final element = $__root__.createElement(ByTagName('material-icon'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('InforbarPO', 'materialIcon');
    }
    return returnMe;
  }
}

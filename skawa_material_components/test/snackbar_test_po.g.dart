// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snackbar_test_po.dart';

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
  SnackbarPO get snackbar {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('TestPO', 'snackbar');
    }
    final element =
        $__root__.createElement(ByTagName('skawa-snackbar'), [], []);
    final returnMe = SnackbarPO.create(element);
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('TestPO', 'snackbar');
    }
    return returnMe;
  }

  PageLoaderElement get messageSpan {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('TestPO', 'messageSpan');
    }
    final element = $__root__.createElement(ByTagName('span'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('TestPO', 'messageSpan');
    }
    return returnMe;
  }

  PageLoaderElement get callbackP {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('TestPO', 'callbackP');
    }
    final element = $__root__.createElement(ByTagName('p'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('TestPO', 'callbackP');
    }
    return returnMe;
  }
}

class $SnackbarPO extends SnackbarPO with $$SnackbarPO {
  PageLoaderElement $__root__;
  $SnackbarPO.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([]);
  }
  factory $SnackbarPO.lookup(PageLoaderSource source) =>
      throw "'lookup' constructor for class "
      "SnackbarPO is not generated and can only be used on Page Object "
      "classes that have @CheckTag annotation.";
  static String get tagName =>
      throw '"tagName" is not defined by Page Object "SnackbarPO". Requires @CheckTag annotation in order for "tagName" to be generated.';
}

class $$SnackbarPO {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__; // ignore: unused_field
  PageLoaderElement get $root => $__root__;
  PageLoaderElement get rootElement {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('SnackbarPO', 'rootElement');
    }
    final element = $__root__;
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('SnackbarPO', 'rootElement');
    }
    return returnMe;
  }

  PageLoaderElement get snackbarContainer {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('SnackbarPO', 'snackbarContainer');
    }
    final element = $__root__.createElement(ByTagName('div'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('SnackbarPO', 'snackbarContainer');
    }
    return returnMe;
  }

  PageLoaderElement get messageContainer {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('SnackbarPO', 'messageContainer');
    }
    final element = $__root__.createElement(ByTagName('span'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('SnackbarPO', 'messageContainer');
    }
    return returnMe;
  }

  PageLoaderElement get materialButton {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('SnackbarPO', 'materialButton');
    }
    final element =
        $__root__.createElement(ByTagName('material-button'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('SnackbarPO', 'materialButton');
    }
    return returnMe;
  }
}

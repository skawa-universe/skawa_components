// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt_test.dart';

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
  PageLoaderElement get rootElement {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('TestPO', 'rootElement');
    }
    final element = $__root__;
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('TestPO', 'rootElement');
    }
    return returnMe;
  }

  PromptPO get prompt {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('TestPO', 'prompt');
    }
    final element = $__root__.createElement(ByTagName('skawa-prompt'), [], []);
    final returnMe = PromptPO.create(element);
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('TestPO', 'prompt');
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
}

class $PromptPO extends PromptPO with $$PromptPO {
  PageLoaderElement $__root__;
  $PromptPO.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([]);
  }
  factory $PromptPO.lookup(PageLoaderSource source) =>
      throw "'lookup' constructor for class "
      "PromptPO is not generated and can only be used on Page Object "
      "classes that have @CheckTag annotation.";
  static String get tagName =>
      throw '"tagName" is not defined by Page Object "PromptPO". Requires @CheckTag annotation in order for "tagName" to be generated.';
}

class $$PromptPO {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__; // ignore: unused_field
  PageLoaderElement get $root => $__root__;
  PageLoaderElement get messageP {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('PromptPO', 'messageP');
    }
    final element = $__root__.createElement(ByClass('message'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('PromptPO', 'messageP');
    }
    return returnMe;
  }

  PageLoaderElement get yesButton {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('PromptPO', 'yesButton');
    }
    final element = $__root__.createElement(ByClass('btn-yes'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('PromptPO', 'yesButton');
    }
    return returnMe;
  }

  PageLoaderElement get noButton {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('PromptPO', 'noButton');
    }
    final element = $__root__.createElement(ByClass('btn-no'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('PromptPO', 'noButton');
    }
    return returnMe;
  }
}
